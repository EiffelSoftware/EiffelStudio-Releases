/*

 #####   ######   #####  #####      #    ######  #    #  ######           ####
 #    #  #          #    #    #     #    #       #    #  #               #    #
 #    #  #####      #    #    #     #    #####   #    #  #####           #
 #####   #          #    #####      #    #       #    #  #        ###    #
 #   #   #          #    #   #      #    #        #  #   #        ###    #    #
 #    #  ######     #    #    #     #    ######    ##    ######   ###     ####

	Eiffel retrieve mechanism.
*/

#include "config.h"
#include "portable.h"
#include "macros.h"
#include "malloc.h"
#include "garcol.h"
#include "except.h"
#include "hector.h"
#include "cecil.h"
#include "retrieve.h"
#include "store.h"
#include "bits.h"
#include "run_idr.h"
#include "../parsing/shared/limits.h"

/*#define DEBUG 1 /**/

/*
 * Public data declarations 
 */
public struct htable *rt_table;		/* Table used for solving references */
public int32 nb_recorded;		/* Number of items recorded in Hector */
public char rt_kind;			/* Kind of storable */
extern char *idr_temp_buf;		/*temporary buffer for idr float and double */

/*
 * Private data declaration
 */
private int **dattrib;				/* Pointer to attribute offsets in each object
						 * for independent store */
private int *dtypes;				/* Dynamic types */
private uint32 *spec_elm_size;			/*array of special element sizes*/
private uint32 old_overhead = 0;		/*overhead size from stored object*/
private char * bufer = (char *) 0;		/*buffer for make_header*/

/* Public data declarations */

public int r_fides;			/* File descriptor use for retrieve */

/*
 * Function declations
 */
public char *irt_make();			/* Do the independant retrieve */
public char *irt_nmake();			/* Retrieve n objects  independent form*/
private void iread_header();			/* Read independent header */
private void rt_clean();			/* Clean data structure */
private void rt_update1();			/* Reference correspondance update */
private void rt_update2();			/* Fields updating */
public char *rt_make();				/* Do the retrieve */
public char *rt_nmake();			/* Retrieve n objects */
private void read_header();			/* Read  general header */
extern long get_offset ();			/* get offset of attrib in object*/
private void object_read ();			/* read the individual attributes of the object*/
private long get_expanded_pos ();



#define GEN_MAX	4		/* Maximum number of generic parameters */

/* read function declarations */
int retrieve_read ();
int old_retrieve_read ();

int (*retrieve_read_func)() = retrieve_read;

/*
 * Function definitions
 */



public char *eretrieve(file_desc)
EIF_INTEGER file_desc;
{
	/* Retrieve object store in file `filename' */

	char *retrieved;
	char rt_type;

	/* Open file */
	r_fides = file_desc;


	/* Read the kind of stored hierachy */
	if ((read (r_fides, &rt_type, (sizeof(char)))) < sizeof (char))
		eio();

	/* set rt_kind depending on the type to be retrieved */

	switch (rt_type) {
		case '\0':			/*old basic store */
			retrieve_read_func = old_retrieve_read;
		case '\02':			/* New basic store */
			allocate_gen_buffer ();
			rt_kind = '\0';
			break;
		case '\01': 			/* Old general store */
			retrieve_read_func = old_retrieve_read;
		case '\03':			/* New General store */
			allocate_gen_buffer ();
			rt_kind = '\01';
			break;
		case '\04':			/* New Independent store */
			run_idr_init ();
			rt_kind = '\02';
			idr_temp_buf = (char *) xmalloc (48, C_T, GC_OFF);
			if (idr_temp_buf == (char *)0)
				xraise (EN_MEM);
			dattrib = (int **) xmalloc (scount * sizeof (int *), C_T, GC_OFF);
			if (dattrib == (int **)0)
				xraise (EN_MEM);
			bzero ((char *)dattrib, scount * sizeof (int *));
			break;
		default: 			/* If not one of the above, error!! */
			eraise("invalid retrieve type", EN_RETR);	
	}
			

#ifdef DEBUG
		printf ("\n %d", rt_kind);
#endif


	if (rt_kind == '\02') {
		iread_header();					/* Make correspondance table */
		retrieved = irt_make();
	} else {
		if (rt_kind)
			read_header();			/* Make correspondance table */

		/* Retrieve */
		retrieved = rt_make();
	}

	if (rt_kind)
		xfree(dtypes);					/* Free the correspondance table */
	if (rt_kind == '\02')
		xfree(spec_elm_size);					/* Free the element size table */

	ht_free(rt_table);					/* Free hash table descriptor */
	epop(&hec_stack, nb_recorded);		/* Pop hector records */
	switch (rt_type) {
		case '\0':
			retrieve_read_func = retrieve_read;
			break;
		case '\01': 
			retrieve_read_func = retrieve_read;
			break;
		case '\04': {
			int i;

			run_idr_destroy ();
			xfree (idr_temp_buf);
			idr_temp_buf = (char *) 0;
			for (i = 0; i < scount; i++) {
				if (*(dattrib + i))
					xfree (*(dattrib +i));
			}
			xfree (dattrib);
			dattrib = (int  **) 0;
			break;
		}
	}

	return retrieved;
}


public char *rt_make()
{
	/* Make the retrieve of all objects in file */
	long objectCount;

	/* Read the object count in the file header */
	buffer_read(&objectCount, (sizeof(long)));

#if DEBUG & 2
		printf ("\n %ld", objectCount);
#endif


	return rt_nmake(objectCount);
}


