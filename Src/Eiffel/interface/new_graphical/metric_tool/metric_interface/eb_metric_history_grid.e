indexing
	description: "Grid to display metric history"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_HISTORY_GRID

inherit
	EVS_GRID_WRAPPER [EB_METRIC_ARCHIVE_NODE]
		redefine
			grid
		end

	EB_METRIC_INTERFACE_PROVIDER

	EVS_GRID_TWO_WAY_SORTING_ORDER

feature -- Access

	archive: DS_ARRAYED_LIST [EB_METRIC_ARCHIVE_NODE]
			-- Archive to be displayed in Current grid

	widget: EV_WIDGET is
			-- Widget of current grid
		do
			Result := grid
		ensure
			result_attached: Result /= Void
		end

	grid: ES_GRID
			-- Grid for display			

	selected_archives: DS_HASH_SET [EB_METRIC_ARCHIVE_NODE] is
			-- Selected archives
		local
			l_metric_name_item: EV_GRID_CHECKABLE_LABEL_ITEM
			l_archive: EB_METRIC_ARCHIVE_NODE
			l_row_table: like row_archive_table
		do
			create Result.make (10)
			l_row_table := row_archive_table
			from
				l_row_table.start
			until
				l_row_table.after
			loop
				l_metric_name_item ?= l_row_table.item_for_iteration.item (checkbox_item_index)
				check l_metric_name_item /= Void end
				if l_metric_name_item.is_checked then
					l_archive := l_row_table.key_for_iteration
					check l_archive /= Void end
					Result.force (l_archive)
				end
				l_row_table.forth
			end
		end

	selection_change_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when archive selection status changes
		do
			if selection_change_actions_internal = Void then
				create selection_change_actions_internal
			end
			Result := selection_change_actions_internal
		ensure
			result_attached: Result /= Void
		end

	newly_changed_archives: DS_HASH_SET [EB_METRIC_ARCHIVE_NODE] is
			-- Newly changed archive nodes
		do
			Result := metric_history_panel.newly_changed_archives
		ensure
			result_attached: Result /= Void
		end

	metric_history_panel: EB_METRIC_HISTORY_PANEL
			-- Metric history panel to which current grid belongs

	input_domain_change_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when input domain of a archive item changes
		do
			if input_domain_change_actions_internal = Void then
				create input_domain_change_actions_internal
			end
			Result := input_domain_change_actions_internal
		ensure
			result_attached: Result /= Void
		end

	on_selection_changes (a_item: EV_GRID_CHECKABLE_LABEL_ITEM) is
			-- On selection of rows changes
		do
			selection_change_actions.call ([])
		end

	checkbox_item_index: INTEGER is
			-- Item index of checkbox grid item
		deferred
		end

	sorting_order_preference: STRING_PREFERENCE is
			-- Sort order preference
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_recalculatable (a_archive_list: LINEAR [EB_METRIC_ARCHIVE_NODE]): BOOLEAN is
			-- Is `a_archive_list' ready to be recalculated?
		require
			a_archive_list_attached: a_archive_list /= Void
		do
			Result := (not a_archive_list.is_empty) and then a_archive_list.for_all (agent is_archive_recalculatable)
		end

	has_grid_been_binded: BOOLEAN
			-- Has grid been binded?

	is_item_droppable (a_item: EV_GRID_ITEM; a_pebble: ANY): BOOLEAN is
			-- Can `a_pebble' be dropped on `a_item'?
		local
			l_item: EB_METRIC_DOMAIN_GRID_ITEM
		do
			l_item ?= a_item
			Result := l_item /= Void and then l_item.is_pebble_droppable (a_pebble)
		end

feature -- Display

	show is
			-- Display current
		do
			grid.show
		end

	hide is
			-- Hide current
		do
			grid.hide
		end

feature -- Setting

	set_has_grid_been_binded (b: BOOLEAN) is
			-- Set `has_grid_been_binded' with `b'.
		do
			has_grid_been_binded := b
		ensure
			has_grid_been_binded_set: has_grid_been_binded = b
		end

