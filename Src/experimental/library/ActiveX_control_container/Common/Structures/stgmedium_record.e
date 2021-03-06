note
	description: "This structure describes a medium of transfer for data objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STGMEDIUM_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end
	TYMED_ENUM
	
create
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end
		
feature -- Access

	tymed: INTEGER
			-- Type of storage medium. 
		do
			Result := ccom_stgmedium_tymed (item)
		end
	
	h_bitmap: POINTER
			-- Handle to a bitmap.  
		require
			h_bitmap: tymed = Tymed_gdi
		do
			Result := ccom_stgmedium_h_bitmap (item)
		end
	
	h_meta_file_pict: POINTER
			-- Handle to a metafile.   
		require
			h_meta_file_pict: tymed = Tymed_mfpict
		do
			Result := ccom_stgmedium_h_meta_file_pict (item)
		end
	
	h_enh_meta_file: POINTER
			-- Handle to an enhanced metafile.   
		require
			h_enh_meta_file: tymed = Tymed_enhmf
		do
			Result := ccom_stgmedium_h_enh_meta_file (item)
		end
	
	h_global: POINTER
			-- Global memory handle.  
		require
			h_global: tymed = Tymed_hglobal
		do
			Result := ccom_stgmedium_h_global (item)
		end
	
	lpsz_file_name: STRING
			-- String that contains the path of a disk file 
			-- that contains the data.   
		require
			lpsz_file_name: tymed = Tymed_file
		do
			Result := ccom_stgmedium_lpsz_file_name (item)
		end
	
	pstm: ECOM_STREAM
			-- Pointer to an IStream interface.   
		require
			stream: tymed = Tymed_istream
		do
			Result := ccom_stgmedium_pstm (item)
		end
	
	pstg: ECOM_STORAGE
			-- Pointer to an IStorage interface.   
		require
			storage: tymed = Tymed_istorage
		do
			Result := ccom_stgmedium_pstg (item)
		end
	
	p_unk_for_release: ECOM_UNKNOWN_INTERFACE
			-- Pointer to an interface instance that allows 
			-- the sending process to control the way the 
			-- storage is released when the receiving process 
			-- calls the ReleaseStgMedium function. If 
			-- pUnkForRelease is NULL, ReleaseStgMedium 
			-- uses default procedures to release the storage; 
			-- otherwise, ReleaseStgMedium uses the specified 
			-- IUnknown interface.   
		do
			Result := ccom_stgmedium_p_unk_for_release (item)
		end
		
feature -- Measurement

	structure_size: INTEGER
			-- Size of structure
		do
			Result := c_size_of_stgmedium
		end

feature -- Basic operations

	set_tymed (a_tymed: INTEGER)
			-- Set type of storage medium. 
		do
			ccom_stgmedium_set_tymed (item, a_tymed)
		end
	
	set_h_bitmap (a_h_bitmap: POINTER)
			-- Set handle to a bitmap.  
		do
			ccom_stgmedium_set_h_bitmap (item, a_h_bitmap)
		end
	
	set_h_meta_file_pict (a_h_meta_file_pict: POINTER)
			-- Set handle to a metafile.   
		do
			ccom_stgmedium_set_h_meta_file_pict (item, a_h_meta_file_pict)
		end
	
	set_h_enh_meta_file (a_h_enh_meta_file: POINTER)
			-- Set handle to an enhanced metafile.   
		do
			ccom_stgmedium_set_h_enh_meta_file (item, a_h_enh_meta_file)
		end
	
	set_h_global (a_h_global: POINTER)
			-- Set global memory handle.  
		do
			ccom_stgmedium_set_h_global (item, a_h_global)
		end
	
	set_lpsz_file_name (a_lpsz_file_name: STRING)
			-- Set string that contains the path of a disk file 
			-- that contains the data.   
		do
			ccom_stgmedium_set_lpsz_file_name (item, a_lpsz_file_name)
		end
	
	set_pstm (a_pstm: ECOM_STREAM)
			-- Set pointer to an IStream interface.   
		require
			non_void_stream: a_pstm /= Void
			stream_exists: a_pstm.exists
		do
			ccom_stgmedium_set_pstm (item, a_pstm.item)
		end
	
	set_pstg (a_pstg: ECOM_STORAGE)
			-- Set pointer to an IStorage interface.   
		require
			non_void_storage: a_pstg /= Void
			storage_exists: a_pstg.exists
		do
			ccom_stgmedium_set_pstg (item, a_pstg.item)
		end
	
	set_p_unk_for_release (a_p_unk_for_release: ECOM_UNKNOWN_INTERFACE)
			-- Set pointer to an interface instance that allows 
			-- the sending process to control the way the 
			-- storage is released when the receiving process 
			-- calls the ReleaseStgMedium function. If 
			-- pUnkForRelease is NULL, ReleaseStgMedium 
			-- uses default procedures to release the storage; 
			-- otherwise, ReleaseStgMedium uses the specified 
			-- IUnknown interface.   
		require
			non_void_unknown: a_p_unk_for_release /= Void
			unknown_exists: a_p_unk_for_release.exists
		do
			ccom_stgmedium_set_p_unk_for_release (item, a_p_unk_for_release.item)
		end
		