public char *rt_nmake(objectCount)
long objectCount;
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */

	long nb_char;
	char *oldadd;
	char *newadd = (char *) 0;
	EIF_OBJ new_hector;
	uint32 flags;
	uint32 spec_size = 0;
	char g_status = g_data.status;
	jmp_buf exenv;

#if DEBUG & 2
/*	long saved_objectCount = objectCount;
	extern long nomark();

	if (objectCount == 0)
		panic("no object to retrieve");*/
#endif
	excatch((char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		ereturn();				/* Propagate exception */
	}

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_table = (struct htable *) xmalloc(sizeof(struct htable), C_T, GC_OFF);
	if (rt_table == (struct htable *) 0)
		xraise(EN_MEM);
	if (-1 == ht_create(rt_table, objectCount, sizeof(struct rt_struct)))
		xraise(EN_MEM);
	ht_zero(rt_table);

	for (;objectCount > 0; objectCount--) {
		/* Read object address */

		buffer_read(&oldadd, (sizeof(char *)));

#if DEBUG & 2
		printf ("\n  %lx", oldadd);
#endif


		/* Read object flags (dynamic type) */
		buffer_read(&flags, (sizeof(uint32)));

#if DEBUG & 2
		printf (" %x", flags);
#endif


		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;

			/* Special object: read the saved size */
			buffer_read(&spec_size, (sizeof(uint32)));
			nb_char = (spec_size & B_SIZE) * sizeof(char);
			newadd = spmalloc(nb_char);
			if (rt_kind) {
				HEADER(newadd)->ov_flags |= dtypes[flags & EO_TYPE] |
							(flags & (EO_REF|EO_COMP));
			} else
				HEADER(newadd)->ov_flags |= flags & (EO_REF|EO_COMP|EO_TYPE);
		} else {
			/* Normal object */
			if (rt_kind) {
				nb_char = Size((uint16)(dtypes[flags & EO_TYPE]));
				newadd = emalloc(dtypes[flags & EO_TYPE]); 
			} else {
				nb_char = Size((uint16)(flags & EO_TYPE));
				newadd = emalloc(flags & EO_TYPE);
			}
		}
		
		/* Creation of the Eiffel object */	
		if (newadd == (char *) 0)
			xraise(EN_MEM);

		/* Stop in the garbage collector because we have know an unstable
		 * object. */
		g_data.status |= GC_STOP;

		/* Record the new object in hector table */
		new_hector = hrecord(newadd);
		nb_recorded++;

		/* Update unsolved references on `newadd' */
		rt_update1 (oldadd, new_hector);

		/* Read the object's body */
		buffer_read(newadd, (int)(sizeof(char) * nb_char));

		/* Update fileds: the garbage collector should not be called
		 * during `rt_update2' because the object is in a very unstable
		 * state.
		 */
		rt_update2(oldadd, newadd, newadd);

		/* Restore garbage collector status */
		g_data.status = g_status;
	}
	expop(&eif_stack);
#if DEBUG & 2
		/* Consistency check: no more unsolved references and
		 * `objectCount' solved references. */
/*
	{
		long nb_retrieved = 0L;
		struct rt_struct *rt_info = (struct rt_struct *) rt_table->h_values;
		int32 count = rt_table->h_size;

		for (; count > 0; count--, rt_info++) {
			if (
					rt_info->rt_status == UNSOLVED &&
					rt_info->rt_list != (struct rt_cell *) 0) {
				panic("retrieve incomplete");
			}
			if (rt_info->rt_status == SOLVED)
				nb_retrieved++;
		}
		if (nb_retrieved != saved_objectCount)
			panic("retrieve failure");
		if (saved_objectCount != nomark(newadd))
			panic("retrieve inconsistecy");
	} */
#endif
	return newadd;
}

public char *irt_make()
{
	/* Make the retrieve of all objects in file */
	long objectCount;

	/* Read the object count in the file header */
	ridr_multi_int (&objectCount, 1);

#if DEBUG & 1
		printf ("\n %ld", objectCount);
#endif


	return irt_nmake(objectCount);
}