feature -- Grid binding

	bind (a_archive: EB_METRIC_ARCHIVE; a_selected_archive_nodes: like selected_archives) is
			-- Bind `a_archive' in Current grid.
		require
			a_archive_attached: a_archive /= Void
		local
			l_archive: like archive
		do
			create l_archive.make (a_archive.count)
			a_archive.archive.do_all (agent l_archive.force_last)
			archive := l_archive
			disable_auto_sort_order_change
			enable_force_multi_column_sorting
			selected_archives_internal := a_selected_archive_nodes
			sort (0, 0, 1, 0, 0, 0, 0, 0, last_sorted_column)
			selected_archives_internal := Void
			disable_force_multi_column_sorting
			enable_auto_sort_order_change
		end

	update is
			-- Update status of current
		local
			l_row_table: like row_archive_table
		do
			l_row_table := row_archive_table
			from
				l_row_table.start
			until
				l_row_table.after
			loop
				update_row (l_row_table.key_for_iteration)
				l_row_table.forth
			end
		end

feature -- Actions

	on_archive_retrieved (a_archive: EB_METRIC_ARCHIVE_NODE) is
			-- Action to be performed when one archive `a_archive' recalculation has finished
		do
		end

	on_select_all_history_items is
			-- Action to be performed to select all history items
		do
			change_row_selection_status (agent (a_archive_node: EB_METRIC_ARCHIVE_NODE): BOOLEAN do Result := True end, True)
			selection_change_actions.call ([])
		end

	on_deselect_all_history_items is
			-- Action to be performed to deselect all history items
		do
			change_row_selection_status (agent (a_archive_node: EB_METRIC_ARCHIVE_NODE): BOOLEAN do Result := True end, False)
			selection_change_actions.call ([])
		end

	on_select_all_recalculatable_history_items is
			-- Action to be performed to select all recalculatable history items
		do
			change_row_selection_status (agent (a_archive_node: EB_METRIC_ARCHIVE_NODE): BOOLEAN do Result := a_archive_node.is_recalculatable end, True)
			selection_change_actions.call ([])
		end

	on_deselect_all_recalculatable_history_items is
			-- Action to be performed to deselect all recalculatable history items
		do
			change_row_selection_status (agent (a_archive_node: EB_METRIC_ARCHIVE_NODE): BOOLEAN do Result := a_archive_node.is_recalculatable end, False)
			selection_change_actions.call ([])
		end

	on_post_sort (a_sorting_status_snapshot: LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]]) is
			-- Action to be performed after a sorting
		do
			sorting_order_preference.set_value (string_representation_of_sorted_columns)
		end

	on_key_pressed (a_key: EV_KEY) is
			-- Action to be performed when key pressed
		require
			a_key_attached: a_key /= Void
		local
			l_selected_rows: LIST [EV_GRID_ROW]
			l_checkbox_item: EV_GRID_CHECKABLE_LABEL_ITEM
			l_changed: BOOLEAN
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_space or a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				selection_change_actions.block
				l_selected_rows := grid.selected_rows
				if not l_selected_rows.is_empty then
					from
						l_selected_rows.start
					until
						l_selected_rows.after
					loop
						l_checkbox_item ?= l_selected_rows.item.item (checkbox_item_index)
						if l_checkbox_item /= Void then
							l_checkbox_item.set_is_checked (not l_checkbox_item.is_checked)
							l_changed := True
						end
						l_selected_rows.forth
					end
				end
				selection_change_actions.resume
				if l_changed then
					selection_change_actions.call ([])
				end
			end
		end

