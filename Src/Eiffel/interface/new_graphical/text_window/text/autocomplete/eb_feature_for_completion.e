indexing
	description: "A feature to be inserted into the auto-complete list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EB_FEATURE_FOR_COMPLETION

inherit
	EB_NAME_FOR_COMPLETION
		rename
			make as make_old
		redefine
			icon,
			tooltip_text,
			is_class,
			insert_name,
			grid_item,
			full_insert_name,
			begins_with
		end

	PREFIX_INFIX_NAMES
		undefine
			out, copy, is_equal
		end

create
	make

create {EB_FEATURE_FOR_COMPLETION}
	make_string

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE; a_name: STRING) is
			-- Create and initialize a new completion feature using `a_feature'
		require
			a_feature_not_void: a_feature /= Void
		local
			l_s: STRING
		do
			if a_feature.is_infix then
				l_s := extract_symbol_from_infix(a_feature.name)
			else
				l_s := a_feature.name
			end
			if a_name /= Void then
				make_old (a_name)
			else
				make_old (l_s)
			end
			full_name := l_s

			associated_feature := a_feature
			return_type := a_feature.type

			if show_signature then
				append (feature_signature)
			end
			if show_type then
				append (completion_type)
			end

			create insert_name_internal.make (name.count + feature_signature.count)
			insert_name_internal.append (name)
			insert_name_internal.append (feature_signature)

			create full_insert_name_internal.make (associated_feature.name.count + feature_signature.count)
			full_insert_name_internal.append (associated_feature.name)
			full_insert_name_internal.append (feature_signature)
		ensure
			associated_feature_set: associated_feature = a_feature
			return_type_set: return_type = a_feature.type
		end

feature -- Access

	is_class: BOOLEAN is False
			-- Is completion feature a class, of course not.	

	insert_name: STRING is
			-- Name to insert in editor
		do
			Result := insert_name_internal
		end

	full_insert_name: STRING is
			-- Full name to insert in editor
		do
			Result := full_insert_name_internal
		end

	icon: EV_PIXMAP is
			-- Associated icon based on data
		do
			Result := pixmap_from_e_feature (associated_feature)
		end

	tooltip_text: STRING is
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		do
			create Result.make (Current.count + feature_signature.count + completion_type.count)
			Result.append (Current)
			Result.append (feature_signature)
			Result.append (completion_type)
		end

	grid_item: EB_GRID_FEATURE_ITEM is
			-- Grid item
		local
			l_f: QL_REAL_FEATURE
			l_class: QL_CLASS
			l_style: EB_GRID_FEATURE_ITEM_STYLE
		do
			l_class := query_class_item_from_class_c (associated_feature.associated_class)
			create l_f.make_with_parent (associated_feature, l_class)
			if not show_signature and then not show_type then
				create {EB_GRID_JUST_NAME_FEATURE_STYLE}l_style
			elseif show_signature and then not show_type then
				create {EB_NAME_SIGNATURE_FEATURE_STYLE}l_style
			elseif show_type and then not show_signature then
				create {EB_NAME_TYPE_FEATURE_STYLE}l_style
			elseif show_type and then show_signature then
				create {EB_GRID_FULL_FEATURE_STYLE}l_style
			end
			l_style.use_overload_name (not show_disambiguated_name)
			create Result.make_overload (l_f, l_style, name)
			Result.set_tooltip_display_function (agent display_colorized_tooltip)
			Result.enable_pixmap
			Result.set_overriden_fonts (label_font_table)
			Result.set_data (Current)
		end

feature -- Query

	has_arguments: BOOLEAN is
			-- Does `associated_feature' have arguments?
		do
			Result := associated_feature.has_arguments
		end

feature -- Comparison

	begins_with (s: STRING): BOOLEAN is
			-- Does this feature name begins with `s'?
		local
			lower_s: STRING
		do
			if show_disambiguated_name then
				Result := Precursor {EB_NAME_FOR_COMPLETION} (s)
			else
				if name.count >= s.count then
					lower_s := s.as_lower
					Result := name.as_lower.substring_index_in_bounds (lower_s, 1, lower_s.count) = 1
				end
			end
		end

feature {NONE} -- Implementation

	associated_feature: E_FEATURE
			-- Feature associated with completion item

	feature_signature: STRING is
			-- The signature of `associated_feature'
		require
			associated_feature_not_void: associated_feature /= Void
		do
			if internal_feature_signature = Void then
				if associated_feature.has_arguments then
					create Result.make (110)
					associated_feature.append_arguments_to (Result)
				else
					create Result.make_empty
				end
				internal_feature_signature := Result
			else
				Result := internal_feature_signature
			end
		ensure
			result_not_void: Result /= Void
		end

	internal_feature_signature: STRING
			-- cache `feature_signature'

	insert_name_internal: STRING

	full_insert_name_internal: STRING

invariant
	associated_feature_not_void: associated_feature /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FEATURE_FOR_COMPLETION
