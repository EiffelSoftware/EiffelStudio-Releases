note
	description: "Accelerator example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ACCELERATOR

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	make_and_launch
			-- Create `Current' and launch application.
		do
			default_create
			test_accelerators
			launch
		end

	test_accelerators
			-- Associate an accelerator to `first_window'.
		local
			accelerator: EV_ACCELERATOR
			key: EV_KEY
			key_constants: EV_KEY_CONSTANTS
		do
				-- Create `key_constants' for access to Vision2
				-- key constants.
			create key_constants
			
				-- Create `key' representing q.
			create key.make_with_code (key_constants.key_q)
			
				-- Create an accelerator with Ctrl and key `key' required to activate.
			create accelerator.make_with_key_combination (key, True, False, False)
			
				-- Add an agent to the actions of the accelerator.
			accelerator.actions.extend (agent destroy)
			
				-- Add `accelerator' to the accelerators of `first_window'.
			first_window.accelerators.extend (accelerator)
			
				-- Assign 400 by 300 to the minimum size of `first_window'.
			first_window.set_minimum_size (400, 300)
			
				-- Show `first_window'.
			first_window.show
		end
		
feature {NONE} -- Implementation

	first_window: EV_TITLED_WINDOW
			-- `Result' is main window of example.
		once
			create Result
			Result.set_title ("Accelerator - Press Ctrl Q to exit.")
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


end -- class ACCELERATOR_TEST
