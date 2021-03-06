note
	description:
		"EiffelVision toggle tool bar, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			make,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

create
	make

feature -- Initialization

	make (an_interface: like interface)
		-- Create the tool-bar toggle button.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_toggle_button_new)
		end

feature -- Status setting

	disable_select
			-- Unselect `Current'.
		do
			if is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, False)
			end
		end

	enable_select
			-- Select `Current'.
		do
			if not is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, True)
			end
		end	

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (visual_widget)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE;

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




end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

