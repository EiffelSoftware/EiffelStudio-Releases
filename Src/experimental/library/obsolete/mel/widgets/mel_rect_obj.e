note

	description:
			"Fundamental class with geometry."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_RECT_OBJ

inherit

	MEL_RECT_OBJ_RESOURCES
		export
			{NONE} all
		end;

	MEL_FORM_CHILD;

	MEL_FRAME_CHILD;

	MEL_PANED_WINDOW_CHILD

feature -- Access

	real_x: INTEGER
			-- Horizontal position relative to root window
		do
			Result := xt_real_x (screen_object)
		end;

	real_y: INTEGER
			-- Vertical position relative to root window
		do
			Result := xt_real_y (screen_object)
		end;

feature -- Status report

	is_ancestor_sensitive: BOOLEAN
			-- Is a gadget's immediate parent sensitive?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNancestorSensitive)
		end;

	is_input_sensitive: BOOLEAN
			-- Is Current input sensitive?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNsensitive)
		end;

	border_width: INTEGER
			-- Width of Current's border
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNBorderWidth)
		ensure
			border_width_large_enough: Result >= 0
		end;

	height: INTEGER
			-- Window height, excluding the border
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNheight)
		ensure
			height_large_enough: Result >= 0
		end;

	width: INTEGER
			-- Window width, excluding the border
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNwidth)
		ensure
			width_large_enough: Result >= 0
		end;

	x: INTEGER
			-- The x-coordinate relative to the parent
		require
			exists: not is_destroyed
		do
			Result := get_xt_position (screen_object, XmNx)
		end;

	y: INTEGER
			-- The y-coordinate relative to the parent
		require
			exists: not is_destroyed
		do
			Result := get_xt_position (screen_object, XmNy)
		end;

feature -- Status setting

	set_input_sensitive
			-- Set `is_input_sensitive' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNsensitive, True)
		ensure
			is_sensitive: is_sensitive
		end;

	set_input_insensitive
			-- Set `is_sensitive' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNsensitive, False)
		ensure
			is_not_sensitive: not is_sensitive
		end;

	set_border_width (a_width: INTEGER)
			-- Set `border_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNBorderWidth, a_width)
		ensure
			border_width_set: border_width = a_width
		end;

	set_height (a_height: INTEGER)
			-- Set `height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNheight, a_height)
		end;

	set_width (a_width: INTEGER)
			-- Set `width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNwidth, a_width)
		end;

    set_size (new_width:INTEGER; new_height: INTEGER)
            -- Set `width' to `new_width', and `height' to `new_height'.
        require
			exists: not is_destroyed;
            width_large_enough: new_width >= 0;
            height_large_enough: new_height >= 0
        do
            set_xt_dimension (screen_object, XmNwidth, new_width);
            set_xt_dimension (screen_object, XmNheight, new_height)
        end;

	set_x (a_value: INTEGER)
			-- Set `x' to `a_value'.
		require
			exists: not is_destroyed
		do
			set_xt_position (screen_object, XmNx, a_value)
		end;

	set_y (a_value: INTEGER)
			-- Set `y' to `a_value'.
		require
			exists: not is_destroyed
		do
			set_xt_position (screen_object, XmNy, a_value)
		end;

	set_x_y (x_value, y_value: INTEGER)
			-- Set `x' to `x_value', and `y' to `y_value'.
		require
			exists: not is_destroyed
		do
			set_xt_position (screen_object, XmNx, x_value);
			set_xt_position (screen_object, XmNy, y_value)
		end

	move_to (x_value, y_value: INTEGER)
			-- Move Current widget to x position `x_value' and
			-- y position to `y_value'. 
			--| The `x_value' and `y_value' will be written into the widget
			--| and if it is realized an `XMoveWindow' is issued on its
			--| window.
		require
			exists: not is_destroyed
		do
			xt_move_widget (screen_object, x_value, y_value)
		end;

feature {NONE} -- External features

    xt_move_widget (w: POINTER; x1, y1: INTEGER)
        external
            "C (Widget, Position, Position) | <X11/IntrinsicP.h>"
        alias
            "XtMoveWidget"
        end;

	xt_real_y (scr_obj: POINTER): INTEGER
		external
			"C"
		end;

	xt_real_x (scr_obj: POINTER): INTEGER
		external
			"C"
		end;

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




end -- class MEL_RECT_OBJ


