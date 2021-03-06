note
	description: "[
					Object that is responsiable for modifying text of a PARENT_AS for refactoring.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_PARENT_AS_MODIFIER

inherit
	ERT_AST_MODIFIER

	AST_ROUNDTRIP_FACTORY
		rename
			match_list as a_list_a
		export
			{STRING, ARRAY}all
			{STRING}create_match_list
		end

create
	make

feature{NONE} -- Initialization

	make (a_parent_as: PARENT_AS; a_match_list: like match_list)
			-- Initialize instance.
			-- `a_parent_as' is PARENT AST node on which modifications are conducted.
			-- `a_match_list' is match_list needed by roundtrip operations.
		require
			a_parent_as_not_void: a_parent_as /= Void
			a_match_list_not_void: a_match_list /= Void
		do
			parent_ast := a_parent_as
			match_list := a_match_list
			initialize
		ensure
			parent_ast_set: parent_ast = a_parent_as
			match_list_set: match_list = a_match_list
		end

feature -- Applicability

	can_apply: BOOLEAN
			-- Can current modifier be applied?
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				i > 5 or not Result
			loop
				Result := can_inherit_clause_apply (i)
				i := i + 1
			end
			if Result then
				Result := can_end_keyword_modification_apply
			end
		end

	apply
			-- Apply current modifier.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > 5
			loop
				if
					inherit_clause_modifier.i_th (i).is_empty and
					not inherit_clause_has_comment (i) and
					attached inherit_clause.i_th (i) as l_clause
				then
					l_clause.replace_text ("", match_list)
				else
					if inherit_clause.i_th (i) /= Void or not inherit_clause_modifier.i_th (i).is_empty then
						inherit_clause_modifier.i_th (i).apply
					end
				end
				i := i + 1
			end

			if is_end_keyword_needed then
				if parent_ast.end_keyword (match_list) = Void then
					parent_ast.append_text (end_keyword_string, match_list)
				end
			else
				if attached parent_ast.end_keyword (match_list) as l_keyword then
					l_keyword.replace_text ("", match_list)
				end
			end
			applied := True
		end

feature -- Modification Register

	extend_32 (a_clause: INTEGER; a_text: STRING_32)
			-- Register an item insertion in `a_clause'-th inherit clause.
			-- `a_text' is text of the item to be inserted at the last position in that inherit clause.
			-- `a_clause' can be `rename_clause', `export_clause', `undefine_clause', `redefine_clause' or `select_caluse'.
			-- `a_text' is in UTF-32
		require
			a_clause_valid: valid_clause (a_clause)
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			extend (a_clause, encoding_converter.utf32_to_utf8 (a_text))
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Modification Register

	extend (a_clause: INTEGER; a_text: STRING)
			-- Register an item insertion in `a_clause'-th inherit clause.
			-- `a_text' is text of the item to be inserted at the last position in that inherit clause.
			-- `a_clause' can be `rename_clause', `export_clause', `undefine_clause', `redefine_clause' or `select_caluse'.
		require
			a_clause_valid: valid_clause (a_clause)
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			inherit_clause_modifier.i_th (a_clause).append (a_text)
		end

	replace (a_clause: INTEGER; a_index: INTEGER; a_text: STRING)
			-- Register an item replacement of the `a_index'-th item in `a_clause'-th inherit clause
			-- by `a_text'.
			-- `a_clause' can be `rename_clause', `export_clause', `undefine_clause', `redefine_clause' or `select_caluse'.			
		require
			a_clause_valid: valid_clause (a_clause)
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
			index_valid: valid_index (a_clause, a_index)
		do
			inherit_clause_modifier.i_th (a_clause).replace (a_text, a_index)
		end

feature -- Modification Register

	remove (a_clause: INTEGER; a_index: INTEGER)
			-- Register a removal of `a_index'-th item in `a_clause'-th inherit clause.
			-- `a_clause' can be `rename_clause', `export_clause', `undefine_clause', `redefine_clause' or `select_caluse'.			
		require
			a_clause_valid: valid_clause (a_clause)
			index_valid: valid_index (a_clause, a_index)
		do
			inherit_clause_modifier.i_th (a_clause).remove (a_index)
		end

