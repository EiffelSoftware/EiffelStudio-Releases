indexing
	description: "Implemented `IEiffelClusterDescriptor' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_CLUSTER_DESCRIPTOR_IMPL_PROXY

inherit
	IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_cluster_descriptor_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	name: STRING is
			-- Cluster name.
		do
			Result := ccom_name (initializer)
		end

	description: STRING is
			-- Cluster description.
		do
			Result := ccom_description (initializer)
		end

	tool_tip: STRING is
			-- Cluster Tool Tip.
		do
			Result := ccom_tool_tip (initializer)
		end

	classes: IENUM_CLASS_INTERFACE is
			-- List of classes in cluster.
		do
			Result := ccom_classes (initializer)
		end

	class_count: INTEGER is
			-- Number of classes in cluster.
		do
			Result := ccom_class_count (initializer)
		end

	clusters: IENUM_CLUSTER_INTERFACE is
			-- List of subclusters in cluster.
		do
			Result := ccom_clusters (initializer)
		end

	cluster_count: INTEGER is
			-- Number of subclusters in cluster.
		do
			Result := ccom_cluster_count (initializer)
		end

	cluster_path: STRING is
			-- Full path to cluster.
		do
			Result := ccom_cluster_path (initializer)
		end

	relative_path: STRING is
			-- Relative path to cluster.
		do
			Result := ccom_relative_path (initializer)
		end

	is_override_cluster: BOOLEAN is
			-- Should this cluster classes take priority over other classes with same name?
		do
			Result := ccom_is_override_cluster (initializer)
		end

	is_library: BOOLEAN is
			-- Should this cluster be treated as library?
		do
			Result := ccom_is_library (initializer)
		end

	is_recursive: BOOLEAN is
			-- Should subclusters be included recursively?
		do
			Result := ccom_is_recursive (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_cluster_descriptor_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_name (cpp_obj: POINTER): STRING is
			-- Cluster name.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_description (cpp_obj: POINTER): STRING is
			-- Cluster description.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_tool_tip (cpp_obj: POINTER): STRING is
			-- Cluster Tool Tip.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_classes (cpp_obj: POINTER): IENUM_CLASS_INTERFACE is
			-- List of classes in cluster.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_class_count (cpp_obj: POINTER): INTEGER is
			-- Number of classes in cluster.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_INTEGER"
		end

	ccom_clusters (cpp_obj: POINTER): IENUM_CLUSTER_INTERFACE is
			-- List of subclusters in cluster.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_cluster_count (cpp_obj: POINTER): INTEGER is
			-- Number of subclusters in cluster.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_INTEGER"
		end

	ccom_cluster_path (cpp_obj: POINTER): STRING is
			-- Full path to cluster.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_relative_path (cpp_obj: POINTER): STRING is
			-- Relative path to cluster.
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_is_override_cluster (cpp_obj: POINTER): BOOLEAN is
			-- Should this cluster classes take priority over other classes with same name?
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_is_library (cpp_obj: POINTER): BOOLEAN is
			-- Should this cluster be treated as library?
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_is_recursive (cpp_obj: POINTER): BOOLEAN is
			-- Should subclusters be included recursively?
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](): EIF_BOOLEAN"
		end

	ccom_delete_ieiffel_cluster_descriptor_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"]()"
		end

	ccom_create_ieiffel_cluster_descriptor_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterDescriptor_impl_proxy %"ecom_eiffel_compiler_IEiffelClusterDescriptor_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IEIFFEL_CLUSTER_DESCRIPTOR_IMPL_PROXY

