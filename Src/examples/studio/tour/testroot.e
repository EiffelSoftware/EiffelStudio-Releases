note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class TESTROOT create

	make

feature

	o1, o2: PARENT
			-- Examples of attributes

	make
			-- Output messages tracing what's going on.
		do
			display_demonstration_message
			create {HEIR} o1
			create o2
			o1.display
			o2.display
		end

	display_demonstration_message
			-- Output a welcoming message.
		do
			io.put_new_line
			io.put_string (" ISE Eiffel spoken here")
			io.put_new_line
			io.put_string ("--------------------------------%N%N")
		end

		-- To get a typical compilation error, remove the two dashes
		-- at the beginning of the next line:
	-- inv: INVALID;

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


end -- class TESTROOT
