note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_PREFERENCES

inherit
	SHARED_OBJECTS

feature -- Access

	initialize
			--
		local
			l_loc, l_prefname: PATH
		do
			create l_loc.make_from_string (shared_constants.application_constants.templates_path)
			l_loc := l_loc.extended ("default.xml")
			if (create {PLATFORM}).is_windows then
				create preferences.make_with_defaults_and_location (<<l_loc.name>>, "HKEY_CURRENT_USER\Software\ISE\doc_builder")
			else
				l_prefname := (create {EXECUTION_ENVIRONMENT}).home_directory_path
				l_prefname := l_prefname.extended (".doc_builder")
				create preferences.make_with_defaults_and_location (<<l_loc.name>>, l_prefname.name)
			end
			create editor_data.make (preferences)
			create tool_data.make (preferences)
		end

	editor_data: EDITOR_DATA

	tool_data: TOOL_DATA

	preferences: PREFERENCES

feature -- Commands		

	show_preferences_window (a_window: EV_WINDOW)
			--
		local
			window: PREFERENCES_WINDOW
		do
			create window.make (preferences, application_window)
			window.show
		end

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