feature -- Inherit clause indicators

	valid_clause (a_clause: INTEGER): BOOLEAN
			-- Is `a_clause' valid?
		do
			Result := a_clause = rename_clause or a_clause = export_clause or a_clause = undefine_clause or a_clause = redefine_clause or a_clause = select_clause
		ensure
			Result_set: (a_clause = rename_clause or a_clause = export_clause or a_clause = undefine_clause or a_clause = redefine_clause or a_clause = select_clause) implies Result
		end

	valid_index (a_clause: INTEGER; a_index: INTEGER): BOOLEAN
			-- Is `a_index' in `a_clause'-th inherit clause valid?
		require
			a_clause_valid: valid_clause (a_clause)
		do
			Result := True
			if attached inherit_clause.i_th (a_clause) as l_clause then
				Result := attached l_clause.content as l_content and then
						 (a_index > 0 and a_index <= l_content.count)
			end
		end

	rename_clause: INTEGER = 1
	export_clause: INTEGER = 2
	undefine_clause: INTEGER = 3
	redefine_clause: INTEGER = 4
	select_clause: INTEGER = 5
			-- Indicators for rename, export, undefine, redefine and select inherit clauses.

feature{NONE} -- Initialization

	initialize
			-- Initialize
		local
			l_sep_list: ARRAYED_LIST [detachable STRING]
			l_head_list: ARRAYED_LIST [STRING]
			i: INTEGER
			l_modifier: ERT_BASIC_EIFFEL_LIST_MODIFIER
			l_empty_modifier: ERT_EMPTY_EIFFEL_LIST_MODIFIER
			l_inherit_clause_name: AST_EIFFEL
		do
			create inherit_clause_modifier.make (5)
			create inherit_clause.make (5)
			create l_sep_list.make (5)
			create l_head_list.make (5)

			l_sep_list.extend (",")
			l_sep_list.extend (Void)
			l_sep_list.extend (",")
			l_sep_list.extend (",")
			l_sep_list.extend (",")

			l_head_list.extend ("%N%T%Trename")
			l_head_list.extend ("%N%T%Texport")
			l_head_list.extend ("%N%T%Tundefine")
			l_head_list.extend ("%N%T%Tredefine")
			l_head_list.extend ("%N%T%Tselect")

			inherit_clause.extend (parent_ast.internal_renaming)
			inherit_clause.extend (parent_ast.internal_exports)
			inherit_clause.extend (parent_ast.internal_undefining)
			inherit_clause.extend (parent_ast.internal_redefining)
			inherit_clause.extend (parent_ast.internal_selecting)

			from
				i := 1
			until
				i > 5
			loop
				if not attached inherit_clause.i_th (i) as l_inherit_clause then
					create l_empty_modifier.make (attached_ast (i), False, match_list)
					l_empty_modifier.set_header_text (l_head_list.i_th (i))
					if is_footer_needed then
						l_empty_modifier.set_footer_text ("%N%T%T")
					end
					l_modifier := l_empty_modifier
				elseif not attached l_inherit_clause.content as l_content or else l_content.is_empty then
					if attached l_inherit_clause.clause_keyword (match_list) as l_clause_keyword then
						l_inherit_clause_name := l_clause_keyword
					else
							-- This should not happen.
						l_inherit_clause_name := attached_ast (i)
					end
					l_empty_modifier := create {ERT_EMPTY_EIFFEL_LIST_MODIFIER}.make (l_inherit_clause_name, False, match_list)
					l_empty_modifier.set_header_ast (l_inherit_clause_name)
					l_modifier := l_empty_modifier
				else
					l_modifier := create {ERT_EIFFEL_LIST_MODIFIER}.make (l_content, match_list)
				end
				l_modifier.set_arguments (l_sep_list.i_th (i), "%T%T%T", "%N")
				inherit_clause_modifier.extend (l_modifier)
				i := i + 1
			end
		end

