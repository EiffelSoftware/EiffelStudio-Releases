indexing
	description: "Modeless dialog box that allows the user to switch %
		%between the dialog box and the application."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MODELESS_DIALOG

inherit
	WEL_DIALOG

creation
	make_by_id,
	make_by_name

feature -- Basic operations

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
			from
				dialog_children.start
			until
				dialog_children.off
			loop
				dialog_children.item.set_exists (False)
				unregister_window (dialog_children.item)
				dialog_children.item.set_item (default_pointer)
				dialog_children.forth
			end
			result_id := a_result
			cwin_destroy_window (item)
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		local
			c_name: WEL_STRING
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
		do
			item := cwel_temp_dialog_value
			exists := True
			register_window (Current)

				-- Initialise the common controls
			common_controls_dll: WEL_COMMON_CONTROLS_DLL

			if a_name /= Void then
				-- Load by name
				!! c_name.make (a_name)
				item := cwin_create_dialog (
					main_args.current_instance.item,
					c_name.item, parent_item,
					cwel_dialog_procedure_address)
			else
				-- Load by id
				item := cwin_create_dialog (
					main_args.current_instance.item,
					cwin_make_int_resource (an_id),
					parent_item,
					cwel_dialog_procedure_address)
			end
			if item /= default_pointer then
				exists := True
				if not shown then
					show
				end
			else
				exists := False
			end
		end

feature {NONE} -- Externals

	cwin_create_dialog (hinstance, template, hparent,
			dlgproc: POINTER): POINTER is
			-- SDK CreateDialog
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR, HWND, %
				%DLGPROC): EIF_POINTER"
		alias
			"CreateDialog"
		end

end -- class WEL_MODELESS_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

