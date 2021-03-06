note
	description: ".NET version specific assembly loader"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_LOADER_IMPL

feature {NONE}

	dotnet_load (a_name: SYSTEM_STRING): detachable ASSEMBLY
			-- Attempts to load from a full assembly name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: a_name.length > 0
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := {ASSEMBLY}.load (a_name)
			elseif not attached {FILE_NOT_FOUND_EXCEPTION} {ISE_RUNTIME}.last_exception then
				Result := {ASSEMBLY}.reflection_only_load (a_name)
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	dotnet_load_from (a_path: READABLE_STRING_GENERAL): detachable ASSEMBLY
			-- Attempts to load from a full path `a_path'
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := {ASSEMBLY}.load_from (a_path.to_cil)
			elseif not attached {FILE_NOT_FOUND_EXCEPTION} {ISE_RUNTIME}.last_exception then
				Result := {ASSEMBLY}.reflection_only_load_from (a_path.to_cil)
			end
		rescue
			if not retried then
				retried := True
				retry
			end
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

end -- class {ASSEMBLY_LOADER_IMPL}
