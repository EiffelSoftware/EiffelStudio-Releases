indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CUSTOMIZED_FORMATTER_DIALOG [G -> HASHABLE]

inherit
	EB_CUSTOMIZED_FORMATTER_DIALOG_IMP

	EB_XML_DOCUMENT_HELPER [G]
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_CONSTANTS
		undefine
			copy,
			is_equal,
			default_create
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_SHARED_WINDOW_MANAGER
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_SHARED_MANAGERS
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_METRIC_TOOL_HELPER
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS
		undefine
			copy,
			is_equal,
			default_create
		end

feature {NONE} -- Initialization

	make (a_formatter_getter: like items_getter) is
			-- Initialize `items_getter' with `a_formatter_getter'.
		require
			a_formatter_getter_attached: a_formatter_getter /= Void
		do
			items_getter := a_formatter_getter
			create ok_actions
			create cancel_actions
			create items.make (10)
			create item_grid
			create item_grid_wrapper.make (item_grid)
			create descriptor_row_table.make (10)
			create helper_label
			create property_grid.make_with_description (helper_label)
			item_grid.set_column_count_to (item_grid_column_count)
			default_create
			next_new_item_index := 1
		end

	default_initialize is
			-- Default initialize.
		local
			l_sorting_status: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]
			l_layout: EV_LAYOUT_CONSTANTS
		do
			create l_layout
			set_minimum_size (600, 400)
			empty_selection_label.set_minimum_width (350)

			ok_button.set_text (interface_names.b_ok)
			ok_button.select_actions.extend (agent on_ok)
			l_layout.set_default_size_for_button (ok_button)

			cancel_button.set_text (interface_names.b_cancel)
			cancel_button.select_actions.extend (agent on_cancel)
			l_layout.set_default_size_for_button (cancel_button)

			add_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			add_button.select_actions.extend (agent on_add_item)

			remove_button.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			remove_button.select_actions.extend (agent on_remove_item)
			remove_button.disable_sensitive

			helper_label.set_minimum_height (50)
			helper_label.align_text_left
			help_area.extend (helper_label)

				-- Setup `item_grid'.
			formatter_grid_area.extend (item_grid)
			item_grid.set_minimum_width (150)
			item_grid.enable_single_row_selection

			item_grid.row_select_actions.extend (agent on_item_selected)
			item_grid.row_deselect_actions.extend (agent on_item_deselected)
			item_grid.key_press_actions.extend (agent on_key_pressed_in_item_grid)

				-- Setup sorting information.			
			item_grid_wrapper.set_sort_info (1, create {EVS_GRID_TWO_WAY_SORTING_INFO [G]}.make (agent item_name_tester, ascending_order))
			create l_sorting_status.make (1)
			l_sorting_status.extend ([1, ascending_order])
			item_grid_wrapper.set_sorting_status (l_sorting_status)
			item_grid_wrapper.enable_auto_sort_order_change
			item_grid_wrapper.set_sort_action (agent sort_agent)

			setup_item_grid

				-- Setup `property_grid'.
			property_grid_area.extend (property_grid)
			property_grid.set_minimum_width (350)
			property_grid.hide

			show_actions.extend (agent on_shown)

			set_default_cancel_button (cancel_button)
		end

