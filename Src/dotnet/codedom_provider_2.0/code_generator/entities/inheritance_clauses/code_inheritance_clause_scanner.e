note
	description: "Scanners for snippet inheritance clauses"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_INHERITANCE_CLAUSE_SCANNER

inherit
	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset
		end

	CODE_INHERITANCE_CLAUSE_TOKENS
		export
			{NONE} all
		end

create
	make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (sc = INITIAL)
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

when 2 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

when 3 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_COMMA
			
when 4 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_SEMICOLON
			
when 5 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_LCURLY
			
when 6 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_RCURLY
			
when 7 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_LSQURE
			
when 8 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_RSQURE
			
when 9 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_PLUS
			
when 10 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_MINUS
			
when 11 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_ALL
			
when 12 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_AS
			
when 13 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_BIT
			
when 14 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_CURRENT
			
when 15 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_END
			
when 16 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_EXPORT
			
when 17 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_INFIX
			
when 18 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_INHERIT
			
when 19 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_LIKE
			
when 20 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_PREFIX
			
when 21 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_REDEFINE
			
when 22 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_RENAME
			
when 23 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_SELECT
			
when 24 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_SEPARATE
			
when 25 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_UNDEFINE
			
when 26 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_ID
			
when 27 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_LT
			
when 28 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_GT
			
when 29 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_LE
			
when 30 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_GE
			
when 31 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_PLUS
			
when 32 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_MINUS
			
when 33 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_STAR
			
when 34 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_SLASH
			
when 35 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_POWER
			
when 36 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_DIV
			
when 37 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_MOD
			
when 38 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_AND
			
when 39 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				last_token := TE_STR_AND_THEN
			
when 40 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_IMPLIES
			
when 41 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_NOT
			
when 42 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				last_token := TE_STR_OR
			
when 43 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_OR_ELSE
			
when 44 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_XOR
			
when 45 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STR_FREE
			