feature {NONE} -- Externals

	c_size_of_stgmedium: INTEGER
			-- Size of structure
		external
			"C [macro %"ecom_control_library_stgmedium_s_impl.h%"]"
		alias
			"sizeof(STGMEDIUM)"
		end

	ccom_stgmedium_tymed (a_pointer: POINTER): INTEGER
			-- Type of storage medium. 
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_INTEGER"
		end

	ccom_stgmedium_set_tymed (a_pointer: POINTER; a_tymed: INTEGER)
			-- Set type of storage medium. 
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,DWORD)"
		end
	
	ccom_stgmedium_h_bitmap (a_pointer: POINTER): POINTER
			-- Handle to a bitmap.  
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_POINTER"
		end
	
	ccom_stgmedium_set_h_bitmap (a_pointer: POINTER; arg2: POINTER)
			-- Set handle to a bitmap.  
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,HBITMAP)"
		end
	
	ccom_stgmedium_h_meta_file_pict (a_pointer: POINTER): POINTER
			-- Handle to a metafile.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_POINTER"
		end
	
	ccom_stgmedium_set_h_meta_file_pict (a_pointer: POINTER; arg2: POINTER)
			-- Set handle to a metafile.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,HMETAFILEPICT)"
		end
	
	ccom_stgmedium_h_enh_meta_file (a_pointer: POINTER): POINTER
			-- Handle to an enhanced metafile.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_POINTER"
		end
	
	ccom_stgmedium_set_h_enh_meta_file (a_pointer: POINTER; arg2: POINTER)
			-- Set handle to an enhanced metafile.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,HENHMETAFILE)"
		end
	
	ccom_stgmedium_h_global (a_pointer: POINTER): POINTER
			-- Global memory handle.  
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_POINTER"
		end
	
	ccom_stgmedium_set_h_global (a_pointer: POINTER; arg2: POINTER)
			-- Set global memory handle.  
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,HGLOBAL)"
		end
	
	ccom_stgmedium_lpsz_file_name (a_pointer: POINTER): STRING
			-- String that contains the path of a disk file 
			-- that contains the data.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_REFERENCE"
		end
	
	ccom_stgmedium_set_lpsz_file_name (a_pointer: POINTER; arg2: STRING)
			-- Set string that contains the path of a disk file 
			-- that contains the data.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,EIF_REFERENCE)"
		end
	
	ccom_stgmedium_pstm (a_pointer: POINTER): ECOM_STREAM
			-- Pointer to an IStream interface.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_REFERENCE"
		end
	
	ccom_stgmedium_set_pstm (a_pointer: POINTER; arg2: POINTER)
			-- Set pointer to an IStream interface.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,IStream *)"
		end
	
	ccom_stgmedium_pstg (a_pointer: POINTER): ECOM_STORAGE
			-- Pointer to an IStorage interface.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_REFERENCE"
		end
	
	ccom_stgmedium_set_pstg (a_pointer: POINTER; arg2: POINTER)
			-- Pointer to an IStorage interface.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,IStorage *)"
		end
	
	ccom_stgmedium_p_unk_for_release (a_pointer: POINTER): ECOM_UNKNOWN_INTERFACE
			-- Pointer to an interface instance that allows 
			-- the sending process to control the way the 
			-- storage is released when the receiving process 
			-- calls the ReleaseStgMedium function. If 
			-- pUnkForRelease is NULL, ReleaseStgMedium 
			-- uses default procedures to release the storage; 
			-- otherwise, ReleaseStgMedium uses the specified 
			-- IUnknown interface.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *):EIF_REFERENCE"
		end
	
	ccom_stgmedium_set_p_unk_for_release(a_pointer: POINTER; arg2: POINTER)
			-- Set pointer to an interface instance that allows 
			-- the sending process to control the way the 
			-- storage is released when the receiving process 
			-- calls the ReleaseStgMedium function. If 
			-- pUnkForRelease is NULL, ReleaseStgMedium 
			-- uses default procedures to release the storage; 
			-- otherwise, ReleaseStgMedium uses the specified 
			-- IUnknown interface.   
		external
			"C++ [macro %"ecom_control_library_stgmedium_s_impl.h%"](STGMEDIUM *,IUnknown *)"
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




end -- class STGMEDIUM_RECORD
