indexing
	description: "Definition of the sixteen standard colors."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STANDARD_COLORS

feature -- Access

	White: WEL_COLOR_REF is
			-- White color
		once
			create Result.make_rgb (255, 255, 255)
		ensure
			result_not_void: Result /= Void
		end

	Black: WEL_COLOR_REF is
			-- Black color
		once
			create Result.make_rgb (0, 0, 0)
		ensure
			result_not_void: Result /= Void
		end

	Grey, Gray: WEL_COLOR_REF is
			-- Grey color
		once
			create Result.make_rgb (192, 192, 192)
		ensure
			result_not_void: Result /= Void
		end

	Dark_grey, Dark_gray: WEL_COLOR_REF is
			-- Dark grey color
		once
			create Result.make_rgb (128, 128, 128)
		ensure
			result_not_void: Result /= Void
		end

	Blue: WEL_COLOR_REF is
			-- Blue color
		once
			create Result.make_rgb (0, 0, 255)
		ensure
			result_not_void: Result /= Void
		end

	Dark_blue: WEL_COLOR_REF is
			-- Dark blue color
		once
			create Result.make_rgb (0, 0, 128)
		ensure
			result_not_void: Result /= Void
		end

	Cyan: WEL_COLOR_REF is
			-- Cyan color
		once
			create Result.make_rgb (0, 255, 255)
		ensure
			result_not_void: Result /= Void
		end

	Dark_cyan: WEL_COLOR_REF is
			-- Dark cyan color
		once
			create Result.make_rgb (0, 128, 128)
		ensure
			result_not_void: Result /= Void
		end

	Green: WEL_COLOR_REF is
			-- Green color
		once
			create Result.make_rgb (0, 255, 0)
		ensure
			result_not_void: Result /= Void
		end

	Dark_green: WEL_COLOR_REF is
			-- Dark green color
		once
			create Result.make_rgb (0, 128, 0)
		ensure
			result_not_void: Result /= Void
		end

	Yellow: WEL_COLOR_REF is
			-- Yellow color
		once
			create Result.make_rgb (255, 255, 0)
		ensure
			result_not_void: Result /= Void
		end

	Dark_yellow: WEL_COLOR_REF is
			-- Dark yellow color
		once
			create Result.make_rgb (128, 128, 0)
		ensure
			result_not_void: Result /= Void
		end

	Red: WEL_COLOR_REF is
			-- Red color
		once
			create Result.make_rgb (255, 0, 0)
		ensure
			result_not_void: Result /= Void
		end

	Dark_red: WEL_COLOR_REF is
			-- Dark red color
		once
			create Result.make_rgb (128, 0, 0)
		ensure
			result_not_void: Result /= Void
		end

	Magenta: WEL_COLOR_REF is
			-- Magenta color
		once
			create Result.make_rgb (255, 0, 255)
		ensure
			result_not_void: Result /= Void
		end

	Dark_magenta: WEL_COLOR_REF is
			-- Dark magenta color
		once
			create Result.make_rgb (128, 0, 128)
		ensure
			result_not_void: Result /= Void
		end

end -- class WEL_STANDARD_COLORS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

