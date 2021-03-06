note
	description: "System Help Manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_MANAGER

feature -- Commands

	show_help
			-- Show help
		do
			show (url_prefix + default_page_url)			
		end
		
feature -- Access

	last_show_successful: BOOLEAN
			-- Was last call to `show' successful?
		do
			Result := help_window_handle /= 0
		end

feature {NONE} -- Implementation

	help_window_handle: INTEGER
			-- Handle to help window

	show (a_chm_url: STRING)
			-- Display help page with url `a_chm_url'.
		do
			help_window_handle := cwin_html_help (default_pointer, (create {WEL_STRING}.make (a_chm_url)).item, Hh_display_topic, default_pointer)
		end

	url_prefix: STRING 
			-- URL prefix for $EiffelGraphicalCompiler$ help files
		once
			Result := (create {APPLICATION_CONSTANTS}).documentation_directory.out + "\help.chm::"
		end
	
	default_page_url: STRING 
			-- URL default page when opening help
		once
			Result := "index.html"
		end
	
feature {NONE} -- Externals

	cwin_html_help (hwnd, pszFile: POINTER; command: INTEGER; data: POINTER): INTEGER
			-- Help Workshop `HtmlHelp' API.
		external
			"C [macro %"Htmlhelp.h%"] (HWND, LPCSTR, UINT, DWORD): EIF_INTEGER"
		alias
			"HtmlHelp"
		end

	Hh_display_topic: INTEGER
			-- Help Workshop HH_DISPLAY_TOPIC constant
		external
			"C [macro %"Htmlhelp.h%"]: EIF_INTEGER"
		alias
			"HH_DISPLAY_TOPIC"
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
end -- class HELP_MANAGER
