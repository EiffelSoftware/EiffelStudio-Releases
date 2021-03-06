note
	description: "EiffelVision font selection dialog, implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			initialize
		end

create
	make


feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Connect `interface' and initialize `c_object'.
		local
			temp_font: EV_FONT
			a_cs: EV_GTK_C_STRING
		do
			base_make (an_interface)
			a_cs := "Font selection dialog"
			set_c_object ({EV_GTK_EXTERNALS}.gtk_font_selection_dialog_new (
						a_cs.item
					))
			create temp_font
			temp_font.set_height (14)
			set_font (temp_font)
		end

	reset_dialog
			-- Initialize the dialog when a font has been selected.
		local
			a_font_sel, a_pixels_button: POINTER
		do
			a_font_sel := gtk_font_selection_dialog_struct_fontsel (c_object)
			a_pixels_button := gtk_font_selection_struct_pixels_button (a_font_sel)
			{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (a_pixels_button, True)
			{EV_GTK_EXTERNALS}.gtk_widget_hide ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (a_pixels_button))
		end

	initialize
			-- Initialize the dialog.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			real_signal_connect (
				gtk_font_selection_dialog_struct_ok_button (c_object),
				"clicked",
				agent (App_implementation.gtk_marshal).font_dialog_on_ok_intermediary (c_object),
				Void
			)
			real_signal_connect (
				gtk_font_selection_dialog_struct_cancel_button (c_object),
				"clicked",
				agent (App_implementation.gtk_marshal).font_dialog_on_cancel_intermediary (c_object),
				Void
			)
			enable_closeable
			set_is_initialized (True)
		end

feature -- Access

	font: EV_FONT
			-- Current selected font.
		local
			a_fullname: STRING
			font_imp: EV_FONT_IMP
			size_clist: POINTER
			a_selected_index: INTEGER
			a_height_ptr: POINTER
			a_font_height: STRING
		do
			create Result
			font_imp ?= Result.implementation
			create a_fullname.make (0)
			a_fullname.from_c ({EV_GTK_EXTERNALS}.gtk_font_selection_dialog_get_font_name (c_object))
			Result.preferred_families.extend (font_imp.substring_dash (a_fullname, 2))

			a_font_height := font_imp.substring_dash (a_fullname, 7)
			if not a_font_height.is_integer then
				size_clist := gtk_font_selection_struct_size_clist (
					gtk_font_selection_dialog_struct_fontsel (c_object)
				)
				a_selected_index := pointer_to_integer (
					{EV_GTK_EXTERNALS}.glist_struct_data (gtk_clist_struct_selection (size_clist))
				)
				a_selected_index := {EV_GTK_EXTERNALS}.gtk_clist_get_text (
							size_clist,
							a_selected_index,
							0,
							$a_height_ptr
				)
				create a_font_height.make (0) 
				a_font_height.from_c_substring (a_height_ptr, 1, 2)
			end
			Result.set_height (a_font_height.to_integer)
			Result.set_weight (font_imp.weight_from_string (font_imp.substring_dash (a_fullname, 3)))
			Result.set_shape (font_imp.shape_from_string (font_imp.substring_dash (a_fullname, 4)))
		end

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Select `a_font'.
		local
			a_success_flag: BOOLEAN
			font_imp: EV_FONT_IMP
			a_cs: EV_GTK_C_STRING
		do
			font_imp ?= a_font.implementation
			a_cs := font_imp.system_name
			a_success_flag := {EV_GTK_EXTERNALS}.gtk_font_selection_dialog_set_font_name (
							c_object,
							a_cs.item
						)
			check font_found: a_success_flag end
			reset_dialog
		end

feature {NONE} -- Implementation

	pointer_to_integer (pointer: POINTER): INTEGER
			-- int pointer_to_integer (void* pointer) {
			--     return (int) pointer;
			-- }
			-- Hack used for Result = ((EIF_INTEGER)(pointer)), blank alias avoids parser rules.
		external
			"C [macro <stdio.h>] (EIF_POINTER): EIF_INTEGER"
		alias
			" "
		end

	gtk_font_selection_dialog_struct_ok_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"ok_button"
		end

	gtk_font_selection_dialog_struct_cancel_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"cancel_button"
		end

	gtk_font_selection_dialog_struct_fontsel (a_c_struct: POINTER): POINTER
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"fontsel"
		end

	gtk_font_selection_struct_pixels_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelection): EIF_POINTER"
		alias
			"pixels_button"
		end

	gtk_font_selection_struct_size_clist (a_c_struct: POINTER): POINTER
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelection): EIF_POINTER"
		alias
			"size_clist"
		end

	gtk_clist_struct_selection (a_c_struct: POINTER): POINTER
		external
			"C [struct <gtk/gtk.h>] (GtkCList): EIF_POINTER"
		alias
			"selection"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT_DIALOG;	

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




end -- class EV_FONT_DIALOG_IMP

