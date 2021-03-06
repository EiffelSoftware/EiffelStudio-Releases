note
	description: "Object that represents a style generator for local "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LOCAL_EDITOR_TOKEN_STYLE

inherit
	EB_EDITOR_TOKEN_STYLE

	SHARED_TEXT_ITEMS

create
	make_with_name,
	make_with_name_and_type,
	default_create

feature {NONE} -- Initialization

	make_with_name (a_name: like name)
			-- Initialization
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			set_local (a_name, Void, Void)
		end

	make_with_name_and_type (a_name: like name; a_type: like type; a_feature: like feature_i)
			-- Initialization
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
			a_type_not_void: a_type /= Void
		do
			set_local (a_name, a_type, a_feature)
		end

feature -- Access

	name: STRING_32
			-- Name of the local.

	type: TYPE_A
			-- Type of the local.

	feature_i: FEATURE_I
			-- Feature to print `type'

feature -- Text

	text: LIST [EDITOR_TOKEN]
			-- Editor token text generated by `Current' style
		local
			l_writer: like token_writer
		do
			l_writer := token_writer
			l_writer.new_line
			if is_keyword_name then
				l_writer.process_keyword_text (name, Void)
			else
				l_writer.process_local_text (name)
			end
			if is_type_enabled and then type /= Void and then feature_i /= Void then
				l_writer.process_symbol_text (ti_colon)
				l_writer.add_space
				type.ext_append_to (token_writer, feature_i.e_feature.associated_class)
			end
			Result := l_writer.last_line.content
		end

feature -- Status report

	is_type_enabled: BOOLEAN
			-- Should type of local be displayed?

	is_text_ready: BOOLEAN
			-- Is `text' ready to be returned?
		do
			Result := name /= Void
		end

feature -- Status report

	is_keyword_name: BOOLEAN
			-- Is the name actually an Eiffel keyword?

feature -- Setting

	set_local (a_name: like name; a_type: like type; a_feature: like feature_i)
			-- Set `name' with `a_name', `type' with `a_type and `feature_i' with `a_feature'.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			create name.make_from_string (a_name)
			type := a_type
			feature_i := a_feature
			is_keyword_name := False
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
			type_set: type = a_type
			feature_set: feature_i = a_feature
			not_is_keyword_name: not is_keyword_name
		end

	set_keyword_local (a_name: like name; a_type: like type; a_feature: like feature_i)
			-- Set `name' with `a_name', `type' with `a_type and `feature_i' with `a_feature'.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			set_local (a_name, a_type, a_feature)
			is_keyword_name := True
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
			type_set: type = a_type
			feature_set: feature_i = a_feature
			is_keyword_name: is_keyword_name
		end

	enable_type
			-- Enable display of type of local.			
		do
			is_type_enabled := True
		ensure
			type_enalbed: is_type_enabled
		end

	disable_type
			-- Disable display of type of local.			
		do
			is_type_enabled := False
		ensure
			type_disalbed: not is_type_enabled
		end

note
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

end