feature -- Access

	descriptors: LIST [G] is
			-- List of descriptors of `items' defined in Current dialog
		local
			l_descriptors: like items
			l_cursor: DS_ARRAYED_LIST_CURSOR [G]
		do
			create {LINKED_LIST [G]} Result.make
			l_descriptors := items
			l_cursor := items.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				Result.extend (l_cursor.item)
				l_cursor.forth
			end
		ensure
			result_attached: Result /= Void
		end

	items: DS_ARRAYED_LIST [G]
			-- List of items

	ok_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when "OK" button is pressed

	cancel_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when "Cancel" button is pressed

	items_getter: FUNCTION [ANY, TUPLE, LIST [G]]
			-- Agent to get information of `items'

	tool_table: HASH_TABLE [TUPLE [display_name: STRING_32; pixmap: EV_PIXMAP], STRING] is
			-- Table of supported tools			
		local
			l_shell_tools: ES_SHELL_TOOLS
			l_tools: DS_BILINEAR_CURSOR [ES_TOOL [EB_TOOL]]
			l_tool: ES_FORMATTER_TOOL [ES_FORMATTER_TOOL_PANEL_BASE]
			l_custom_tools: LIST [EB_TOOL]
			l_custom_tool: EB_CUSTOMIZED_TOOL
		do
			create Result.make (1)

				-- Access dynamic tools.
			l_shell_tools := window_manager.last_focused_development_window.shell_tools
			l_tools := l_shell_tools.all_tools.new_cursor
			from l_tools.start until l_tools.after loop
				l_tool ?= l_tools.item
				if l_tool /= Void and then l_tool.is_customizable then
					Result.put ([l_tool.edition_title, l_tool.icon_pixmap], l_tool.type_id)
				end
				l_tools.forth
			end

				-- Access customized tools.
				-- FIXME: The formatters need to use the new delayed-activation model!
			l_custom_tools := window_manager.last_focused_development_window.tools.customized_tools
			from l_custom_tools.start until l_custom_tools.after loop
				l_custom_tool ?= l_custom_tools.item
				if l_custom_tool /= Void and then l_custom_tool.is_customized_tool then
					Result.put ([l_custom_tool.title.as_string_32, l_custom_tool.pixmap], l_custom_tool.title_for_pre)
				end
				l_custom_tools.forth
			end
		ensure
			result_attached: Result /= Void
		end

	name_of_item (a_item: G): STRING_GENERAL is
			-- Name of `a_item'
		deferred
		ensure
			result_attached: Result /= Void
		end

	item_grid_column_count: INTEGER is
			-- Number of columns in `item_grid'
		deferred
		ensure
			result_positive: Result > 0
		end

	next_item_name: STRING_GENERAL is
			-- Next item name used when adding new item
		do
			Result := new_item_name.twin
			Result.append (next_new_item_index.out)
		ensure
			result_attached: Result /= Void
		end

	new_item: G is
			-- New item used when adding new item
		deferred
		end

feature -- Status report

	has_changed: BOOLEAN
			-- Has formatter definition changed?
			-- If True, formatter reloading is needed

	is_loaded: BOOLEAN
			-- Have `descriptors' been loaded in Current?

feature -- Setting

	set_has_changed (b: BOOLEAN) is
			-- Set `has_changed' with `b'.
		do
			has_changed := b
		ensure
			has_changed_set: has_changed = b
		end

	set_is_loaded (b: BOOLEAN) is
			-- Set `is_loaded' with `b'.
		do
			is_loaded := b
		ensure
			is_loaded_set: is_loaded = b
		end

	load_descriptors is
			-- Load descriptors retrieved from `items_getter' into Current.
			-- Keep a copy of retrieved descriptors so modification done in Current dialog don't mess up the source.
		deferred
		ensure
			not_changed: not has_changed
		end

feature -- Actions

	on_items_reloaded is
			-- Action to be performed when items are reloaded
		do
			set_is_loaded (False)
		end

feature{NONE} -- Actions

	on_shown is
			-- Action to be performed when Current is displayed
		do
			if not is_loaded then
				refresh
			end
			try_resume_last_selection
			set_has_changed (False)
		end

	on_ok is
			-- Action to be performed when "OK" button is pressed
		do
			if is_displayed then
				hide
			end
			ok_actions.call (Void)
		end

	on_cancel is
			-- Action to be performed when "Cancel" button is pressed
		do
			if is_displayed then
				hide
			end
			if has_changed then
				set_is_loaded (False)
			end
			cancel_actions.call (Void)
		end

	on_add_item is
			-- Action to be performed to add a new customized formatter
		local
			l_grid_row: EV_GRID_ROW
			l_new_item: like new_item
			l_grid: like item_grid
		do
			l_new_item := new_item
			items.force_last (l_new_item)

			l_grid := item_grid
			l_grid.column (1).header_item.remove_pixmap
			l_grid.insert_new_row (l_grid.row_count + 1)
			l_grid_row := l_grid.row (l_grid.row_count)
			bind_item_row (l_new_item, l_grid_row)
			l_grid.remove_selection
			l_grid_row.enable_select
			resize_item_grid
			set_has_changed (True)
			next_new_item_index := next_new_item_index + 1
			descriptor_row_table.put (l_grid_row, l_new_item)
		ensure
			formatter_index_increased: next_new_item_index = old next_new_item_index + 1
			changed: has_changed
		end

	on_remove_item is
			-- Action to be performed to remove selected customized formatter
		local
			l_row: EV_GRID_ROW
			l_descriptor: G
			l_grid: like item_grid
			l_row_index: INTEGER
			l_row_count: INTEGER
		do
			if not item_grid.selected_rows.is_empty then
				l_row := item_grid.selected_rows.first
				l_row_index := l_row.index
				l_descriptor := data_from_row (l_row)
				check l_descriptor /= Void end
				descriptor_row_table.remove (l_descriptor)
				items.start
				items.search_forth (l_descriptor)
				if not items.after then
					items.remove_at
				end
				l_grid := item_grid
				l_grid.remove_row (l_row_index)
				l_row_count := l_grid.row_count
				if l_row_index > l_row_count then
					l_row_index := l_row_count
				end
				if l_row_index > 0 then
					l_grid.row (l_row_index).enable_select
				else
					on_item_deselected (Void)
				end
				set_has_changed (True)
			end
		ensure
			changed: has_changed
		end

	on_item_selected (a_row: EV_GRID_ROW) is
			-- Action to be performed when a formatter contained in `a_row' is selected in `item_grid'
		require
			a_row_attached: a_row /= Void
		local
			l_descriptor: G
		do
			l_descriptor := data_from_row (a_row)
			check l_descriptor /= Void end
			bind_property_grid (l_descriptor)
			set_last_selected_descriptor (l_descriptor)
			empty_selection_label.hide
			property_grid.show
			remove_button.enable_sensitive
		end

	on_item_deselected (a_row: EV_GRID_ROW) is
			-- Action to be performed if `a_row' is deselected in `item_grid'
		do
			if item_grid.selected_rows.is_empty then
				property_grid.hide
				empty_selection_label.show
				remove_button.disable_sensitive
			end
		end

	on_key_pressed_in_item_grid (a_key: EV_KEY) is
			-- Action to be performed if `a_key' is pressed in `item_grid'
		require
			a_key_attached: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_insert then
				on_add_item
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_delete and then remove_button.is_sensitive then
				on_remove_item
			end
		end

