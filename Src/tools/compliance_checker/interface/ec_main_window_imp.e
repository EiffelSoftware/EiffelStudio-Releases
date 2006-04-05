indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EC_MAIN_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, is_in_default_state
		end
			
	EC_CHECKER_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_vertical_box_2
			create tbar_main
			create tbtn_new
			create tbtn_open
			create tbtn_save
			create l_ev_tool_bar_separator_1
			create tbtn_check
			create tbtn_help
			create l_ev_cell_1
			create l_ev_horizontal_separator_1
			create l_ev_vertical_box_3
			create nb_main
			create vbox_project_settings
			create vbox_output
			create l_ev_horizontal_box_1
			create l_ev_cell_2
			create lbl_copyright
			create l_ev_cell_3
			create btn_close
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (tbar_main)
			tbar_main.extend (tbtn_new)
			tbar_main.extend (tbtn_open)
			tbar_main.extend (tbtn_save)
			tbar_main.extend (l_ev_tool_bar_separator_1)
			tbar_main.extend (tbtn_check)
			tbar_main.extend (tbtn_help)
			l_ev_vertical_box_1.extend (l_ev_cell_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_1.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (nb_main)
			nb_main.extend (vbox_project_settings)
			nb_main.extend (vbox_output)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_cell_2)
			l_ev_horizontal_box_1.extend (lbl_copyright)
			l_ev_horizontal_box_1.extend (l_ev_cell_3)
			l_ev_horizontal_box_1.extend (btn_close)
			
			l_ev_vertical_box_1.disable_item_expand (l_ev_vertical_box_2)
			l_ev_vertical_box_1.disable_item_expand (l_ev_cell_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_separator_1)
			l_ev_vertical_box_2.set_border_width (2)
			l_ev_vertical_box_2.disable_item_expand (tbar_main)
			tbar_main.set_minimum_height (20)
			tbtn_new.set_tooltip (tooltip_new)
			tbtn_new.set_pixmap (icon_new)
			tbtn_open.set_tooltip (tooltip_open)
			tbtn_open.set_pixmap (icon_open)
			tbtn_save.set_tooltip (tooltip_save)
			tbtn_save.set_pixmap (icon_save)
			tbtn_check.set_tooltip (tooltip_check)
			tbtn_check.set_pixmap (icon_check_compliance)
			tbtn_help.set_tooltip (tooltip_help)
			tbtn_help.set_pixmap (icon_help)
			l_ev_cell_1.set_minimum_height (2)
			l_ev_vertical_box_3.set_padding_width (box_padding_width)
			l_ev_vertical_box_3.set_border_width (4)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_1)
			nb_main.set_minimum_height (100)
			nb_main.set_item_text (vbox_project_settings, tab_project)
			nb_main.set_item_text (vbox_output, tab_output)
			nb_main.item_tab (vbox_project_settings).set_pixmap (icon_project)
			nb_main.item_tab (vbox_output).set_pixmap (icon_settings)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_cell_2)
			l_ev_horizontal_box_1.disable_item_expand (btn_close)
			l_ev_cell_2.set_minimum_width (3)
			lbl_copyright.set_text (label_copyright)
			lbl_copyright.align_text_left
			btn_close.set_text (button_close)
			btn_close.set_tooltip (tooltip_close)
			btn_close.set_minimum_width (100)
			btn_close.set_minimum_height (button_height)
			set_minimum_width (550)
			set_minimum_height (425)
			set_maximum_width (9999)
			set_maximum_height (9999)
			set_title (main_window_title)
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	vbox_project_settings: EC_PROJECT_SETTINGS_PANE
	vbox_output: EC_CHECK_REPORT_PANE
	btn_close: EV_BUTTON
	tbar_main: EV_TOOL_BAR
	tbtn_new, tbtn_open, tbtn_save,
	tbtn_check, tbtn_help: EV_TOOL_BAR_BUTTON
	nb_main: EV_NOTEBOOK
	lbl_copyright: EV_LABEL

feature {NONE} -- Implementation

	l_ev_tool_bar_separator_1: EV_TOOL_BAR_SEPARATOR
	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_ev_cell_1, l_ev_cell_2,
	l_ev_cell_3: EV_CELL
	l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1, l_ev_vertical_box_2, l_ev_vertical_box_3: EV_VERTICAL_BOX

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
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
end -- class EC_MAIN_WINDOW_IMP
