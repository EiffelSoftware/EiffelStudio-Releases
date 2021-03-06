note

	description: 
		"A tasking manager."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	TASK_IMP 

inherit

	LINKED_LIST [COMMAND_EXEC]
		rename
			make as ll_make
		export
			{NONE} all
		end;

	TASK_I
		undefine
			copy, is_equal
		end

	INPUT_EVENT_X
		undefine
			copy, is_equal
		end

create

	make

feature {NONE} -- Initialization

	make
		do
			ll_make;	
			compare_objects
		end;

feature -- Element change

	add_action (a_command: COMMAND; an_argument: ANY)
			-- Add `a_command' with `argument' to the list of action to execute 
			-- while the system is waiting for user events.
		local
			command_info: COMMAND_EXEC;
			ac: like application_context;
		do
			if not is_call_back_set then
				ac := application_context;
				ac.set_work_proc_callback (Current, Void);
				identifier := ac.last_id;
			end;
			create command_info.make (a_command, an_argument);
			extend (command_info);
		end;

feature -- Removal

	remove_action (a_command: COMMAND; an_argument: ANY)
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		local
			command_info: COMMAND_EXEC;
		do
			create command_info.make (a_command, an_argument);
			start;
			search (command_info);
			if not after then
				remove;
			end;
			if empty and is_call_back_set then
				set_no_call_back;
			end;
		end;

feature {NONE} -- Execution

	execute (arg: ANY)
			-- Call the command.
		do
			from
				start
			until
				after
			loop
				item.execute (Void);
				if not after then
					forth;
				end;
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




end -- TASK_IMP