feature {NONE} -- Implementation/Data

	item_grid: ES_GRID
			-- Grid to display items list

	property_grid: PROPERTY_GRID
			-- Grid to display properties of an item

	helper_label: ES_LABEL
			-- Label to display help information

	pixmap_from_file (a_file: STRING): EV_PIXMAP is
			-- Pixmap from file `a_file'.			
			-- If file loading failed, we use a default icon for an item.
		require
			a_file_attached: a_file /= Void
		local
			l_pixmap_loader: EB_PIXMAP_LOAD_HELPER
			l_result: TUPLE [a_pixmap: EV_PIXMAP; a_buffer: EV_PIXEL_BUFFER]
		do
			create l_pixmap_loader
			l_result := l_pixmap_loader.loaded_pixmap_from_file (a_file,default_icon_pixmap , Void)
			Result := l_result.a_pixmap
		ensure
			result_attached: Result /= Void
		end

	default_icon_pixmap: EV_PIXMAP is
			-- Default icon pixmap for `items'
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_item_name: STRING is
			-- Base for new created items
		deferred
		ensure
			result_attached: Result /= Void
		end

	next_new_item_index: INTEGER
			-- Index of next created new formatter

	string_8_from_string_32 (a_string_32: STRING_32): STRING_8 is
			-- STRING_8 from STRING_32
		require
			a_string_32_attached: a_string_32 /= Void
		do
			Result := a_string_32.as_string_8
		end

	string_32_from_string_8 (a_string_8: STRING_8): STRING_32 is
			-- STRING_32 from STRING_8
		require
			a_string_8_attached: a_string_8 /= Void
		do
			Result := a_string_8.as_string_32
		end

	last_selected_descriptor: G
			-- Last selected descriptor

	set_last_selected_descriptor (a_descriptor: like last_selected_descriptor) is
			-- Set `last_selected_descriptor' with `a_descriptor'.
		do
			last_selected_descriptor := a_descriptor
		ensure
			last_selected_descriptor_set: last_selected_descriptor = a_descriptor
		end

	item_grid_wrapper: EVS_GRID_WRAPPER [G]
			-- Wrapper for `item_grid' to support sorting

	descriptor_row_table: HASH_TABLE [EV_GRID_ROW, G]
			-- Table of grid rows for descriptors
			-- [Grid row, Descriptor displayed in that row]

	data_from_row (a_row: EV_GRID_ROW): G is
			-- Data from `a_row'.
		deferred
		end