public char *irt_nmake(objectCount)
long objectCount;
{
	/* Make the retrieve of `objectCount' objects.
	 * Return pointer on retrived object.
	 */

	long nb_char;
	char *oldadd;
	char *newadd = (char *) 0;
	EIF_OBJ new_hector;
	uint32 flags;
	uint32 spec_size = 0;
	char g_status = g_data.status;
	jmp_buf exenv;

#if DEBUG & 1
/*	long saved_objectCount = objectCount;
	extern long nomark();

	if (objectCount == 0)
		panic("no object to retrieve");*/
#endif
	excatch((char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		ereturn();				/* Propagate exception */
	}

	/* Initialization of the hash table */
	nb_recorded = 0;
	rt_table = (struct htable *) xmalloc(sizeof(struct htable), C_T, GC_OFF);
	if (rt_table == (struct htable *) 0)
		xraise(EN_MEM);
	if (-1 == ht_create(rt_table, objectCount, sizeof(struct rt_struct)))
		xraise(EN_MEM);
	ht_zero(rt_table);

	for (;objectCount > 0; objectCount--) {
		/* Read object address */
		ridr_multi_any (&oldadd, 1);

#if DEBUG & 1
		printf ("\n  %lx", oldadd);
#endif


		/* Read object flags (dynamic type) */
		ridr_norm_int (&flags);

#if DEBUG & 1
		printf (" %x", flags);
#endif


		/* Read a possible size */
		if (flags & EO_SPEC) {
			uint32 count, elm_size;
			uint32 dgen, spec_type;
			struct gt_info *info;
			char *vis_name;

			spec_type = dtypes[flags & EO_TYPE];
			vis_name = System(spec_type).cn_generator;


			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, :
			 *    "dtype visible_name size nb_generics {meta_type}+"
			 */
				int16 *gt_type = info->gt_type;
				int32 *gt_gen;
				int nb_gen = info->gt_param;
	
				for (;;) {
#if DEBUG & 1
					if (*gt_type == SK_INVALID)
						panic("corrupted cecil table");
#endif
					if ((*gt_type++ & SK_DTYPE) == (int16) spec_type)
						break;
				}
				gt_type--;
				gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
				dgen = *gt_gen;
			}

			if (!((dgen & SK_HEAD) == SK_EXP)) {
				switch (dgen) {
					case SK_INT:
						spec_size = sizeof (EIF_INTEGER);
						break;
					case SK_CHAR:
						spec_size = sizeof (EIF_CHARACTER);
						break;
					case SK_BOOL:
						spec_size = sizeof (EIF_BOOLEAN);
						break;
					case SK_FLOAT:
						spec_size = sizeof (EIF_REAL);
						break;
					case SK_DOUBLE:
						spec_size = sizeof (EIF_DOUBLE);
						break;
					case SK_POINTER:
						spec_size = sizeof (EIF_POINTER);
						break;
					case SK_DTYPE:
					case SK_REF:
						spec_size = sizeof (EIF_OBJ);
						break;
					default:
						if (dgen & SK_BIT) 
							spec_size = BITOFF(dgen & SK_DTYPE);
						else
							eio();
				}
			} else {
				spec_size = Size((uint16)(dgen & SK_DTYPE)) + OVERHEAD;
			}
			ridr_norm_int (&count);
			nb_char = CHRPAD(count * spec_size ) + LNGPAD(2);
			ridr_norm_int (&elm_size);

#if DEBUG & 1
		printf (" %x", count);
		printf (" %x", elm_size);
#endif
			newadd = spmalloc(nb_char);
			{
				long * o_ref;

				o_ref = (long *) (newadd + (HEADER(newadd)->ov_size & B_SIZE) - LNGPAD(2));
				*o_ref++ = count; 		
				*o_ref = spec_size;
				spec_elm_size[dtypes[flags & EO_TYPE]] = elm_size;
			} 
			HEADER(newadd)->ov_flags |= dtypes[flags & EO_TYPE] |
							(flags & (EO_REF|EO_COMP));
		} else {
			/* Normal object */
			nb_char = Size((uint16)(dtypes[flags & EO_TYPE]));
			newadd = emalloc(dtypes[flags & EO_TYPE]); 
		}
		
		/* Creation of the Eiffel object */	
		if (newadd == (char *) 0)
			xraise(EN_MEM);

		/* Stop in the garbage collector because we have know an unstable
		 * object. */
		g_data.status |= GC_STOP;

		/* Record the new object in hector table */
		new_hector = hrecord(newadd);
		nb_recorded++;

		/* Update unsolved references on `newadd' */
		rt_update1 (oldadd, new_hector);

		/* Read the object's body */
		object_read (newadd, newadd);

		/* Update fileds: the garbage collector should not be called
		 * during `rt_update2' because the object is in a very unstable
		 * state.
		 */
		rt_update2(oldadd, newadd, newadd);

		/* Restore garbage collector status */
		g_data.status = g_status;
	}
	expop(&eif_stack);
#if DEBUG & 1
		/* Consistency check: no more unsolved references and
		 * `objectCount' solved references. */
/*
	{
		long nb_retrieved = 0L;
		struct rt_struct *rt_info = (struct rt_struct *) rt_table->h_values;
		int32 count = rt_table->h_size;

		for (; count > 0; count--, rt_info++) {
			if (
					rt_info->rt_status == UNSOLVED &&
					rt_info->rt_list != (struct rt_cell *) 0) {
				panic("retrieve incomplete");
			}
			if (rt_info->rt_status == SOLVED)
				nb_retrieved++;
		}
		if (nb_retrieved != saved_objectCount)
			panic("retrieve failure");
		if (saved_objectCount != nomark(newadd))
			panic("retrieve inconsistecy");
	} */
#endif
	return newadd;
}

private void rt_clean()
{
	/* Raise an exception of code `code' after having cleaned the hash table */
	/* and allocated memory and reset function pointers. */

	struct rt_struct *rt_info;

	if (rt_table != (struct htable *) 0) {
		struct rt_struct *rt_info = (struct rt_struct *) rt_table->h_values;
		int32 count = rt_table->h_size;

		for (; count > 0; count--, rt_info++) {
			if (rt_info->rt_status == UNSOLVED) {	/* Free cell list */
				struct rt_cell *cell, *next_cell;

				cell = rt_info->rt_list;
				while (cell != (struct rt_cell *) 0) {
					next_cell = cell->next;
					xfree(cell);
					cell = next_cell;
				}
			}
		}
		ht_free(rt_table);						/* Free hash table descriptor */
	}
	if (dtypes != (int *) 0) {
		xfree(dtypes);
		dtypes = (int *) 0;
	}
	if (spec_elm_size != (uint32 *)0) {
		xfree(spec_elm_size);
		spec_elm_size = (uint32 *)0;
	}

	if (bufer != (char *)0) {
		xfree (bufer);
		bufer = (char *) 0;
	}
	epop(&hec_stack, nb_recorded);				/* Pop hector records */
	if (rt_kind == '\02') {
		run_idr_destroy ();
		if (!(idr_temp_buf == (char *)0)) {
			xfree (idr_temp_buf);
			idr_temp_buf = (char *)0;
		}
		if (!(dattrib == (int **) 0)) {
			int i;

			for (i = 0; i < scount; i++) {
				if (*(dattrib + i))
					xfree (*(dattrib +i));
			}
			xfree (dattrib);
			dattrib = (int **) 0;
		}
	}
	retrieve_read_func = retrieve_read;
}

