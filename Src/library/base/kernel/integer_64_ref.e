indexing

	description: "References to objects containing an integer value coded on 64 bits"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_64_REF

inherit
	NUMERIC
		rename
			infix "/" as infix "//"
		redefine
			out, is_equal
		end

	COMPARABLE
		redefine
			out, three_way_comparison, is_equal
		end

	HASHABLE
		redefine
			is_hashable, out, is_equal
		end

feature -- Access

	item: INTEGER_64
			-- Integer value

	hash_code: INTEGER is
			-- Hash code value
		do
		end

	sign: INTEGER is
			-- Sign value (0, -1 or 1)
		do
			if item > 0 then
				Result := 1
			elseif item < 0 then
				Result := -1
			end
		ensure
			three_way: Result = three_way_comparison (zero)
		end

	one: like Current is
			-- Neutral element for "*" and "/"
		do
			create Result
			Result.set_item (1)
		end

	zero: like Current is
			-- Neutral element for "+" and "-"
		do
			create Result
			Result.set_item (0)
		end

	ascii_char: CHARACTER is
			-- Returns corresponding ASCII character to `item' value.
		do
			Result := c_ascii_char (item) 
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current integer less than `other'?
		do
			Result := item < other.item
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

	three_way_comparison (other: INTEGER_64_REF): INTEGER is
			-- If current object equal to `other', 0
			-- if smaller, -1; if greater, 1
		do
			if item < other.item then
				Result := -1
			elseif other.item < item then
				Result := 1
			end
		end

feature -- Element change

	set_item (i: INTEGER_64) is
			-- Make `i' the `item' value.
		do
			item := i
		end

feature -- Status report

	divisible (other: INTEGER_64_REF): BOOLEAN is
			-- May current object be divided by `other'?
		do
			Result := other.item /= 0
		ensure then
			value: Result = (other.item /= 0)
		end

	exponentiable (other: NUMERIC): BOOLEAN is
			-- May current object be elevated to the power `other'?
		local
			integer_value: INTEGER_REF
			double_value: DOUBLE_REF
			real_value: REAL_REF
		do
			integer_value ?= other
			real_value ?= other
			double_value ?= other
			if integer_value /= Void then
				Result := integer_value.item >= 0 or item /= 0
			elseif real_value /= Void then
				Result := real_value.item >= 0.0 or item /= 0
			elseif double_value /= Void then
				Result := double_value.item >= 0.0 or item /= 0
			end
		ensure then
			safe_values: ((other.conforms_to (0) and item /= 0) or
				(other.conforms_to (0.0) and item > 0)) implies Result
		end

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= 0
		end

