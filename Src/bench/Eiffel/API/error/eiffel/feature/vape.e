indexing
	description: "Error when feature is not legally exported."
	date: "$Date$"
	revision: "$Revision$"

class VAPE 

inherit

	FEATURE_ERROR
		redefine
			build_explain, is_defined
		end

feature 

	code: STRING is "VAPE"
			-- Error code

	exported_feature: E_FEATURE
			-- Name of routine not sufficiently exported.

feature -- Access

	is_defined: BOOLEAN is
			-- Is error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then	
				exported_feature /= Void
		ensure then
			valid_exported_feature: Result implies exported_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Construct `st' with error.
		local
			ec: CLASS_C
		do
			ec := exported_feature.written_class
			st.add_string ("Insufficiently exported feature: ")
			exported_feature.append_name (st)
			st.add_string (" from ")
			ec.append_name (st)
			st.add_new_line
		end

feature {ACCESS_FEAT_AS, CREATION_EXPR_AS, BINARY_AS, UNARY_AS} -- Setting

	set_exported_feature (f: FEATURE_I) is
			-- Set `exported_feature' to `f'.
		require
			valid_f: f /= Void
		do
			exported_feature := f.api_feature (f.written_in)
		ensure
			exported_feature_not_void: exported_feature /= Void
		end

end -- class VAPE
