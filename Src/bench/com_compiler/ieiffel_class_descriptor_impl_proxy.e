indexing
	description: "Implemented `IEiffelClassDescriptor' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_CLASS_DESCRIPTOR_IMPL_PROXY

inherit
	IEIFFEL_CLASS_DESCRIPTOR_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_class_descriptor_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	name: STRING is
			-- Class name.
		do
			Result := ccom_name (initializer)
		end

	description: STRING is
			-- Class description.
		do
			Result := ccom_description (initializer)
		end

	external_name: STRING is
			-- Class external name.
		do
			Result := ccom_external_name (initializer)
		end

	tool_tip: STRING is
			-- Class Tool Tip.
		do
			Result := ccom_tool_tip (initializer)
		end

	is_in_system: BOOLEAN is
			-- Is class in system?
		do
			Result := ccom_is_in_system (initializer)
		end

	feature_names: ECOM_ARRAY [STRING] is
			-- List of names of class features.
		do
			Result := ccom_feature_names (initializer)
		end

	features: IENUM_FEATURE_INTERFACE is
			-- List of class features.
		do
			Result := ccom_features (initializer)
		end

	feature_count: INTEGER is
			-- Number of class features.
		do
			Result := ccom_feature_count (initializer)
		end

	flat_features: IENUM_FEATURE_INTERFACE is
			-- List of class features including ancestor features.
		do
			Result := ccom_flat_features (initializer)
		end

	flat_feature_count: INTEGER is
			-- Number of flat class features.
		do
			Result := ccom_flat_feature_count (initializer)
		end

	clients: IENUM_CLASS_INTERFACE is
			-- List of class clients.
		do
			Result := ccom_clients (initializer)
		end

	client_count: INTEGER is
			-- Number of class clients.
		do
			Result := ccom_client_count (initializer)
		end

	suppliers: IENUM_CLASS_INTERFACE is
			-- List of class suppliers.
		do
			Result := ccom_suppliers (initializer)
		end

	supplier_count: INTEGER is
			-- Number of class suppliers.
		do
			Result := ccom_supplier_count (initializer)
		end

	ancestors: IENUM_CLASS_INTERFACE is
			-- List of direct ancestors of class.
		do
			Result := ccom_ancestors (initializer)
		end

	ancestor_count: INTEGER is
			-- Number of direct ancestors.
		do
			Result := ccom_ancestor_count (initializer)
		end

	descendants: IENUM_CLASS_INTERFACE is
			-- List of direct descendants of class.
		do
			Result := ccom_descendants (initializer)
		end

	descendant_count: INTEGER is
			-- Number of direct descendants.
		do
			Result := ccom_descendant_count (initializer)
		end

	class_path: STRING is
			-- Full path to file.
		do
			Result := ccom_class_path (initializer)
		end

	is_deferred: BOOLEAN is
			-- Is class deferred?
		do
			Result := ccom_is_deferred (initializer)
		end

	is_external: BOOLEAN is
			-- Is class external?
		do
			Result := ccom_is_external (initializer)
		end

	is_generic: BOOLEAN is
			-- Is class generic?
		do
			Result := ccom_is_generic (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_class_descriptor_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_name (cpp_obj: POINTER): STRING is
			-- Class name.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_description (cpp_obj: POINTER): STRING is
			-- Class description.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_external_name (cpp_obj: POINTER): STRING is
			-- Class external name.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_tool_tip (cpp_obj: POINTER): STRING is
			-- Class Tool Tip.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_is_in_system (cpp_obj: POINTER): BOOLEAN is
			-- Is class in system?
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_feature_names (cpp_obj: POINTER): ECOM_ARRAY [STRING] is
			-- List of names of class features.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_features (cpp_obj: POINTER): IENUM_FEATURE_INTERFACE is
			-- List of class features.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_feature_count (cpp_obj: POINTER): INTEGER is
			-- Number of class features.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_INTEGER"
		end

	ccom_flat_features (cpp_obj: POINTER): IENUM_FEATURE_INTERFACE is
			-- List of class features including ancestor features.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_flat_feature_count (cpp_obj: POINTER): INTEGER is
			-- Number of flat class features.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_INTEGER"
		end

	ccom_clients (cpp_obj: POINTER): IENUM_CLASS_INTERFACE is
			-- List of class clients.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_client_count (cpp_obj: POINTER): INTEGER is
			-- Number of class clients.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_INTEGER"
		end

	ccom_suppliers (cpp_obj: POINTER): IENUM_CLASS_INTERFACE is
			-- List of class suppliers.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_supplier_count (cpp_obj: POINTER): INTEGER is
			-- Number of class suppliers.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_INTEGER"
		end

	ccom_ancestors (cpp_obj: POINTER): IENUM_CLASS_INTERFACE is
			-- List of direct ancestors of class.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_ancestor_count (cpp_obj: POINTER): INTEGER is
			-- Number of direct ancestors.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_INTEGER"
		end

	ccom_descendants (cpp_obj: POINTER): IENUM_CLASS_INTERFACE is
			-- List of direct descendants of class.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_descendant_count (cpp_obj: POINTER): INTEGER is
			-- Number of direct descendants.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_INTEGER"
		end

	ccom_class_path (cpp_obj: POINTER): STRING is
			-- Full path to file.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_is_deferred (cpp_obj: POINTER): BOOLEAN is
			-- Is class deferred?
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_is_external (cpp_obj: POINTER): BOOLEAN is
			-- Is class external?
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_is_generic (cpp_obj: POINTER): BOOLEAN is
			-- Is class generic?
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_delete_ieiffel_class_descriptor_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"]()"
		end

	ccom_create_ieiffel_class_descriptor_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::IEiffelClassDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClassDescriptor_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IEIFFEL_CLASS_DESCRIPTOR_IMPL_PROXY

