indexing
	description: "Representation of a procedure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DYN_PROC_I

inherit
	PROCEDURE_I
		redefine
			replicated, unselected, is_do
		end

feature

	replicated (in: INTEGER): FEATURE_I is
			-- Replication
		local
			rep: R_DYN_PROC_I
		do
			create rep;
			transfer_to (rep);
			rep.set_access_in (in)
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	selected: DYN_PROC_I is
			-- <Precursor>
		do
			create Result
			Result.transfer_from (Current)
		end

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_DYN_PROC_I
		do
			create unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	is_do: BOOLEAN is true;

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

end