feature{NONE} -- Grid item generation

	metric_name_item (a_archive_node: EB_METRIC_ARCHIVE_NODE; a_checked: BOOLEAN; a_name_required: BOOLEAN): EV_GRID_CHECKABLE_LABEL_ITEM is
			-- Metric name item for `a_archive_node'. It is a checkable item.
			-- If `a_checked' is True, make sure returned item is checked also.
			-- If `a_name_required' is True, bind metric name.
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			create Result
			Result.checked_changed_actions.extend (agent on_selection_changes)
			if a_checked then
				Result.set_is_checked (True)
			end
			update_metric_name_item (Result, a_archive_node, a_name_required)
		ensure
			result_attached: Result /= Void
		end

	value_item (a_archive_node: EB_METRIC_ARCHIVE_NODE): EV_GRID_LABEL_ITEM is
			-- Value item for `a_archive_node'	
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			create Result
			update_value_item (Result, a_archive_node)
		ensure
			result_attached: Result /= Void
		end


	previous_value_item (a_archive_node: EB_METRIC_ARCHIVE_NODE): EV_GRID_LABEL_ITEM is
			-- Previous value item for `a_archive_node'		
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			create Result
			update_previous_value_item (Result, a_archive_node)
		ensure
			result_attached: Result /= Void
		end

	value_difference_item (a_archive_node: EB_METRIC_ARCHIVE_NODE): EV_GRID_LABEL_ITEM is
			-- Value difference item for `a_archive_node'		
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			create Result
			update_value_difference_item (Result, a_archive_node)
		ensure
			result_attached: Result /= Void
		end

	input_domain_item (a_archive_node: EB_METRIC_ARCHIVE_NODE): EB_METRIC_DOMAIN_GRID_ITEM is
			-- Input domain item for `a_archive_node'	
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			create Result.make (a_archive_node.input_domain)
			Result.set_padding (8)
			Result.pointer_button_press_actions.force_extend (agent Result.activate)
			Result.dialog_ok_actions.extend (agent set_input_domain_back_to_archive_node (Result, a_archive_node))
			Result.before_show_dialog_actions.extend (agent on_before_domain_dialog_display (?, Result))
		ensure
			result_attached: Result /= Void
		end

	status_item (a_archive_node: EB_METRIC_ARCHIVE_NODE): EV_GRID_LABEL_ITEM is
			-- Status item
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			create Result
			Result.set_layout_procedure (agent center_pixmap_layout)
			update_status_item (Result, a_archive_node)
		ensure
			result_attached: Result /= Void
		end

	time_item (a_archive_node: EB_METRIC_ARCHIVE_NODE): EV_GRID_LABEL_ITEM is
			-- time item
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			create Result
			update_time_item (Result, a_archive_node)
		ensure
			result_attached: Result /= Void
		end

	detailed_result_item (a_archive_node: EB_METRIC_ARCHIVE_NODE; a_go_to_result_action: PROCEDURE [ANY, TUPLE [EB_METRIC_ARCHIVE_NODE]]): EV_GRID_LABEL_ITEM is
			-- Detailed result item
			-- If `a_archive_node' containes detailed result, bind `a_go_to_result_action' to double click actions of returned item
		require
			a_archive_node_attached: a_archive_node /= Void
			a_go_to_result_action_attached: a_go_to_result_action /= Void
		do
			create Result
			update_detailed_result_item (Result, a_archive_node, a_go_to_result_action)
		ensure
			result_attached: Result /= Void
		end

	filter_result_item (a_archive_node: EB_METRIC_ARCHIVE_NODE): EV_GRID_CHECKABLE_LABEL_ITEM is
			-- Filter result item
		do
			create Result
			Result.checked_changed_actions.extend (agent on_filter_change (?, a_archive_node))
			update_filter_result_item (Result, a_archive_node)
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Item updator

	update_status_item (a_item: EV_GRID_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Update `a_item' with `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			if a_archive_node.is_up_to_date and then a_archive_node.is_value_valid then
				a_item.set_pixmap (pixmaps.icon_pixmaps.general_tick_icon)
				a_item.set_tooltip (Void)
			else
				a_item.set_pixmap (pixmaps.icon_pixmaps.general_warning_icon)
				a_item.set_tooltip (metric_names.t_archive_not_up_to_date)
			end
		end

	update_input_domain_item (a_item: EB_METRIC_DOMAIN_GRID_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Update `a_item' with `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			a_item.set_domain (a_archive_node.input_domain)
		end

	update_value_item (a_item: EV_GRID_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Update `a_item' with `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			if a_archive_node.is_value_valid then
				a_item.set_text (a_archive_node.value.out)
				a_item.align_text_left
			else
				a_item.set_text (metric_names.t_short_line)
				a_item.align_text_center
			end
		end

	update_metric_name_item (a_item: EV_GRID_CHECKABLE_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE; a_name_required: BOOLEAN) is
			-- Update `a_item' with `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			if a_archive_node.is_recalculatable then
				a_item.set_foreground_color (normal_color)
			else
				a_item.set_foreground_color (red_color)
			end
			if a_name_required then
				a_item.set_text (a_archive_node.metric_name)
				a_item.set_pixmap (pixmap_from_metric_type (a_archive_node.metric_type))
			end
			if not a_archive_node.is_metric_valid then
				a_item.set_tooltip (metric_names.err_metric_not_exist (metric_type_name (a_archive_node.metric_type)))
			elseif not a_archive_node.is_input_domain_valid then
				a_item.set_tooltip (metric_names.err_input_domain_invalid)
			end
		end

	update_previous_value_item (a_item: EV_GRID_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Update `a_item' with `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			if a_archive_node.has_previous_value then
				a_item.set_text (a_archive_node.previous_value.out)
				a_item.align_text_left
			else
				a_item.set_text (metric_names.t_short_line)
				a_item.align_text_center
			end
		end

	update_value_difference_item (a_item: EV_GRID_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Update `a_item' with `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			if a_archive_node.has_previous_value and then a_archive_node.is_value_valid then
				a_item.set_text ((a_archive_node.value - a_archive_node.previous_value).out)
				a_item.align_text_left
			else
				a_item.set_text (metric_names.t_short_line)
				a_item.align_text_center
			end
		end


	update_time_item (a_item: EV_GRID_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Update `a_item' with `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			a_item.set_text (a_archive_node.calculated_time.out)
		end

	update_detailed_result_item (a_item: EV_GRID_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE; a_go_to_result_action: PROCEDURE [ANY, TUPLE [EB_METRIC_ARCHIVE_NODE]]) is
			-- Update `a_item' with `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			a_item.pointer_double_press_actions.wipe_out
			if a_archive_node.has_detailed_result and then a_archive_node.is_recalculatable then
				a_item.set_pixmap (pixmaps.icon_pixmaps.metric_run_and_show_details_icon)
				a_item.set_layout_procedure (agent center_pixmap_layout)
				a_item.pointer_double_press_actions.extend (agent on_go_to_result (?, ?, ?, ?, ?, ?, ?, ?, a_archive_node, a_go_to_result_action))
				a_item.set_tooltip (metric_names.f_double_click_to_go_to_result_panel)
			else
				a_item.remove_pixmap
				a_item.set_layout_procedure (Void)
				a_item.set_tooltip (Void)
			end
		end

	update_filter_result_item (a_item: EV_GRID_CHECKABLE_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Update status of `a_item' using information from `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			a_item.checked_changed_actions.block
			a_item.set_is_checked (a_archive_node.is_result_filtered)
			a_item.checked_changed_actions.resume
		end

feature{NONE} -- Implementation/Sorting

	metric_name_tester (a_archive_node, b_archive_node: EB_METRIC_ARCHIVE_NODE; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order of `a_archive_node' and `b_archive_node' according to current sorting order `a_order'.
		require
			a_archive_node_attached: a_archive_node /= Void
			b_archive_node_attached: b_archive_node /= Void
		local
			l_a_checkbox: EV_GRID_CHECKABLE_LABEL_ITEM
			l_b_checkbox: EV_GRID_CHECKABLE_LABEL_ITEM
			l_a_in_grid: BOOLEAN
			l_b_in_grid: BOOLEAN
		do
			if a_order = topology_order then
				l_a_in_grid := row_archive_table.has (a_archive_node)
				l_b_in_grid := row_archive_table.has (b_archive_node)
				if l_a_in_grid and then l_b_in_grid then
					l_a_checkbox ?= row_archive_table.item (a_archive_node).item (1)
					l_b_checkbox ?= row_archive_table.item (b_archive_node).item (1)
					check
						l_a_checkbox /= Void
						l_b_checkbox /= Void
					end
					if l_a_checkbox.is_checked /= l_b_checkbox.is_checked then
						Result := l_a_checkbox.is_checked and then not l_b_checkbox.is_checked
					else
						Result := a_archive_node.metric_name <= b_archive_node.metric_name
					end
				elseif l_a_in_grid and then not l_b_in_grid then
					Result := True
				end
			else
				if a_order = ascending_order then
					Result := a_archive_node.metric_name <= b_archive_node.metric_name
				else
					Result := a_archive_node.metric_name > b_archive_node.metric_name
				end
			end
		end

	archive_value_tester (a_archive_node, b_archive_node: EB_METRIC_ARCHIVE_NODE; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order of `a_archive_node' and `b_archive_node' according to current sorting order `a_order'.
		require
			a_archive_node_attached: a_archive_node /= Void
			b_archive_node_attached: b_archive_node /= Void
		local
			l_a_order: INTEGER
			l_b_order: INTEGER
		do
			if a_archive_node.is_value_valid then
				l_a_order := 1
			end
			if b_archive_node.is_value_valid then
				l_b_order := 1
			end
			if l_a_order = 0 and then l_b_order = 0 then
			elseif l_a_order = 1 and then l_b_order = 1 then
				if a_order = ascending_order then
					Result := a_archive_node.value < b_archive_node.value
				else
					Result := a_archive_node.value > b_archive_node.value
				end
			else
				if a_order = ascending_order then
					Result := l_a_order <= l_b_order
				else
					Result := l_a_order > l_b_order
				end
			end
		end

	archive_previous_value_tester (a_archive_node, b_archive_node: EB_METRIC_ARCHIVE_NODE; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order of `a_archive_node' and `b_archive_node' according to current sorting order `a_order'.
		require
			a_archive_node_attached: a_archive_node /= Void
			b_archive_node_attached: b_archive_node /= Void
		local
			l_a_order: INTEGER
			l_b_order: INTEGER
		do
			if a_archive_node.has_previous_value then
				l_a_order := 1
			end
			if b_archive_node.has_previous_value then
				l_b_order := 1
			end
			if l_a_order = 0 and then l_b_order = 0 then
			elseif l_a_order = 1 and then l_b_order = 1 then
				if a_order = ascending_order then
					Result := a_archive_node.previous_value < b_archive_node.previous_value
				else
					Result := a_archive_node.previous_value > b_archive_node.previous_value
				end
			else
				if a_order = ascending_order then
					Result := l_a_order <= l_b_order
				else
					Result := l_a_order > l_b_order
				end
			end
		end

	archive_difference_tester (a_archive_node, b_archive_node: EB_METRIC_ARCHIVE_NODE; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order of `a_archive_node' and `b_archive_node' according to current sorting order `a_order'.
		require
			a_archive_node_attached: a_archive_node /= Void
			b_archive_node_attached: b_archive_node /= Void
		local
			l_a_order: INTEGER
			l_b_order: INTEGER
		do
			if a_archive_node.has_previous_value then
				l_a_order := 1
			end
			if b_archive_node.has_previous_value then
				l_b_order := 1
			end
			if l_a_order = 0 and then l_b_order = 0 then
			elseif l_a_order = 1 and then l_b_order = 1 then
				if a_order = ascending_order then
					Result := (a_archive_node.value - a_archive_node.previous_value) <= (b_archive_node.value - b_archive_node.previous_value)
				else
					Result := (a_archive_node.value - a_archive_node.previous_value) > (b_archive_node.value - b_archive_node.previous_value)
				end
			else
				if a_order = ascending_order then
					Result := l_a_order <= l_b_order
				else
					Result := l_a_order > l_b_order
				end
			end
		end

	archive_time_tester (a_archive_node, b_archive_node: EB_METRIC_ARCHIVE_NODE; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order of `a_archive_node' and `b_archive_node' according to current sorting order `a_order'.
		require
			a_archive_node_attached: a_archive_node /= Void
			b_archive_node_attached: b_archive_node /= Void
		local
		do
			if a_order = ascending_order then
				Result := a_archive_node.calculated_time <= b_archive_node.calculated_time
			else
				Result := a_archive_node.calculated_time > b_archive_node.calculated_time
			end
		end

	archive_status_tester (a_archive_node, b_archive_node: EB_METRIC_ARCHIVE_NODE; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order of `a_archive_node' and `b_archive_node' according to current sorting order `a_order'.
		require
			a_archive_node_attached: a_archive_node /= Void
			b_archive_node_attached: b_archive_node /= Void
		local
		do
			if a_archive_node.is_up_to_date /= b_archive_node.is_up_to_date then
				if a_order = ascending_order then
					Result := not a_archive_node.is_up_to_date
				else
					Result := a_archive_node.is_up_to_date
				end
			end
		end

feature{NONE} -- Implementation

	last_selected_nodes: LINKED_LIST [UUID] is
			-- List of UUIDs of archive nodes selected the last time
			-- Used in grid refresh, because we want last time selcted archive nodes
			-- also to be selected after refersh.
		do
			if last_selected_nodes_internal = Void then
				create last_selected_nodes_internal.make
			end
			Result := last_selected_nodes_internal
		end

	last_selected_nodes_internal: like last_selected_nodes
			-- Implementation of `last_selected_nodes'

	selection_change_actions_internal: like selection_change_actions
			-- Implementation of `selection_change_actions'

	is_archive_recalculatable (a_archive_node: EB_METRIC_ARCHIVE_NODE): BOOLEAN is
			-- Is `a_archive_node' recalculatable?
		require
			a_archive_node_attached: a_archive_node /= Void
		do
			Result := a_archive_node.is_recalculatable
		end

	red_color: EV_COLOR is
			-- Red color
		do
			Result := (create {EV_STOCK_COLORS}).red
		ensure
			result_attached: Result /= Void
		end

	normal_color: EV_COLOR is
			-- Normal color for text
		do
		end

	newly_changed_row_background_color: EV_COLOR is
			-- Background color for newly changed rows
		do
			Result := preferences.debug_tool_data.row_highlight_background_color
		end

	normal_row_background_color: EV_COLOR is
			-- Background color for normal rows
		do
		end

	on_go_to_result (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER; a_archive_node: EB_METRIC_ARCHIVE_NODE; a_agent: PROCEDURE [ANY, TUPLE [EB_METRIC_ARCHIVE_NODE]]) is
			-- Action to be performed to go invoke `a_agent' to show detailed result stored in `a_archive_node'
		require
			a_archive_node_attached: a_archive_node /= Void
			a_archive_node_has_detailed_result: a_archive_node.has_detailed_result
			a_agent_attached: a_agent /= Void
		do
			if button = {EV_POINTER_CONSTANTS}.left then
				a_agent.call ([a_archive_node])
			end
		end

	row_archive_table: HASH_TABLE [EV_GRID_ROW, EB_METRIC_ARCHIVE_NODE]
			-- Table to map archive node to its located row

	input_domain_change_actions_internal: like input_domain_change_actions
			-- Implementation of `input_domain_change_actions'

	go_to_result_panel (a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Action to be performed to go to result panel to show detailed result stored in `a_archive_node'
		require
			a_archive_node_attached: a_archive_node /= Void
			a_archive_node_has_detailed_result: a_archive_node.has_detailed_result
		do
			metric_history_panel.metric_tool.register_metric_result_for_display (metric_manager.metric_with_name (a_archive_node.metric_name), a_archive_node.input_domain, a_archive_node.value, a_archive_node.detailed_result, a_archive_node.calculated_time, True, a_archive_node.is_result_filtered)
			metric_history_panel.metric_tool.go_to_result
		end

	set_input_domain_back_to_archive_node (a_item: EB_METRIC_DOMAIN_GRID_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Set domain from `a_item' into `a_archive_node'.
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			if not a_archive_node.input_domain.is_equivalent (a_item.domain) then
				a_archive_node.set_input_domain (a_item.domain.twin)
				a_archive_node.set_is_value_valid (False)
				a_archive_node.set_detailed_result (Void)
				input_domain_change_actions.call ([])
			end
		end

	selected_archives_internal: like selected_archives

	on_drop_on_item (a_item: EV_GRID_ITEM; a_pebble: ANY) is
			-- Action to be performed when `a_pebble' is dropped on `a_item'.
		local
			l_item: EB_METRIC_DOMAIN_GRID_ITEM
			l_archive_node: EB_METRIC_ARCHIVE_NODE
		do
			l_item ?= a_item
			if l_item /= Void then
				l_archive_node ?= a_item.row.data
				check l_archive_node /= Void end
				l_item.add_pebble (a_pebble, agent set_input_domain_back_to_archive_node (l_item, l_archive_node))
			end
		end

	change_row_selection_status (a_agent: FUNCTION [ANY, TUPLE [EB_METRIC_ARCHIVE_NODE], BOOLEAN]; a_status: BOOLEAN) is
			-- If archive node from `archive' satisfied by `a_aggent', change selection status of grid row which displays archive node to `a_status'.
		require
			a_agent_attached: a_agent /= Void
		local
			l_grid_row: EV_GRID_ROW
			l_archive_node: EB_METRIC_ARCHIVE_NODE
			l_checkbox_item: EV_GRID_CHECKABLE_LABEL_ITEM
			l_row_table: like row_archive_table
		do
			selection_change_actions.block
			l_row_table := row_archive_table
			if not l_row_table.is_empty then
				from
					l_row_table.start
				until
					l_row_table.after
				loop
					l_archive_node := l_row_table.key_for_iteration
					l_grid_row := l_row_table.item_for_iteration
					if a_agent.item ([l_archive_node]) then
						l_checkbox_item ?= l_grid_row.item (checkbox_item_index)
						check l_checkbox_item /= Void end
						if l_checkbox_item.is_checked /= a_status then
							l_checkbox_item.set_is_checked (a_status)
						end
					end
					l_row_table.forth
				end
			end
			selection_change_actions.resume
		end

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EB_METRIC_ARCHIVE_NODE]) is
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
		local
			l_sorter: DS_QUICK_SORTER [EB_METRIC_ARCHIVE_NODE]
		do
			create l_sorter.make (a_comparator)
			l_sorter.sort (archive)
			bind_grid (selected_archives_internal)
		end

	bind_grid (a_selected_nodes: like selected_archives) is
			-- Bind `archive' in `grid'.
			-- If `a_selected_nodes' is Void, use values from `selected_archives', otherwise, use `a_selected_nodes'.
		deferred
		end

	update_row (a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Update the row that contains `a_archive_node'.
		require
			a_archive_node_attached: a_archive_node /= Void
		deferred
		end

	on_filter_change (a_item: EV_GRID_CHECKABLE_LABEL_ITEM; a_archive_node: EB_METRIC_ARCHIVE_NODE) is
			-- Action to be performed when check status of `a_item' changes
		require
			a_item_attached: a_item /= Void
			a_archive_node_attached: a_archive_node /= Void
		do
			a_archive_node.set_is_result_filtered (a_item.is_checked)
		end

	on_before_domain_dialog_display (a_doman_grid_dialog: EB_METRIC_DOMAIN_PROPERTY_DIALOG; a_grid_item: EV_GRID_ITEM) is
			-- Acton to be performed before `a_doman_grid_dialog' which associated with `a_grid_item' is displayed
		require
			a_doman_grid_dialog_attached: a_doman_grid_dialog /= Void
			a_grid_item_attached: a_grid_item /= Void
		do
			a_doman_grid_dialog.set_grid_item (a_grid_item)
			a_doman_grid_dialog.property_area.feature_vertion_area.hide
		end

invariant
	last_selected_nodes_attached: last_selected_nodes /= Void
	metric_history_panel_attached: metric_history_panel /= Void
	row_archive_table_attached: row_archive_table /= Void

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end