feature {NONE} -- Implementation

	refresh is
			-- Refresh Current dialog to display `descriptors'.
		do
			load_descriptors
			set_is_loaded (True)
			set_last_selected_descriptor (Void)
			item_grid_wrapper.disable_auto_sort_order_change
			item_grid_wrapper.sort (0, 0, 1, 0, 0, 0, 0, 0, 1)
			item_grid_wrapper.enable_auto_sort_order_change
		end

	try_resume_last_selection is
			-- Try to select last selected row.
		local
			l_grid: like item_grid
		do
			if last_selected_descriptor /= Void and then descriptor_row_table.has (last_selected_descriptor) then
				descriptor_row_table.item (last_selected_descriptor).enable_select
			else
				l_grid := item_grid
				if l_grid.selected_rows.is_empty and then l_grid.row_count > 0 then
					l_grid.row (1).enable_select
					l_grid.set_focus
				end
			end
		end

	is_default_item_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a default item name?
			-- A default item name is like "New [item_name] #xxx" where "xxx" is an index integer.
		require
			a_name_attached: a_name /= Void
		local
			l_count: INTEGER
			l_index: STRING
		do
			l_count := new_item_name.count
			if a_name.count > l_count then
				Result := a_name.substring (1, l_count).is_equal (new_item_name)
				if Result then
					l_index := a_name.substring (l_count + 1, a_name.count)
					l_index.left_adjust
					l_index.right_adjust
					Result := l_index.is_integer
				end
			end
		end

	setup_item_grid is
			-- Setup `item_grid'.
		deferred
		end

	bind_item_row (a_descriptor: G; a_grid_row: EV_GRID_ROW) is
			-- Bind `a_descriptor' in `a_grid_row'.
		deferred
		end

	resize_item_grid is
			-- Resize `item_grid'.
		deferred
		end

	bind_item_grid is
			-- Bind formatters in `items' in `item_grid'.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [G]
			l_item_grid: like item_grid
			l_row_table: like descriptor_row_table
			l_grid_row: EV_GRID_ROW
		do
			l_row_table := descriptor_row_table
			l_row_table.wipe_out
			l_item_grid := item_grid
			if l_item_grid.row_count > 0 then
				l_item_grid.remove_rows (1, l_item_grid.row_count)
			end
			l_cursor := items.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_item_grid.insert_new_row (l_item_grid.row_count + 1)
				l_grid_row := l_item_grid.row (l_item_grid.row_count)
				l_row_table.put (l_grid_row, l_cursor.item)
				bind_item_row (l_cursor.item, l_grid_row)
				l_cursor.forth
			end
			resize_item_grid
		end

	bind_property_grid (a_descriptor: G) is
			-- Load information of `a_descriptor' in `property_grid'.
		require
			a_descriptor_attached: a_descriptor /= Void
		deferred
		end

feature{NONE} -- Implementation/Sorting

	item_name_tester (a_item, b_item: G; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order between `a_item' and `a_item' according sorting order specified by `a_order'
		do
			if a_order = ascending_order then
				Result := name_of_item (a_item).as_string_32 <= name_of_item (b_item).as_string_32
			elseif a_order = descending_order then

				Result := name_of_item (a_item).as_string_32 > name_of_item (b_item).as_string_32
			end
		end

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [G]) is
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty:
		local
			l_sorter: DS_QUICK_SORTER [G]
		do
			create l_sorter.make (a_comparator)
			l_sorter.sort (items)
			bind_item_grid
			try_resume_last_selection
		end

invariant
	formatter_grid_attached: item_grid /= Void
	property_grid_attached: property_grid /= Void
	helper_label_attached: helper_label /= Void
	formatter_getter_attached: items_getter /= Void
	ok_actions_attached: ok_actions /= Void
	cancel_actions_attached: cancel_actions /= Void
	formatter_grid_wrapper_attached: item_grid_wrapper /= Void
	descriptor_row_table_attached: descriptor_row_table /= Void
end


