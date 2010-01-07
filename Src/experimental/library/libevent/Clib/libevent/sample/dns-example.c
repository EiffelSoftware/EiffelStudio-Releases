
#include <event-config.h>

#include <sys/types.h>

#ifdef WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#else
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#endif

#include <event2/event.h>
#include <event2/dns.h>
#include <event2/dns_struct.h>
#include <event2/util.h>

#ifdef _EVENT_HAVE_NETINET_IN6_H
#include <netinet/in6.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define u32 ev_uint32_t
#define u8 ev_uint8_t

static const char *
debug_ntoa(u32 address)
{
	static char buf[32];
	u32 a = ntohl(address);
	evutil_snprintf(buf, sizeof(buf), "%d.%d.%d.%d",
					(int)(u8)((a>>24)&0xff),
					(int)(u8)((a>>16)&0xff),
					(int)(u8)((a>>8 )&0xff),
					(int)(u8)((a	)&0xff));
	return buf;
}

static void
main_callback(int result, char type, int count, int ttl,
			  void *addrs, void *orig) {
	char *n = (char*)orig;
	int i;
	for (i = 0; i < count; ++i) {
		if (type == DNS_IPv4_A) {
			printf("%s: %s\n", n, debug_ntoa(((u32*)addrs)[i]));
		} else if (type == DNS_PTR) {
			printf("%s: %s\n", n, ((char**)addrs)[i]);
		}
	}
	if (!count) {
		printf("%s: No answer (%d)\n", n, result);
	}
	fflush(stdout);
}

static void
gai_callback(int err, struct evutil_addrinfo *ai, void *arg)
{
	const char *name = arg;
	struct evutil_addrinfo *ai_first = NULL;
	int i;
	if (err) {
		printf("%s: %s\n", name, evutil_gai_strerror(err));
	}
	if (ai && ai->ai_canonname)
		printf("    %s ==> %s\n", name, ai->ai_canonname);
	for (i=0; ai; ai = ai->ai_next, ++i) {
		char buf[128];
		if (ai->ai_family == PF_INET) {
			struct sockaddr_in *sin =
			    (struct sockaddr_in*)ai->ai_addr;
			evutil_inet_ntop(AF_INET, &sin->sin_addr, buf,
			    sizeof(buf));
			printf("[%d] %s: %s\n",i,name,buf);
		} else {
			struct sockaddr_in6 *sin6 =
			    (struct sockaddr_in6*)ai->ai_addr;
			evutil_inet_ntop(AF_INET6, &sin6->sin6_addr, buf,
			    sizeof(buf));
			printf("[%d] %s: %s\n",i,name,buf);
		}
	}
	if (ai_first)
		evutil_freeaddrinfo(ai_first);
}

static void
evdns_server_callback(struct evdns_server_request *req, void *data)
{
	int i, r;
	(void)data;
	/* dummy; give 192.168.11.11 as an answer for all A questions,
	 *	give foo.bar.example.com as an answer for all PTR questions. */
	for (i = 0; i < req->nquestions; ++i) {
		u32 ans = htonl(0xc0a80b0bUL);
		if (req->questions[i]->type == EVDNS_TYPE_A &&
		    req->questions[i]->dns_question_class == EVDNS_CLASS_INET) {
			printf(" -- replying for %s (A)\n", req->questions[i]->name);
			r = evdns_server_request_add_a_reply(req, req->questions[i]->name,
										  1, &ans, 10);
			if (r<0)
				printf("eeep, didn't work.\n");
		} else if (req->questions[i]->type == EVDNS_TYPE_PTR &&
		    req->questions[i]->dns_question_class == EVDNS_CLASS_INET) {
			printf(" -- replying for %s (PTR)\n", req->questions[i]->name);
			r = evdns_server_request_add_ptr_reply(req, NULL, req->questions[i]->name,
											"foo.bar.example.com", 10);
		} else {
			printf(" -- skipping %s [%d %d]\n", req->questions[i]->name,
				   req->questions[i]->type, req->questions[i]->dns_question_class);
		}
	}

	r = evdns_server_request_respond(req, 0);
	if (r<0)
		printf("eeek, couldn't send reply.\n");
}

static int verbose = 0;

static void
logfn(int is_warn, const char *msg) {
	if (!is_warn && !verbose)
		return;
	fprintf(stderr, "%s: %s\n", is_warn?"WARN":"INFO", msg);
}

int
main(int c, char **v) {
	int idx;
	int reverse = 0, servertest = 0, use_getaddrinfo = 0;
	struct event_base *event_base = NULL;
	struct evdns_base *evdns_base = NULL;
	if (c<2) {
		fprintf(stderr, "syntax: %s [-x] [-v] hostname\n", v[0]);
		fprintf(stderr, "syntax: %s [-servertest]\n", v[0]);
		return 1;
	}
	idx = 1;
	while (idx < c && v[idx][0] == '-') {
		if (!strcmp(v[idx], "-x"))
			reverse = 1;
		else if (!strcmp(v[idx], "-v"))
			verbose = 1;
		else if (!strcmp(v[idx], "-g"))
			use_getaddrinfo = 1;
		else if (!strcmp(v[idx], "-servertest"))
			servertest = 1;
		else
			fprintf(stderr, "Unknown option %s\n", v[idx]);
		++idx;
	}

	event_base = event_base_new();
	evdns_base = evdns_base_new(event_base, 0);
	evdns_set_log_fn(logfn);

	if (servertest) {
		int sock;
		struct sockaddr_in my_addr;
		sock = socket(PF_INET, SOCK_DGRAM, 0);
		evutil_make_socket_nonblocking(sock);
		my_addr.sin_family = AF_INET;
		my_addr.sin_port = htons(10053);
		my_addr.sin_addr.s_addr = INADDR_ANY;
		if (bind(sock, (struct sockaddr*)&my_addr, sizeof(my_addr))<0) {
			perror("bind");
			exit(1);
		}
		evdns_add_server_port_with_base(event_base, sock, 0, evdns_server_callback, NULL);
	}
	if (idx < c) {
#ifdef WIN32
		evdns_base_config_windows_nameservers(evdns_base);
#else
		evdns_base_resolv_conf_parse(evdns_base, DNS_OPTION_NAMESERVERS,
		    "/etc/resolv.conf");
#endif
	}

	printf("EVUTIL_AI_CANONNAME in example = %d\n", EVUTIL_AI_CANONNAME);
	for (; idx < c; ++idx) {
		if (reverse) {
			struct in_addr addr;
			if (evutil_inet_pton(AF_INET, v[idx], &addr)!=1) {
				fprintf(stderr, "Skipping non-IP %s\n", v[idx]);
				continue;
			}
			fprintf(stderr, "resolving %s...\n",v[idx]);
			evdns_base_resolve_reverse(evdns_base, &addr, 0, main_callback, v[idx]);
		} else if (use_getaddrinfo) {
			struct evutil_addrinfo hints;
			memset(&hints, 0, sizeof(hints));
			hints.ai_family = PF_UNSPEC;
			hints.ai_protocol = IPPROTO_TCP;
			hints.ai_flags = EVUTIL_AI_CANONNAME;
			fprintf(stderr, "resolving (fwd) %s...\n",v[idx]);
			evdns_getaddrinfo(evdns_base, v[idx], NULL, &hints,
			    gai_callback, v[idx]);
		} else {
			fprintf(stderr, "resolving (fwd) %s...\n",v[idx]);
			evdns_base_resolve_ipv4(evdns_base, v[idx], 0, main_callback, v[idx]);
		}
	}
	fflush(stdout);
	event_base_dispatch(event_base);
	return 0;
}

