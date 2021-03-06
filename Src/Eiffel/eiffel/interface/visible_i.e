note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Feature external visibility controler

class VISIBLE_I

inherit
	SHARED_WORKBENCH
	SHARED_GENERATION
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end
	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Query

	is_visible (feat: FEATURE_I; class_id: INTEGER): BOOLEAN
			-- Is feature name `feat_name' visible in context
			-- of class `class_id'?
		do
			-- Do nothing
		end

	has_visible: BOOLEAN
			-- Has the current object some visible features ?
		do
			-- Do nothing
		end

	trace
		do
			io.error.put_string (generator)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	renamings: HASH_TABLE [STRING, STRING];
			-- Renaming table

feature -- Element change

	mark_visible (remover: REMOVER; feat_table: FEATURE_TABLE)
			-- Mark visible features from `feat_table'.
		do
			-- Do nothing
		end;

	generate_cecil_table (a_class: CLASS_C; generated_wrappers: SEARCH_TABLE [STRING_8])
			-- Generate cecil table
		require
			has_visible;
			generated_wrappers_attached: generated_wrappers /= Void
		do
		end;

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Element change

	real_name (feat: FEATURE_I; class_id: INTEGER): STRING
			-- Real external name for `feat' in context
			-- of `class_id'.
		require
			good_argument: feat /= Void;
			valid_class_id: class_id > 0
			feat_is_visible: is_visible (feat, class_id)
		do
			Result := feat.feature_name;
			if renamings /= Void and then renamings.has_key (Result) then
				Result := renamings.found_item
			end;
		end;

	set_renamings (t: like renamings)
			-- Assign `t' to `renamings'.
		do
			renamings := t;
		end;

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