when 46 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

			
when 47 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 376)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,    4,    5,    6,    5,    4,    7,    4,    4,    4,
			    8,    9,   10,    4,    4,   11,    4,    4,    4,    4,
			   12,   13,   14,   15,   16,   15,   15,   15,   17,   15,
			   18,   15,   15,   15,   19,   20,   21,   15,   22,   15,
			   23,    4,   24,    4,    4,   12,   13,   14,   15,   16,
			   15,   15,   15,   17,   15,   18,   15,   15,   15,   19,
			   20,   21,   15,   22,   15,   25,    4,   26,   27,   44,
			   27,   29,   29,   30,   31,   45,   32,   33,  153,   46,
			   34,   47,   35,   29,   36,   50,   48,   51,   52,   53,
			   54,   55,   37,   49,   44,   60,   38,   39,   66,   27,

			   45,   27,   61,   40,   46,   41,   47,   42,   62,   36,
			   50,   48,   51,   52,   53,   54,   55,   37,   49,   63,
			   64,   38,   39,   66,   67,   68,   69,   70,   40,   73,
			   29,   65,   74,   75,   76,   77,   78,   80,   79,   81,
			   86,   84,   90,   91,   82,   85,   92,  152,   95,   67,
			   68,   69,   70,   83,   73,   97,   98,   74,   75,   76,
			   77,   78,   80,   79,   81,   86,   84,   90,   91,   82,
			   85,   92,   93,   95,   94,   99,  100,  101,   83,  102,
			   97,   98,  103,  104,  105,  106,  107,  108,  110,  109,
			  112,  114,  115,  116,  117,  118,  119,  120,  121,  122, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   99,  100,  101,  123,  102,  124,  125,  103,  104,  105,
			  106,  107,  126,  110,  127,  112,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  128,  129,  130,  123,  131,
			  124,  125,  132,  133,  134,  135,  136,  126,  137,  127,
			  138,  139,  140,  141,  142,  143,  144,  145,  146,  147,
			  128,  129,  130,  148,  131,  149,  150,  132,  133,  134,
			  135,  136,  151,  137,  113,  138,  139,  140,  141,  142,
			  143,  144,  145,  146,  147,  111,   96,   89,  148,   88,
			  149,  150,   43,   43,   43,   43,   43,   43,   43,   43,
			   29,   29,   29,   29,   29,   29,   29,   29,   29,   87,

			   72,   71,   59,   58,   57,   56,   28,   28,  154,    3,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154, yy_Dummy>>,
			1, 177, 200)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 376)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    5,   12,
			    5,    7,    7,    7,    7,   12,    7,    7,  150,   13,
			    7,   14,    7,    7,    7,   17,   16,   18,   19,   20,
			   21,   22,    7,   16,   12,   33,    7,    7,   36,   27,

			   12,   27,   33,    7,   13,    7,   14,    7,   34,    7,
			   17,   16,   18,   19,   20,   21,   22,    7,   16,   34,
			   35,    7,    7,   36,   37,   38,   39,   40,    7,   44,
			    7,   35,   46,   47,   48,   49,   50,   51,   50,   52,
			   55,   54,   66,   67,   53,   54,   68,  146,   70,   37,
			   38,   39,   40,   53,   44,   75,   77,   46,   47,   48,
			   49,   50,   51,   50,   52,   55,   54,   66,   67,   53,
			   54,   68,   69,   70,   69,   78,   79,   80,   53,   81,
			   75,   77,   82,   83,   84,   85,   86,   90,   91,   90,
			   93,   97,   98,   99,  100,  102,  103,  104,  105,  106, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   78,   79,   80,  107,   81,  108,  110,   82,   83,   84,
			   85,   86,  112,   91,  114,   93,   97,   98,   99,  100,
			  102,  103,  104,  105,  106,  115,  117,  118,  107,  119,
			  108,  110,  120,  121,  122,  123,  124,  112,  125,  114,
			  126,  127,  129,  131,  134,  135,  136,  137,  138,  141,
			  115,  117,  118,  142,  119,  143,  144,  120,  121,  122,
			  123,  124,  145,  125,   95,  126,  127,  129,  131,  134,
			  135,  136,  137,  138,  141,   92,   71,   65,  142,   63,
			  143,  144,  155,  155,  155,  155,  155,  155,  155,  155,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,   61,

			   42,   41,   32,   31,   30,   29,   28,    6,    3,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154, yy_Dummy>>,
			1, 177, 200)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  308,  309,   66,  304,   64,  309,  309,
			  309,  309,   39,   51,   43,    0,   54,   53,   59,   53,
			   65,   66,   59,  309,  309,  309,  309,   97,  303,  299,
			  298,  297,  296,   89,  102,  114,   66,   93,   92,   91,
			   94,  260,  294,    0,   99,    0,   95,   98,  111,  101,
			  111,  108,  115,  121,  111,  117,  309,  309,  309,  309,
			  309,  293,  309,  273,  309,  271,  119,  109,  109,  168,
			  113,  270,  309,    0,    0,  120,    0,  123,  147,  152,
			  153,  154,  158,  163,  160,  165,  162,  309,  309,  309,
			  183,  158,  269,  166,  309,  258,  309,  167,  157,  154,

			  159,    0,  167,  171,  166,  176,  164,  178,  168,  309,
			  178,  309,  182,  309,  182,  188,    0,  198,  188,  201,
			  208,  196,  214,  207,  209,  214,  204,  204,    0,  205,
			    0,  211,    0,    0,  207,  213,  222,  211,  224,    0,
			    0,  225,  229,  231,  224,  256,  141,    0,    0,    0,
			   72,  309,  309,  309,  309,  279,  288, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		once
			Result := yy_fixed_array (<<
			    0,  154,    1,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  155,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  154,  154,  154,  154,  154,  154,  156,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  155,  155,  155,

			  155,  155,  155,  155,  155,  155,  155,  155,  154,  154,
			  154,  154,  154,  154,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  154,  154,  154,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  154,  154,  154,  155,
			  155,  155,  155,  155,  154,  154,  154,  155,  155,  155,
			  154,  154,  154,  154,    0,  154,  154, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 256)
			yy_ec_template_1 (an_array)
			yy_ec_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    5,    6,    7,    5,    1,    8,    5,
			    5,    5,    9,   10,   11,   12,    5,   13,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,    5,   15,
			   16,   17,   18,    5,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   26,   29,   30,   31,   32,   33,
			   34,   26,   35,   36,   37,   38,   26,   26,   39,   26,
			   26,   40,   41,   42,   43,   44,    5,   45,   46,   47,

			   48,   49,   50,   51,   52,   53,   51,   54,   55,   56,
			   57,   58,   59,   51,   60,   61,   62,   63,   51,   51,
			   64,   51,   51,   65,   66,   67,    5,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    3,    2,    2,    2,    2,    2,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    4,    5,    6,    7,
			    2,    2,    2,    2,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    8,    9,   10,    3,    2,    2,    2, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   48,   46,    1,    2,   46,    9,    3,
			   10,    4,   26,   26,   26,   26,   26,   26,   26,   26,
			   26,   26,   26,    7,    8,    5,    6,    1,    2,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   26,   26,   12,   26,   26,   26,   26,
			   26,   26,   26,   26,   26,   26,   45,   33,   31,   32,
			   34,    0,   27,    0,   28,    0,    0,    0,    0,    0,
			    0,    0,   35,   11,   13,   26,   15,   26,   26,   26,
			   26,   26,   26,   26,   26,   26,   26,   36,   29,   30,
			    0,    0,    0,    0,   42,    0,   37,   26,   26,   26,

			   26,   19,   26,   26,   26,   26,   26,   26,    0,   38,
			    0,   41,    0,   44,   26,   26,   17,   26,   26,   26,
			   26,   26,   26,   26,    0,    0,    0,   26,   16,   26,
			   20,   26,   22,   23,   26,   26,    0,    0,    0,   14,
			   18,   26,   26,   26,    0,    0,    0,   21,   24,   25,
			    0,   40,   43,   39,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 309
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 154
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 155
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 47
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 48
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Initialization

	make
			-- Create a new external scanner.
		do
			make_with_buffer (Empty_buffer)
			create token_buffer.make (Initial_buffer_size)
		end

feature -- Initialization

	reset
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			token_buffer.clear_all
		end

feature -- Access

	token_buffer: STRING
			-- Buffer for lexial tokens
	
	last_value: ANY
			-- Semantic value to be passed to the parser

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER = 1024 
				-- Initial size for `token_buffer'

invariant
	token_buffer_not_void: token_buffer /= Void

end -- class CODE_INHERITANCE_CLAUSE_SCANNER


--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