feature -- Basic operations

	abs: INTEGER_64 is
			-- Absolute value
		do
			Result := abs_ref.item
		ensure
			non_negative: Result >= 0
			same_absolute_value: (Result = item) or (Result = -item)
		end

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			create Result
			Result.set_item (item + other.item)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			create Result
			Result.set_item (item - other.item)
		end

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		do
			create Result
			Result.set_item (item * other.item)
		end

	infix "/" (other: like Current): DOUBLE is
			-- Division by `other'
		require
			other_exists: other /= Void
			good_divisor: divisible (other)
		do
			Result := item / other.item
		end

	prefix "+": like Current is
			-- Unary plus
		do
			create Result
			Result.set_item (+ item)
		end

	prefix "-": like Current is
			-- Unary minus
		do
			create Result
			Result.set_item (- item)
		end


	infix "//" (other: like Current): like Current is
			-- Integer division of Current by `other'
		do
			create Result
			Result.set_item (item // other.item)
		end

	infix "\\" (other: like Current): like Current is
			-- Remainder of the integer division of Current by `other'
		require
			other_exists: other /= Void
			good_divisor: divisible (other)
		do
			create Result
			Result.set_item (item \\ other.item)
		ensure
			result_exists: Result /= Void
		end

	infix "^" (other: NUMERIC): DOUBLE is
			-- Integer power of Current by `other'
		local
			integer_value: INTEGER_REF
			real_value: REAL_REF
			double_value: DOUBLE_REF
		do
			integer_value ?= other
			real_value ?= other
			double_value ?= other
			if integer_value /= Void then
				Result := item ^ integer_value.item
			elseif real_value /= Void then
				Result := item ^ real_value.item
			elseif double_value /= Void then
				Result := item ^ double_value.item
			end
		end

feature -- Conversion

	to_integer_8: INTEGER_8 is
			-- Convert `item' into an INTEGER_8 value.
		require
			not_too_small: item >= -128
			not_too_big: item <= 127
		do
			Result := item.to_integer_8
		end

	to_integer_16: INTEGER_16 is
			-- Convert `item' into an INTEGER_16 value.
		require
			not_too_small: item >= -32768
			not_too_big: item <= 32767
		do
			Result := item.to_integer_16
		end

	to_integer, to_integer_32: INTEGER is
			-- Convert `item' into an INTEGER_32 value.
		require
			not_too_small: item >= -2147483648
			not_too_big: item <= 2147483647
		do
			Result := item.to_integer
		end

feature -- Bit operations

	infix "&", bit_and (i: like Current): like Current is
			-- Bitwise and between Current' and `i'.
		do
			create Result
			Result.set_item (eif_bit_and (item, i.item))
		end

	infix "|", bit_or (i: like Current): like Current is
			-- Bitwise or between Current' and `i'.
		do
			create Result
			Result.set_item (eif_bit_or (item, i.item))
		end

	bit_xor (i: like Current): like Current is
			-- Bitwise xor between Current' and `i'.
		do
			create Result
			Result.set_item (eif_bit_xor (item, i.item))
		end

	bit_not: like Current is
			-- One's complement of Current.
		do
			create Result
			Result.set_item (eif_bit_not (item))
		end

	bit_shift (n: INTEGER): like Current is
			-- Shift Current from `n' position to right if `n' positive,
			-- to left otherwise.
		require
			n_less_or_equal_to_64: n <= 64
			n_greater_or_equal_to_minus_64: n >= -64
		do
			if n > 0 then
				Result := bit_shift_right (n)
			else
				Result := bit_shift_left (- n)
			end	
		end

	infix "|<<", bit_shift_left (n: INTEGER): like Current is
			-- Shift Current from `n' position to left.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_64: n <= 64
		do
			create Result
			Result.set_item (eif_bit_shift_left (item, n))
		end

	infix "|>>", bit_shift_right (n: INTEGER): like Current is
			-- Shift Current from `n' position to right.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_64: n <= 64
		do
			create Result
			Result.set_item (eif_bit_shift_right (item, n))
		end

	bit_test (n: INTEGER): BOOLEAN is
			-- Test `n'-th position of Current.
		require
			n_nonnegative: n >= 0
			n_less_than_64: n < 64
		do
			Result := eif_bit_test (item, n)
		end

feature -- Output

	out: STRING is
			-- Printable representation of integer value
		do
			Result := c_outi (item)
		end


feature {NONE} -- Implementation

	c_outi (i: INTEGER_64): STRING is
			-- Printable representation of integer value
		external
			"C | %"eif_out.h%""
		alias
			"c_outi64"
		end

	c_ascii_char (code: INTEGER_64): CHARACTER is
			-- Character associated to integer value
		external
			"C [macro %"eif_misc.h%"]"
		alias
			"chconv"
		end

	abs_ref: INTEGER_64_REF is
			-- Absolute value
		do
			if item >= 0 then
				Result := Current
			else
				Result := -Current
			end
		ensure
			result_exists: Result /= Void
			same_absolute_value: equal (Result, Current) or equal (Result, - Current)
		end

feature {NONE} -- Bit operations implementation

	eif_bit_and (i, j: INTEGER_64): INTEGER_64 is
			-- Bitwise and between `i' and `j'.
		external
			"C [macro %"eif_misc.h%"]"
		end

	eif_bit_or (i, j: INTEGER_64): INTEGER_64 is
			-- Bitwise or between `i' and `j'.
		external
			"C [macro %"eif_misc.h%"]"
		end

	eif_bit_xor (i, j: INTEGER_64): INTEGER_64 is
			-- Bitwise xor between `i' and `j'.
		external
			"C [macro %"eif_misc.h%"]"
		end

	eif_bit_not (i: INTEGER_64): INTEGER_64 is
			-- One's complement of `i'.
		external
			"C [macro %"eif_misc.h%"]"
		end

	eif_bit_shift_left (i: INTEGER_64; n: INTEGER): INTEGER_64 is
			-- Shift `i' from `n' position to left.
		external
			"C [macro %"eif_misc.h%"]"
		end

	eif_bit_shift_right (i: INTEGER_64; n: INTEGER): INTEGER_64 is
			-- Shift `i' from `n' position to right.
		external
			"C [macro %"eif_misc.h%"]"
		end

	eif_bit_test (i: INTEGER_64; n: INTEGER): BOOLEAN is
			-- Test `n'-th bit from `i'.
		external
			"C [macro %"eif_misc.h%"]"
		end

invariant

	sign_times_abs: sign * abs = item

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class INTEGER_64_REF



