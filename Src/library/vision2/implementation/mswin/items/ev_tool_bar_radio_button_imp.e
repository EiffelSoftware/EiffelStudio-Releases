--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision tool-bar radio button, mswindows%
		% implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_TOGGLE_BUTTON_IMP
		redefine
			type,
			set_checked,
			interface,
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

creation
	make

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			enable_select
		end

feature -- Status report

	type: INTEGER is
			-- Type of the button.
			-- See `add_button' of EV_TOOL_BAR_IMP for values
			-- explanation.
		do
			Result := 3
		end

	set_checked is
			-- Select the current button.
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					radio_group.item.disable_select
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			Precursor
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_RADIO_BUTTON

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/04/04 17:20:59  rogers
--| Now inherits EV_RADIO_PEER_IMP. Implemented initialize,
--| set_checked. Removed on_activate and on_unselect. Added interface.
--|
--| Revision 1.6  2000/04/03 18:48:18  rogers
--| Removed parent_imp as it can be inherited directly from
--| EV_TOGGLE_BUTTON_IMP.
--|
--| Revision 1.5  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.4  2000/02/19 04:35:44  oconnor
--| added deferred features
--|
--| Revision 1.3  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.5  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.4  2000/01/27 01:09:15  rogers
--| Commented out the old event execution and added a FIXME.
--|
--| Revision 1.2.6.3  2000/01/21 20:35:53  rogers
--| Minor formatting change.
--|
--| Revision 1.2.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