feature{NONE} -- Implementation

	can_inherit_clause_apply (a_clause: INTEGER): BOOLEAN
			-- Can modifications done on `a_clause'-th inherit clause be applied?
		require
			a_clause_valid: valid_clause (a_clause)
		do
			if
				inherit_clause_modifier.i_th (a_clause).is_empty and
				not inherit_clause_has_comment (a_clause) and
				attached inherit_clause.i_th (a_clause) as l_clause
			then
				Result := l_clause.can_replace_text (match_list)
			else
				Result := inherit_clause_modifier.i_th (a_clause).can_apply
			end
		end

	can_end_keyword_modification_apply: BOOLEAN
			-- Can modifications done on "end" keyword of `parent_as' be applied?
		do
			Result := True
			if is_end_keyword_needed then
				if parent_ast.end_keyword (match_list) = Void then
					Result := parent_ast.can_append_text (match_list)
				end
			else
				if attached parent_ast.end_keyword (match_list) as l_keyword then
					Result := l_keyword.can_replace_text (match_list)
				end
			end
		end

	inherit_clause_has_comment (a_clause: INTEGER): BOOLEAN
			-- Does `a_clause'-th inherit clause has comment?
			-- If it does, we don't remove the clause even there is no item in it.
		require
			a_clause_valid: valid_clause (a_clause)
		local
			l_leaf: detachable LEAF_AS
		do
			if attached inherit_clause.i_th (a_clause) as l_clause then
				l_leaf := next_inherit_clause_start_token (a_clause)
				if l_leaf /= Void and attached l_clause.first_token (match_list) as l_clause_token then
					Result := match_list.has_comment (
						create{ERT_TOKEN_REGION}.make (l_clause_token.index,
													  l_leaf.first_token (match_list).index - 1))
				end
			end
		end

	attached_ast (a_clause: INTEGER): AST_EIFFEL
			-- The AST structure appearing before `a_index'-th inherit clause
			-- It is used when an inherit clause is present while the one before it is missing.
		local
			i: INTEGER
			l_result: detachable AST_EIFFEL
		do
			is_footer_needed := False
			from
				i := a_clause - 1
				l_result :=  Void
			until
				i < 1 or (l_result /= Void)
			loop
				l_result := inherit_clause.i_th (i)
				if l_result /= Void and then inherit_clause_has_comment (i) and then attached l_result.last_token (match_list) as l_clause_token then
					l_result := match_list.i_th (l_clause_token.index + 1)
					is_footer_needed := True
				end
				i := i - 1
			end
			if l_result = Void then
				Result := parent_ast.type
			else
				Result := l_result
			end
		ensure
			Result_not_void: Result /= Void
		end

	is_footer_needed: BOOLEAN
			-- Is a footer needed to separate two inherit clauses?

	next_inherit_clause_start_token (a_clause: INTEGER): detachable LEAF_AS
			-- Start token of the next inherit clause of `a_clause'.
		require
			a_clause_valid: valid_clause (a_clause)
		local
			i: INTEGER
		do
			from
				i := a_clause + 1
			until
				i > 5 or Result /= Void
			loop
				if attached inherit_clause.i_th (i) as l_clause then
					Result := l_clause.first_token (match_list)
				end
				i := i + 1
			end
			if Result = Void then
				Result := parent_ast.end_keyword (match_list)
			end
		end

	is_end_keyword_needed: BOOLEAN
			-- Is "end" keyword needed?
			-- If no inherit presents, "end" keyword is not needed, otherwise, needed.
		local
			i: INTEGER
		do
			from
				i := 1
				Result := False
			until
				i > 5 or Result
			loop
				Result := not inherit_clause_modifier.i_th (i).is_empty or else inherit_clause_has_comment (i)
				i := i + 1
			end
		end

	inherit_clause_index: ARRAYED_LIST [INTEGER]
			-- List of inherit clause index
		once
			create Result.make (5)
			Result.extend (rename_clause)
			Result.extend (export_clause)
			Result.extend (undefine_clause)
			Result.extend (redefine_clause)
			Result.extend (select_clause)
		end

feature{NONE} -- Implementation

	parent_ast: PARENT_AS
			-- PRAENT AST node on which modifications are conducted.

	inherit_clause_modifier: ARRAYED_LIST [ERT_BASIC_EIFFEL_LIST_MODIFIER]
			-- List of inherit clauses modifiers

	inherit_clause: ARRAYED_LIST [detachable INHERIT_CLAUSE_AS [EIFFEL_LIST [AST_EIFFEL]]]
			-- List of inherit clauses

feature{NONE} -- Implementation

	end_keyword_string: STRING = "%N%T%Tend"

feature{NONE} -- Implementation

	match_list: LEAF_AS_LIST
			-- Match list used by roundtrip

invariant
	parent_ast_not_void: parent_ast /= Void
	inherit_clause_modifier_not_void: inherit_clause_modifier /= Void
	inherit_clause_not_void: inherit_clause /= Void
	match_list_not_void: match_list /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
