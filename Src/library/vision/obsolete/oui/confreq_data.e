indexing

	description:
		"Information given by EiffelVision when a window's configuration is %
		%asked to change. %
		%The values in this class indicates the hints of the request. %
		%X event associated: `ConfigureRequest'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CONFREQ_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CONFNOT_DATA
		rename
			make as confnot_data_make
		end

creation

	make

feature 

	make (a_widget: WIDGET; a_x, a_y, a_width, a_height, a_border_width: INTEGER) is
			-- Create a context_data for `ConfigureRequest' event.
		do
			confnot_data_make (a_widget, a_x, a_y, a_width, a_height, a_border_width)
		end

end


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

