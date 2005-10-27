indexing
	description: "Objects that represent a paste object command."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PASTE_OBJECT_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

	GB_XML_UTILITIES
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			components := a_components
			make
			set_tooltip ("Paste")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_paste)
			set_name ("Paste")
			set_menu_name ("Paste")
			disable_sensitive
			add_agent (agent execute)

				-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_v)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end

feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			parent_object: GB_OBJECT
			selected_window: GB_WIDGET_SELECTOR_ITEM
		do
			Result := not components.clipboard.is_empty and ((components.tools.layout_constructor.has_focus and components.tools.layout_constructor.selected_item /= Void) or (components.tools.widget_selector.has_focus))
			if components.tools.layout_constructor.has_focus then
				layout_item ?= components.tools.layout_constructor.selected_item
				if layout_item /= Void then
					parent_object ?= layout_item.object
				end
			else
				selected_window ?= components.tools.widget_selector.selected_window
				if selected_window /= Void then
					parent_object ?= selected_window.object
				end
			end
			Result := Result and parent_object /= Void
			if Result then
				Result := Result and parent_object.accepts_child (components.clipboard.object_type) and not parent_object.is_full and not parent_object.is_instance_of_top_level_object

					-- Now ensure that we do not nest an instance of a top level widget in a structure
					-- that does not permit such nesting, thereby preventing nested inheritance cycles.
				if Result then
					Result := Result and parent_object.has_clashing_dependencies (components.clipboard.object_stone)
				end
			end
		end

feature -- Basic operations

		execute is
				-- Execute `Current'.
			local
				layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
				command_add: GB_COMMAND_ADD_OBJECT
				parent_object: GB_PARENT_OBJECT
			do
					--|FIXME handle widget selector.
				layout_item ?= components.tools.layout_constructor.selected_item
				parent_object ?= layout_item.object
				create command_add.make (parent_object, components.clipboard.object, parent_object.children.count + 1, components)
				command_add.execute
			end

end -- class GB_PASTE_OBJECT_COMMAND
