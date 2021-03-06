note

	description:
		"EiffelVision Implementation of a font box"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	FONT_BOX_IMP

inherit

	FONT_BOX_I;

	TERMINAL_IMP
		undefine
			create_widget, is_form, mel_set_foreground_color, set_background,
			mel_set_background_color, set_foreground
		redefine
			make, set_font_from_imp, set_background_color_from_imp,
			set_foreground_color_from_imp
		end;

	MEL_FONT_BOX
		rename
			make as fb_make,
			make_no_auto_unmanage as fb_make_no_auto_unmanage,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			set_button_font as mel_set_button_font,
			is_shown as shown
		select
			fb_make, fb_make_no_auto_unmanage
		end

create
	make

feature {NONE} -- Creation

	make (a_font_box: FONT_BOX; man: BOOLEAN; oui_parent: COMPOSITE)
			-- Create a motif font box.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			fb_make (a_font_box.identifier, mc, man)
		end;

feature -- Status report

	font: FONT
			-- Font currently selected by the user
		do
			create Result.make;
			Result.set_name (current_font_name)
		end;

feature -- Status setting

	set_font (a_font: FONT)
			-- Edit `a_font'.
		local
			font_name: STRING
		do
			font_name := a_font.name;
			if font_name /= Void then
				set_font_name (a_font.name)
			end
		end;

feature  -- Element change

	add_apply_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
        local
            list: VISION_COMMAND_LIST
        do
            list := vision_command_list (apply_command);
            if list = Void then
                create list.make;
                set_apply_callback (list, Void)
            end;
            list.add_command (a_command, argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
        local
            list: VISION_COMMAND_LIST
        do
            list := vision_command_list (cancel_command);
            if list = Void then
                create list.make;
                set_cancel_callback (list, Void)
            end;
            list.add_command (a_command, argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
        local
            list: VISION_COMMAND_LIST
        do
            list := vision_command_list (ok_command);
            if list = Void then
                create list.make;
                set_ok_callback (list, Void)
            end;
            list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_apply_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		do
			remove_command (apply_command, a_command, argument)
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			remove_command (cancel_command, a_command, argument)
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			remove_command (ok_command, a_command, argument)
		end;

feature {NONE} -- Implementation

    set_background_color_from_imp (color_imp: COLOR_IMP)
            -- Set the background color from implementation `color_imp'.
        do
			mel_set_background_color (color_imp)
		end;

    set_foreground_color_from_imp (color_imp: COLOR_IMP)
            -- Set the background color from implementation `color_imp'.
        do
			mel_set_foreground_color (color_imp)
		end

	set_font_from_imp (font_implementation: FONT_IMP; value: INTEGER)
			-- Set text font from `font_implementation'.
		local
			a_font_list: MEL_FONT_LIST;
			an_entry: MEL_FONT_LIST_ENTRY;
		do
			if Label_font_value /= value then
				if font_implementation.is_valid then
					create an_entry.make_default_from_font_struct (font_implementation);
					create a_font_list.append_entry (an_entry);
					if a_font_list.is_valid then
						if value = Button_font_value then
							mel_set_button_font (a_font_list)
						else
							check
								consistency: value = Text_font_value
							end;
							set_scroll_list_font (a_font_list)
						end
					a_font_list.destroy
					else
						io.error.putstring ("Warning cannot allocate font%N");
					end;
					an_entry.destroy
				else
					io.error.putstring ("Warning cannot allocate font%N");
				end
			end;
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




end -- class FONT_BOX_IMP

