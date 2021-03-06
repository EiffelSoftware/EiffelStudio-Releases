note
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	FORM_D_IMP

inherit
	COLORED_FOREGROUND_WINDOWS

	DIALOG_IMP
		rename
			allow_resize as allow_recompute_size,
			forbid_resize as forbid_recompute_size
		undefine
			child_has_resized,
			on_destroy,
			make_with_coordinates,
			set_default_position,
			set_enclosing_size,
			maximal_width,
			maximal_height,
			on_vertical_scroll_control,
			on_horizontal_scroll_control
		redefine
			unrealize,
			show,
			realize,
			class_name,
			on_size,
			set_form_width,
			set_form_height,
			set_height,
			set_size,
			set_width,
			default_style,
			default_position
		end;

	FORM_IMP
		rename
			make as form_make,
			wel_make as make_child
		undefine
			class_requires_icon,
			x,
			realize_current,
			default_style,
			default_ex_style,
			destroy,
			height,
			minimal_height,
			minimal_width,
			move_and_resize,
			on_menu_command,
			on_accelerator_command,
			on_paint,
			on_get_min_max_info,
			on_set_cursor,
			realized,
			resize_for_shell,
			width,
			wel_move,
			real_x,
			real_y
		redefine
			unrealize,
			class_name,
			realize,
			on_size,
			show,
			initialize,
			set_form_height,
			set_form_width,
			set_width,
			set_height,
			set_size,
			default_position
		end

	FORM_D_I

	WEL_SIZE_CONSTANTS

create
	make

feature -- Initialization

	make (a_form_d: FORM_D; oui_parent: COMPOSITE)
			-- Create the form dialog.
		do
			create private_attributes
			parent ?= oui_parent.implementation;
			a_form_d.set_dialog_imp (Current);
			private_title := a_form_d.identifier;
			initialize
			managed := true
			shell_height := title_bar_height + window_border_height + 2 * window_frame_height
			shell_width := 2 * window_frame_width
			default_position := true
			private_attributes.set_width (100)
			private_attributes.set_height (100)
			max_width := full_screen_client_area_width
			max_height := full_screen_client_area_height
		end

	initialize
			-- Initialize the current form
		do
			fraction_base := 100
			create form_child_list.make
		end

feature -- Access

	default_position: BOOLEAN
			-- Use default position?

feature -- Status setting

	realize
			-- Realize the current widget
		local
			xpos, ypos: INTEGER
		do
			if not exists then
				realize_current
				realize_children
				if not fixed_size_flag then
					set_enclosing_size
					update_all
				end
			end
			if default_position then
				xpos := parent.real_x + ((parent.width - width) // 2)
				ypos := parent.real_y + ((parent.height - height) // 2)
				xpos := xpos.max (0)
				ypos := ypos.max (0)
				set_x_y (xpos, ypos)
			end
			update_all
				-- set initial focus
			if initial_focus /= void then
				initial_focus.wel_set_focus
			end
		end

	set_form_height (new_height: INTEGER)
			-- Set height for form to `new_height'
		do
			if height /= new_height then
				private_attributes.set_height (new_height)
				if exists then
					wel_set_height (new_height + shell_height)
				end
			end
		end

	set_form_width (new_width: INTEGER)
			-- Set height for form to `new_height'
		do
			if width /= new_width then
				private_attributes.set_width (new_width)
				if exists then
					wel_set_width (new_width + shell_width)
				end
			end
		end

	set_height (new_height: INTEGER)
			-- Set height to `new_height'.
		do
			if private_attributes.height /= new_height then
				private_attributes.set_height (new_height)
				if exists then
					wel_set_height (new_height + shell_height)
				end
				if not updating then
					update_all
				end
			end
		end

	set_size (new_width, new_height: INTEGER)
			-- Set size to `new_width' and `new_height'.
		do
			if private_attributes.width /= new_width
			or else private_attributes.height /= new_height then
				private_attributes.set_height (new_height)
				private_attributes.set_width (new_width)
				if exists then
					resize (new_width + shell_width, new_height + shell_height)
				end
				update_all
			end
		end

	set_width (new_width: INTEGER)
			-- Set width to `new_width'.
		do
			if private_attributes.width /= new_width then
				private_attributes.set_width (new_width)
				if exists then
					wel_set_width (new_width + shell_width)
				end
				if not updating then
					update_all
				end
			end
		end

	show
			-- Show current form dialog and children.
		do
			set_enclosing_size
			Precursor {FORM_IMP}
		end

	unrealize
		do
			if insensitive_list /= Void then
				set_windows_sensitive
			end
			Precursor {FORM_IMP}
		end

	class_name: STRING_32
			-- Set the class name for WEL.
		once
			Result := "EVisionFormDialog"
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- Wm_size message
		do
			if size_type = size_restored then
				private_attributes.set_height (a_height)
				private_attributes.set_width (a_width)
				if not updating then
					update_all
				end
			end
		end

	default_style: INTEGER
			-- Deafult style for a dialog
		once
			Result := Ws_overlapped + Ws_dlgframe + Ws_thickframe
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




end -- class FORM_D_IMP