private void rt_update1 (old, new)
register4 char *old;
register3 EIF_OBJ new;
{
	/* `new' is hector pointer to a retrieved object. We have to solve
	 * possible references with it, before putting it in the hash table.
	 */

	unsigned long key = ((unsigned long) old) - 1;	/* Key in the hash table */
	unsigned long solved_key;
	long offset;
	struct rt_struct *rt_info, *rt_solved;
	struct rt_cell *rt_unsolved, *next;
	char *client, *supplier;
	

	rt_info = (struct rt_struct *) ht_first(rt_table, key);

#ifdef MAY_PANIC
	if (rt_info->rt_status == SOLVED)
		panic("cannot already be solved");
#endif

	/* First, solve references if any. */
	rt_unsolved = rt_info->rt_list;
	while (rt_unsolved != (struct rt_cell *) 0) {
		next = rt_unsolved->next;

		solved_key = rt_unsolved->key;	/* Key to the solved objcet */
		offset = rt_unsolved->offset;	/* Offset in the solved object */
		rt_solved = (struct rt_struct *) ht_value(rt_table, solved_key);

#ifdef MAY_PANIC
		if (
			rt_solved == (struct rt_struct *) 0
			|| rt_solved->rt_status != SOLVED
		)
			panic("should be solved");
#endif

		/* Attachement to hector pointer dereference */
		client = eif_access(rt_solved->rt_obj);
		supplier = eif_access(new);
		RTAS(supplier, client);					/* Age check */
		*(char **)(client + offset) = supplier;	/* Attachment */
	
		xfree(rt_unsolved);		/* Free reference solving cell */
		rt_unsolved = next;	
	}

	/* Put the new hector pointer as a olved reference in the hash table */
	rt_info->rt_status = SOLVED;
	rt_info->rt_obj = new;
}

private void rt_update2(old, new, parent)
char *old, *new, *parent;
{
	/* Reference field updating: record new unsolved references.
	 * The third argument is needed because of expanded objects:
	 * if `new' is not an expanded object,parent is equal to it. */

	long nb_references;
	uint32 flags;
	char *reference;
	union overhead *zone = HEADER(new);
	char* addr;
	long size;				/* New object size */
	struct rt_struct *rt_info;

	flags = zone->ov_flags;
	if (flags & EO_SPEC) {				/* Special object */
		char *o_ref;
		long count, elem_size, old_elem_size;

		if (!(flags & EO_REF))			/* Special without references */
			return;

		size = zone->ov_size & B_SIZE;	
		o_ref = (char *) (new + size - LNGPAD(2));
		count = *(long *) o_ref; 		
		if (!(flags & EO_COMP)) {		/* Special of references */
			nb_references = count;
			goto update;
		} else {						/* Special of expanded objects */
			char *old_addr;

			elem_size = *(long *) (o_ref + sizeof(long));
			if (rt_kind != '\02') {
				old_overhead = OVERHEAD;
				old_elem_size = elem_size;
			} else
				old_elem_size = spec_elm_size[flags & EO_TYPE];

			for (	addr = new + OVERHEAD, old_addr = old + old_overhead;
					count>0 ;
					count--, addr += elem_size, old_addr += old_elem_size) {
				rt_update2(old_addr, addr, parent);
			}
		}
	} else {							  /* Normal object */
		nb_references = References(flags & EO_TYPE);
		size = Size(flags & EO_TYPE);
	}

update:
	/* Update references */
	for (addr = new; 	nb_references > 0;
			nb_references--, addr = (char *)(((char **) addr) + 1)) {
		int total_ref = nb_references;

		/* *(char **)new is a pointer an a stored object: check if
		 * the corresponding reference is already in the hash table
		 */
		reference = *(char **)addr;
		if (reference == 0)
			continue;
		if (System(flags & EO_TYPE).cn_nbattr) {
			if (((System(flags & EO_TYPE).cn_types[total_ref - nb_references]) & SK_HEAD) == SK_EXP) {
				/* This is an internal expanded reference */
				long new_offset;
				long offset = reference - old;
	
				if (rt_kind == '\02') {
					new_offset = get_expanded_pos (flags & EO_TYPE, (uint32)(total_ref - nb_references));
				} else
					new_offset = offset;
	
				*(char **) addr = new + new_offset;				/* Expanded reference */
				if (rt_kind) {
					uint32 old_flags = HEADER(new + new_offset)->ov_flags;
					HEADER(new + new_offset)->ov_flags &= ~EO_TYPE;
					HEADER(new + new_offset)->ov_flags |= dtypes[old_flags & EO_TYPE];
				}
				rt_update2(old + offset, new + new_offset, parent);	/* Recursion */
				continue;
			} 
		} 
		{
			struct rt_struct *rt_info;
			unsigned long key = ((unsigned long) reference) - 1;
			char *supplier;

			rt_info = (struct rt_struct *) ht_first(rt_table, key);
			if (rt_info->rt_status == SOLVED) {
				/* Reference is already solved */
				supplier = eif_access(rt_info->rt_obj);
				RTAS(supplier, new);						/* Age check */
				*(char **) addr = supplier;					/* Attachment */
			} else {
				/* Reference is stil unsolved */
				struct rt_cell *new_cell, *old_cell;

				new_cell = (struct rt_cell *) xmalloc(sizeof(struct rt_cell), C_T, GC_OFF);
				if (new_cell == (struct rt_cell *)0)
					xraise (EN_MEM);
				new_cell->key = ((unsigned long) old) - 1;
				new_cell->offset = (long) (addr - parent);
				old_cell = rt_info->rt_list;
				new_cell->next = old_cell;
				rt_info->rt_list = new_cell;
				rt_info->rt_status = UNSOLVED;
				*(char **) addr = (char *) 0; 
						/* Set to zero the unsolved reference
						 * in order to put the object in a
						 * stable state. */
			}
		}
	}
}


