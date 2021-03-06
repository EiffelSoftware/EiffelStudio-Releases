note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPROPERTY_NOTIFY_SINK_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	on_changed_user_precondition (disp_id: INTEGER): BOOLEAN
			-- User-defined preconditions for `on_changed'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_request_edit_user_precondition (disp_id: INTEGER): BOOLEAN
			-- User-defined preconditions for `on_request_edit'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	on_changed (disp_id: INTEGER)
			-- No description available.
			-- `disp_id' [in].  
		require
			on_changed_user_precondition: on_changed_user_precondition (disp_id)
		deferred

		end

	on_request_edit (disp_id: INTEGER)
			-- No description available.
			-- `disp_id' [in].  
		require
			on_request_edit_user_precondition: on_request_edit_user_precondition (disp_id)
		deferred

		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IPROPERTY_NOTIFY_SINK_INTERFACE