private char *next_item (ptr)
char * ptr;
{
	int first_char = 0;

	for (;;) {
		if (!(isspace(*ptr)) && !first_char ) 
			first_char = 1;
		else if (isspace(*ptr) && first_char)
			break;
		ptr++;
	}
	return (ptr);
}

private void read_header()
{
	/* Read header and make the dynamic type correspondance table */
	int nb_lines, i, k, old_count;
	extern int errno;
	int dtype, new_dtype;
	long size;
	int nb_gen, bsize = 1024;
	char vis_name[512], end;
	char * temp_buf;
	jmp_buf exenv;

	errno = 0;

	excatch((char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		ereturn();				/* Propagate exception */
	}
	bufer = (char*) xmalloc (bsize * sizeof (char), C_T, GC_OFF);
	if (bufer == (char *)0)
		xraise (EN_MEM);

	/* Read the old maximum dyn type */
	if (readline(bufer, &bsize) <= 0)
		eio();
	if (sscanf(bufer,"%d\n", &old_count) != 1)
		eio();
	/* create a correspondance table */
	dtypes = (int *) xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == (int *) 0)
		xraise(EN_MEM);

	/* Read the number of lines */
	if (readline(bufer, &bsize) <= 0)
		eio();
	if (sscanf(bufer,"%d\n", &nb_lines) != 1)
		eio();

	for(i=0; i<nb_lines; i++) {
		if (readline(bufer, &bsize) <= 0)
			eio();

		temp_buf = bufer;

		if (
			4 != sscanf(bufer, "%d %s %ld %d",&dtype,vis_name,&size,&nb_gen)
		)
			eio();

		for (k = 1 ; k <= 4 ; k++)
			temp_buf = next_item (temp_buf);

		if (nb_gen > 0) {
			struct gt_info *info;
			int32 *t;
			int matched;
			int j, index;
			long gtype[GEN_MAX];
			int32 itype[GEN_MAX];
	

			/* Generic class */
			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info == (struct gt_info *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */

			if (info->gt_param != nb_gen)
				eraise(vis_name, EN_RETR);	/* No good generic count */

			for (j=0; j<nb_gen; j++) {		/* Read meta-types */
				if (sscanf(temp_buf," %ld", &gtype[j]) != 1)
					eio();
				temp_buf = next_item (temp_buf);
					
			}

			for (t = info->gt_gen; /* empty */; /* empty */) {

				if (*t == SK_INVALID)		/* Cannot find good meta-type */
					eraise(vis_name, EN_RETR);

				matched = 1;			/* Assume a perfect match */
				for (j=0; j<nb_gen; j++) {
					int32 gt;

					gt = (int32) gtype[j];
					itype[j] = *t++;
					if (itype[j] != gt)	/* Matching done on the fly */
						matched = 0;	/* The types do not match */
				}
				if (matched) {			/* We found the type */
					t -= nb_gen;
					break;			/* End of loop processing */
				}
			}
			index = (int) ((t - info->gt_gen) / nb_gen);
			new_dtype = info->gt_type[index] & SK_DTYPE;
		} else {
			int32 *addr;

			/* Non generic class */
			addr = (int32 *) ct_value(&ce_type, vis_name);
			if (addr == (int32 *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			new_dtype = *addr & SK_DTYPE;
		}
		if (Size(new_dtype) != size) {
			eraise(vis_name, EN_RETR);		/* No good size */
		}
		dtypes[dtype] = new_dtype;
	}
	xfree (bufer);
	bufer = (char *) 0;
}


private void iread_header()
{
	/* Read header and make the dynamic type correspondance table */
	int nb_lines, i, k, old_count;
	extern int errno;
	int dtype, new_dtype;
	int nb_gen, bsize = 1024;
	char vis_name[512], end;
	char * temp_buf;
	uint32 num_attrib;
	long read_attrib;
	char att_name[IDLENGTH + 1];
	int *attrib_order = (int *)0;
	jmp_buf exenv;

	errno = 0;

	excatch((char *) exenv);	/* Record pseudo execution vector */
	if (setjmp(exenv)) {
		rt_clean();				/* Clean data structure */
		ereturn();				/* Propagate exception */
	}

	bufer = (char*) xmalloc (bsize * sizeof (char), C_T, GC_OFF);
	if (bufer == (char *) 0)
		xraise (EN_MEM);

	/* Read the old maximum dyn type */
	if (idr_read_line(bufer, bsize) <= 0)
		eio();
	if (sscanf(bufer,"%d\n", &old_count) != 1)
		eio();
	/* create a correspondance table */
	dtypes = (int *) xmalloc(old_count * sizeof(int), C_T, GC_OFF);
	if (dtypes == (int *)0)
		xraise (EN_MEM);
	spec_elm_size = (uint32 *) xmalloc (old_count * sizeof (uint32), C_T, GC_OFF);
	if (spec_elm_size == (uint32 *)0)
		xraise (EN_MEM);
	if (idr_read_line(bufer, bsize) <= 0)
		eio();
	if (sscanf(bufer,"%d\n", &old_overhead) != 1)
		eio();
	if (dtypes == (int *) 0)
		xraise(EN_MEM);

	/* Read the number of lines */
	if (idr_read_line(bufer, bsize) <= 0)
		eio();
	if (sscanf(bufer,"%d\n", &nb_lines) != 1)
		eio();

	for(i=0; i<nb_lines; i++) {
		if (idr_read_line(bufer, bsize) <= 0)
			eio();

		temp_buf = bufer;

		if (3 != sscanf(bufer, "%d %s %d",&dtype,vis_name,&nb_gen))
			eio();

		for (k = 1 ; k <= 3 ; k++)
			temp_buf = next_item (temp_buf);

		if (nb_gen > 0) {
			struct gt_info *info;
			int32 *t;
			int matched;
			int j, index;
			long gtype[GEN_MAX];
			int32 itype[GEN_MAX];
	

			/* Generic class */
			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info == (struct gt_info *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */

			if (info->gt_param != nb_gen)
				eraise(vis_name, EN_RETR);	/* No good generic count */

			for (j=0; j<nb_gen; j++) {		/* Read meta-types */
				if (sscanf(temp_buf," %ld", &gtype[j]) != 1)
					eio();
				temp_buf = next_item (temp_buf);
					
			}

			for (t = info->gt_gen; /* empty */; /* empty */) {

				if (*t == SK_INVALID)		/* Cannot find good meta-type */
					eraise(vis_name, EN_RETR);

				matched = 1;					/* Assume a perfect match */
				for (j=0; j<nb_gen; j++) {
					int32 gt;

					gt = (int32) gtype[j];
					itype[j] = *t++;
					if (itype[j] != gt)	/* Matching done on the fly */
						matched = 0;			/* The types do not match */
				}
				if (matched) {					/* We found the type */
					t -= nb_gen;
					break;						/* End of loop processing */
				}
			}
			index = (int) ((t - info->gt_gen) / nb_gen);
			new_dtype = info->gt_type[index] & SK_DTYPE;
		} else {
			int32 *addr;

			/* Non generic class */
			addr = (int32 *) ct_value(&ce_type, vis_name);
			if (addr == (int32 *) 0)
				eraise(vis_name, EN_RETR);	/* Cannot find class */
			new_dtype = *addr & SK_DTYPE;
		}

								/* retrieve the number of attributes
								 * int the object 
								 */
		if (sscanf(temp_buf," %d", &num_attrib) != 1)
			eio();					/* error no value in buffer */

								/* Check the number of attributes
								 * match then verify the attributes
								 * types and names. Then store the
								 * position of the attribute in the
								 * object.
								 */
		if (num_attrib == System(new_dtype).cn_nbattr) {
			int i, chk_attrib = num_attrib;

			if (num_attrib != 0) {			/* Only malloc memory and process if 
								 * the object has attributes.
								 */
				attrib_order = (int *) xmalloc (num_attrib * sizeof (int), C_T, GC_OFF);
				if (attrib_order == (int *)0)
					xraise (EN_MEM);
				for (; num_attrib > 0;) {
					if (idr_read_line(bufer, bsize) <= 0) {
						xfree (attrib_order);
						eio();
					}
					if (sscanf(bufer," %lu %s", &read_attrib, att_name) != 2) {
						xfree (attrib_order);
						eio();
					}
								/* check attribute types */
					if ((*(System(new_dtype).cn_types + --num_attrib) & SK_HEAD) 
							== (uint32) read_attrib) {

									/* check attribute names */
						if (strcmp (att_name, 
								*(System (new_dtype).cn_names + num_attrib))) {
							i = 0;
	
							while (strcmp(att_name, 
									*(System (new_dtype).cn_names + i++))) {
								if (i > chk_attrib){
                                			        	xfree (attrib_order);
                                 				       	eraise(vis_name, EN_RETR); 
							             	/* non matching attributes */
                                				}
							
							}
									/* check that the attribues of the
									 * same name is of the same type
									 */

							if ((*(System(new_dtype).cn_types + --i) & SK_HEAD) 
									== (uint32) read_attrib) {
								*(attrib_order + num_attrib) = i;
							} else {
								xfree (attrib_order);
								eraise(vis_name, EN_RETR);
                                                                     	/* non matching attributes */
							}
						} else {
							*(attrib_order + num_attrib) = num_attrib;
						}
					} else {
						xfree (attrib_order);
						eraise(vis_name, EN_RETR);	/* non matching attributes */
					}
				}
			}
		} else {
			eraise(vis_name, EN_RETR);		/* wrong number of attributes */
		}
		dtypes[dtype] = new_dtype;			/* store new type on old type */
		dattrib [new_dtype] = attrib_order;		/* store position of attribute in obj*/
		attrib_order = (int *) 0;			/* make sure its null for next loop */
	}
	xfree (bufer);
	bufer = (char*) 0;
}


private int readline (ptr, maxlen)
register char * ptr;
register int *maxlen;
{
	int num_char, read_char;
	char c;

	for (num_char = 1; num_char < *maxlen; num_char ++) {
		if ((read_char = buffer_read(&c, sizeof (char))) == (sizeof (char))) {
			*ptr++ = c;
			if (c == '\n') {
				break;
			}
		}
		else if (read_char == 0) {
			if (num_char == 1) {
				return (0);
			}
			else {
				break;
			}
		}
		else {
			return (-1);
		}
	}
	*ptr = '\0';
	return (num_char);
}
		
			
private int direct_read (object, size)
register char * object;
int size;
{
	int i, amount = 0;
	char *buf = object;

	while (amount < size) {
		i = read (r_fides, buf, size - amount);
		if (i < 0)
			eio();
		amount += i;
		buf += i;
	}
	return amount;
}

		
			
private int buffer_read (object, size)
register char * object;
int size;
{
	register i;

#if DEBUG & 2
	printf ("Current position %d\n", current_position);
	printf ("Size %d\n", size);
	printf ("end_of_buffer %d\n", end_of_buffer);
#endif

	if (current_position + size >= end_of_buffer) {
		for (i = 0; i < size ; i++) {
			if (current_position >= end_of_buffer)
				if ((retrieve_read_func() == 0) && size != i + 1)
					eraise("incomplete file" , EN_RETR);
			*(object++) = *(general_buffer + current_position++);
		}
	} else {

		for (i = 0; i < size ; i++) {
			*(object++) = *(general_buffer + current_position++);
		}
	}
	return (i);
}



public int old_retrieve_read ()
{
	char * ptr = general_buffer;

	end_of_buffer = read (r_fides, ptr, buffer_size);
	if (end_of_buffer < 0)
		eio();

	current_position = 0;
	return (end_of_buffer);
}

public int retrieve_read ()
{
	char * ptr = general_buffer;
	short read_size;
	int part_read = 0, total_read = 0;

	end_of_buffer = 0;
	if ((read (r_fides, &read_size, sizeof (short))) < sizeof (short))
                eio();
	while (end_of_buffer < read_size) {
		part_read = read (r_fides, ptr, read_size);
		if (part_read < 0)
			eio();
		end_of_buffer += part_read;
		ptr += part_read;
	}
	current_position = 0;
	return (end_of_buffer);
}




private void object_read (object, parent)
char * object, * parent;
{
	long attrib_offset;
	int z;
	uint32 o_type;
	uint32 num_attrib;
	uint32 flags = HEADER(object)->ov_flags;
	int *attrib_order;

	o_type = flags & EO_TYPE;
	num_attrib = System(o_type).cn_nbattr;
	attrib_order = dattrib[o_type];

	if (num_attrib > 0) {
		for (; num_attrib > 0;) {
			uint32 types_cn;

			attrib_offset = get_offset(o_type, attrib_order[--num_attrib]);
			types_cn = *(System(o_type).cn_types + num_attrib);

			switch (types_cn & SK_HEAD) {
				case SK_INT:
					ridr_multi_int (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %lx", *((long *)(object + attrib_offset)));
#endif

					break;
				case SK_BOOL:
				case SK_CHAR:
					ridr_multi_char (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %lx", *((char *)(object + attrib_offset)));
#endif

					break;
				case SK_FLOAT:
					ridr_multi_float (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %f", *((float *)(object + attrib_offset)));
#endif

					break;
				case SK_DOUBLE:
					ridr_multi_double (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %lf", *((double *)(object + attrib_offset)));
#endif

					break;
				case SK_BIT:
						{
							int q;
							uint32 old_flags;
							struct bit *bptr = (struct bit *)(object + attrib_offset);

							HEADER(bptr)->ov_flags = bit_dtype;
							ridr_norm_int (&old_flags);
							HEADER(bptr)->ov_flags |= old_flags & (EO_COMP | EO_REF);

							ridr_multi_bit (bptr, 1, NULL);
							if ((types_cn & SK_DTYPE) != LENGTH(bptr))
								eio();
#if DEBUG & 1
							printf (" %x", (bptr->b_length));
							printf (" %x", old_flags);
							for (q = 0; q < BIT_NBPACK( LENGTH(bptr)) ; q++) {
								printf (" %lx", *((uint32 *)(bptr->b_value + q)));
								if (!(q % 40))
									printf ("\n");
							}
#endif
						}

					break;
				case SK_EXP: {
					uint32  old_flags;
					long size_count;

					ridr_multi_any (object + attrib_offset, 1);
					ridr_norm_int (&old_flags);
					size_count = get_expanded_pos (o_type, num_attrib);

#if DEBUG & 1
					printf ("\n %lx", *((char **)(object + attrib_offset)));
					printf (" %lx", old_flags);
#endif
					HEADER(object + size_count)->ov_flags = (old_flags & (EO_REF|EO_COMP|EO_TYPE));
					HEADER(object + size_count)->ov_size = (uint32)(get_expanded_pos (o_type, -1) + (object - parent));
					object_read (object + size_count, parent);						

					}
					break;
				case SK_REF:
				case SK_POINTER:
					ridr_multi_any (object + attrib_offset, 1);
#if DEBUG & 1
					printf (" %lx", *((char **)(object + attrib_offset)));
#endif
					break;

				default:
					eio();
			}
		} 
	} else {
		if (flags & EO_SPEC) {		/* Special object */
			long count, elem_size;
			char *ref, *o_ptr;
			char *vis_name;
			uint32 dgen;
			struct gt_info *info;

			o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD(2));
			count = *(long *) o_ptr;
			vis_name = System(o_type).cn_generator;


			info = (struct gt_info *) ct_value(&ce_gtype, vis_name);
			if (info != (struct gt_info *) 0) {	/* Is the type a generic one ? */
			/* Generic type, :
			 *    "dtype visible_name size nb_generics {meta_type}+"
			 */
				int16 *gt_type = info->gt_type;
				int32 *gt_gen;
				int nb_gen = info->gt_param;
	
				for (;;) {
#if DEBUG & 1
					if (*gt_type == SK_INVALID)
						panic("corrupted cecil table");
#endif
					if ((*gt_type++ & SK_DTYPE) == (int16) o_type)
						break;
				}
				gt_type--;
				gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
				dgen = *gt_gen;
			}
	
			if (!(flags & EO_REF)) {			/* Special of simple types */
				switch (dgen & SK_HEAD) {
					case SK_INT:
						ridr_multi_int ((long *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((long *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_BOOL:
					case SK_CHAR:
						ridr_multi_char (object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *((char *)(object + z)));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_FLOAT:
						ridr_multi_float ((float *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %f", *(((float *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;
					case SK_DOUBLE:
						ridr_multi_double ((double *)object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lf", *(((double *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif
						break;
					case SK_EXP: {
						uint32  old_flags;

						elem_size = *(long *) (o_ptr + sizeof(long));
						ridr_norm_int (&old_flags);
						for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
	
#if DEBUG & 1
							printf (" %x", old_flags);
#endif
							HEADER(ref)->ov_flags = (old_flags & (EO_REF|EO_COMP|EO_TYPE));
							HEADER(ref)->ov_size = (uint32)(ref - parent);
							object_read (ref, parent);						
	
						}
					}
						break;
					case SK_BIT: {
						uint32 l;

						elem_size = *(long *) (o_ptr + sizeof(long));
						ridr_multi_bit ((struct bit *)object, count, elem_size);
#if DEBUG & 1
						printf (" %x", l);

                                                for (ref = object; count > 0; count--, ref += elem_size ) {
                                                        int q;
                                                        for (q = 0; q < BIT_NBPACK(l) ; q++) {
								printf (" %lx", *((uint32 *)(((struct bit *)ref)->b_value + q)));
								if (!(q % 40))
									printf ("\n");
							}
							printf ("\n");
						}
#endif
					}
						break;
					case SK_POINTER:
						ridr_multi_any (object, count);
#if DEBUG & 1
						for (z = 0; z < count; z++) {
							printf (" %lx", *(((char *)object) + z));
							if (!(z % 40))
								printf ("\n");
						}
#endif

						break;

					default:
   	   	          		eio();
						break;
				}
			} else {
	
				if (!(flags & EO_COMP)) {		/* Special of references */
					ridr_multi_any (object, count);
#if DEBUG & 1
					for (ref = object; count > 0; count--,
							ref = (char *) ((char **) ref + 1)) {
						printf (" %lx", *(char **)(ref));
						if (!(count % 40))
							printf ("\n");
					}
#endif
				} else {						/* Special of composites */
					uint32  old_flags;

					ridr_norm_int (&old_flags);
#if DEBUG & 1
					printf (" %x", old_flags);
#endif
					elem_size = *(long *) (o_ptr + sizeof(long));
					for (ref = object + OVERHEAD; count > 0;
							count --, ref += elem_size) {
						HEADER(ref)->ov_flags = (old_flags & (EO_REF|EO_COMP|EO_TYPE));
						HEADER(ref)->ov_size = (uint32)(ref - parent);
						object_read (ref, parent);						
					}
				}
			}
		} 
	}
}

private long get_expanded_pos (o_type, num_attrib)
uint32 o_type, num_attrib;
{
	long Result;
	int numb, counter, bit_size = 0;
	int num_ref = 0, num_char = 0, num_float = 0, num_double = 0;
	int num_pointer = 0, num_int = 0, exp_size = 0, num_exp = 0;
	uint32 types_cn;

	numb = System(o_type).cn_nbattr;
	for (counter = 0; counter < numb; counter++) {
		types_cn = *(System(o_type).cn_types + counter);
		switch (types_cn & SK_HEAD) {
			case SK_EXP:
				if ((counter + (++num_ref - num_attrib)) < num_attrib) {
					exp_size += (OVERHEAD + Size(types_cn & SK_DTYPE));
				}
				break;
			case SK_REF:
				num_ref++;
				break;
			case SK_POINTER:
				num_pointer++;
				break;
			case SK_INT:
				num_int++;
				break;
			case SK_BOOL:
			case SK_CHAR:
				num_char++;
				break;
			case SK_FLOAT:
				num_float++;
				break;
			case SK_DOUBLE:
				num_double++;
				break;
			case SK_BIT:
				bit_size += (OVERHEAD + BITOFF(types_cn & SK_DTYPE));
				break;
			default:
				eio();
		}
	}
	return ((long) OBJSIZ (num_ref, num_char, num_int, num_float, num_pointer, num_double) + bit_size + exp_size + OVERHEAD);
}
