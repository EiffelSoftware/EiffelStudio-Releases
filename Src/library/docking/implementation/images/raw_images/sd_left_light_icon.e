note
	description: "Pixel buffer that replaces orignal image file.%
		%The orignal version of this class has been generated by Image Eiffel Code."
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	SD_LEFT_LIGHT_ICON

inherit
	EV_PIXEL_BUFFER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			make_with_size (41, 35)
			fill_memory
		end

feature {NONE} -- Image data

	c_colors_0 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(00,00,00,00)A(0B,75,83,C1)A(74,80,8F,D2)A(D9,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(98,7F,8E,D2)A(04,00,00,00)A(02,00,00,00)A(01,00,00,00)A(0B,75,83,C1)A(97,80,8F,D2)A(FF,8C,95,BE)A(FF,96,9A,AA)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,81,90,D4)A(0B,00,00,00)
				A(07,00,00,00)A(04,00,00,00)A(74,80,8F,D2)A(FF,8C,95,BE)A(FF,9C,9E,A5)A(FF,A1,A3,AB)A(FF,A7,AA,B1)A(FF,AA,AC,B4)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,81,90,D4)A(16,00,00,00)A(0E,00,00,00)A(09,00,00,00)A(DA,80,8F,D3)A(FF,98,9C,AC)A(FF,A6,A9,B0)A(FF,B8,BA,C3)A(FF,C6,C8,D1)A(FF,CB,CE,D7)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)
				A(FF,81,90,D4)A(25,00,00,00)A(19,00,00,00)A(0E,00,00,00)A(FF,81,90,D4)A(FF,A1,A3,AB)A(FF,B8,BA,C3)A(FF,CE,D1,DA)A(FF,DA,DC,E6)A(FF,DC,DF,E9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(37,00,00,00)A(25,00,00,00)A(16,00,00,00)A(FF,81,90,D4)A(FF,A7,AA,B1)A(FF,C6,C8,D1)A(FF,DA,DC,E6)A(FF,DD,E0,EA)A(FF,BF,C6,E1)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,BF,C6,E1)A(FF,DB,DE,E8)A(FF,DC,DF,E9)
				A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(46,00,00,00)A(2F,00,00,00)A(1C,00,00,00)A(FF,81,90,D4)A(FF,AA,AC,B4)A(FF,CB,CE,D7)A(FF,DC,DF,E9)A(FF,DC,DF,E9)A(FF,AB,B5,DC)A(FF,CF,D9,FC)A(FF,CF,DA,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,CF,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,AB,B5,DC)A(FF,D9,DC,E5)A(FF,DB,DE,E8)A(FF,DC,DF,E9)A(FF,DD,E0,EA)A(FF,81,90,D4)A(51,00,00,00)A(36,00,00,00)A(20,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DB,DE,E8)A(FF,AB,B5,DC)A(FF,A0,B0,ED)A(FF,A0,B0,ED)A(FF,A0,AF,ED)A(FF,A0,B1,ED)A(FF,A0,B0,ED)A(FF,9F,AF,EC)A(FF,9F,B0,ED)A(FF,A0,AF,ED)A(FF,A0,B0,ED)A(FF,A0,B1,ED)A(FF,9F,B0,ED)A(FF,A0,B0,ED)A(FF,9F,B1,ED)A(FF,A0,AF,ED)A(FF,9F,B0,ED)A(FF,A0,AF,ED)A(FF,9F,AF,ED)A(FF,A0,B0,EC)A(FF,9F,AF,ED)A(FF,9F,B0,ED)A(FF,A0,B0,ED)A(FF,9F,B0,ED)A(FF,A0,B0,ED)A(FF,9F,B1,EC)A(FF,A0,AF,ED)A(FF,A1,B1,EE)A(FF,AB,B5,DC)
				A(FF,D4,D7,E1)A(FF,D9,DC,E5)A(FF,DB,DE,E8)A(FF,DD,E0,EA)A(FF,81,90,D4)A(58,00,00,00)A(3B,00,00,00)A(23,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DB,DE,E8)A(FF,AB,B5,DC)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,71,85,D2)A(FF,71,86,D2)A(FF,71,85,D2)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,85,D2)A(FF,72,85,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,85,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,72,87,D2)A(FF,AB,B5,DC)A(FF,D0,D3,DC)A(FF,D7,DA,E4)A(FF,DB,DE,E8)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B6,C0,EC)A(FF,B9,C2,ED)A(FF,BD,C6,EE)A(FF,C1,CA,F0)A(FF,C7,CE,F1)A(FF,CB,D3,F3)A(FF,D0,D7,F4)A(FF,D4,DA,F5)A(FF,D7,DE,F7)A(FF,9E,AC,E7)A(FF,DE,E4,F8)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA)A(FF,EE,F0,FA);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_1 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,EE,F0,FA)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D6,D9,E3)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,B9,C4,EE)A(FF,C0,C8,F0)A(FF,C5,CE,F1)A(FF,CB,D3,F3)A(FF,D2,D9,F5)A(FF,D8,DD,F6)A(FF,DE,E3,F8)A(FF,E2,E6,FA)A(FF,D0,D8,F8)A(FF,F8,F9,FE)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FE,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B6,C0,EC)A(FF,B9,C3,EE)A(FF,C0,C8,EF)A(FF,C5,CE,F2)A(FF,CC,D3,F3)A(FF,D2,D9,F5)A(FF,D8,DE,F6)A(FF,DE,E3,F9)A(FF,E2,E7,FA)A(FF,E5,E9,FB)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)
				A(FF,FE,FF,FF)A(FF,FF,FF,FF)A(FF,FD,FE,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,BA,C3,ED)A(FF,BF,C8,EF)A(FF,C5,CD,F1)A(FF,CC,D3,F3)A(FF,D2,D9,F5)A(FF,D8,DE,F7)A(FF,DE,E2,F9)A(FF,E2,E7,FA)A(FF,A0,AF,EC)A(FF,EB,EF,FC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,F5,F5,F5)A(FF,FE,FE,FE)A(FF,FF,FF,FF)A(FF,FF,FE,FF)A(FF,FE,FE,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,BA,C4,EE)A(FF,BF,C8,EF)A(FF,C5,CD,F1)A(FF,CC,D3,F3)A(FF,D2,D8,F5)A(FF,D8,DD,F7)A(FF,DD,E2,F9)A(FF,E2,E7,FA)A(FF,96,A6,E5)A(FF,EB,EF,FC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,D0,D1,D0)A(FF,93,93,93)A(FF,F6,F6,F6)
				A(FF,FB,FA,FB)A(FF,FE,FE,FF)A(FF,FD,FE,FF)A(FF,FC,FD,FF)A(FF,FC,FD,FE)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,B9,C3,EE)A(FF,BF,C8,EF)A(FF,C5,CD,F1)A(FF,CC,D3,F3)A(FF,D2,D8,F5)A(FF,D8,DE,F7)A(FF,DE,E3,F9)A(FF,E2,E6,FA)A(FF,D0,D8,F8)A(FF,F8,F9,FE)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,C9,C9,C9)A(FF,86,85,85)A(FF,93,93,93)A(FF,E5,E5,E6)A(FF,F3,F4,F5)A(FF,FD,FE,FF)A(FF,FC,FD,FF)A(FF,FC,FC,FF)A(FF,FA,FB,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,B9,C3,ED)A(FF,BF,C8,EF)A(FF,C5,CE,F1)A(FF,CB,D3,F3)A(FF,D2,D8,F5)A(FF,D8,DE,F7)A(FF,DD,E3,F8)A(FF,E2,E6,FA)A(FF,E5,EA,FB)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,C1,C1,C1)A(FF,71,71,71)A(FF,85,85,85)
				A(FF,93,93,93)A(FF,DA,DA,DB)A(FF,EF,F0,F2)A(FF,FB,FC,FF)A(FF,FB,FC,FF)A(FF,FA,FB,FF)A(FF,F9,FA,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,C0,ED)A(FF,BA,C3,ED)A(FF,BF,C8,EF)A(FF,C5,CD,F1)A(FF,CC,D3,F3)A(FF,D2,D9,F5)A(FF,D9,DD,F7)A(FF,DD,E2,F8)A(FF,E2,E7,FA)A(FF,A0,AF,EC)A(FF,EB,EF,FC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,D5,D5,D5)A(FF,5D,5D,5D)A(FF,71,72,71)A(FF,85,85,85)A(FF,93,93,93)A(FF,D6,D7,D9)A(FF,EE,EF,F2)A(FF,FB,FC,FF)A(FF,F9,FB,FF)A(FF,F9,FA,FF)A(FF,F8,F9,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,BA,C4,ED)A(FF,BF,C8,EF)A(FF,C5,CD,F1)A(FF,CC,D3,F3)A(FF,D2,D8,F5)A(FF,D8,DE,F7)A(FF,DE,E3,F9)A(FF,E2,E7,FA)A(FF,96,A6,E5)A(FF,EB,EF,FC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,50,50,50)A(FF,5D,5C,5C)
				A(FF,72,72,71)A(FF,85,85,86)A(FF,93,93,93)A(FF,D6,D6,D9)A(FF,ED,EF,F2)A(FF,FA,FB,FF)A(FF,F9,FA,FF)A(FF,F8,F9,FE)A(FF,F6,F8,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,C0,EC)A(FF,BA,C3,EE)A(FF,BF,C8,EF)A(FF,C5,CD,F1)A(FF,CC,D3,F3)A(FF,D2,D8,F4)A(FF,D8,DE,F7)A(FF,DD,E2,F9)A(FF,E2,E7,F9)A(FF,D0,D8,F8)A(FF,F8,F9,FE)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,F7,F7,F8)A(FF,5C,5D,5D)A(FF,72,72,72)A(FF,85,85,85)A(FF,93,93,93)A(FF,D5,D6,D8)A(FF,EC,EE,F2)A(FF,F8,F9,FF)A(FF,F6,F8,FF)A(FF,F6,F7,FF)A(FF,F5,F6,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,B9,C3,ED)A(FF,BF,C8,EF)A(FF,C5,CE,F1)A(FF,CC,D3,F3)A(FF,D2,D8,F5)A(FF,D8,DE,F7)A(FF,DD,E2,F9)A(FF,E2,E7,FA)A(FF,E5,E9,FB)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FF,FF)A(FF,FF,FE,FF)A(FF,FE,FE,FF);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_2 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,FA,FA,FC)A(FF,EC,ED,EE)A(FF,71,71,72)A(FF,85,85,85)A(FF,93,93,93)A(FF,D3,D5,D8)A(FF,EB,EC,F2)A(FF,F6,F8,FF)A(FF,F5,F7,FF)A(FF,F5,F6,FF)A(FF,F3,F6,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,BA,C4,EE)A(FF,BF,C8,EF)A(FF,C5,CD,F1)A(FF,CC,D3,F3)A(FF,D2,D9,F5)A(FF,D8,DD,F7)A(FF,DD,E2,F9)A(FF,E2,E6,FA)A(FF,A0,AF,EC)A(FF,EB,EF,FC)A(FF,FE,FE,FF)A(FF,FE,FF,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,FC,FD,FF)A(FF,F8,F9,FC)A(FF,EB,EB,EF)A(FF,86,85,85)A(FF,93,93,93)A(FF,D2,D4,D8)A(FF,EA,EB,F1)A(FF,F5,F7,FE)A(FF,F4,F6,FF)A(FF,F2,F5,FF)A(FF,F1,F4,FE)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,B9,C3,ED)A(FF,BF,C8,EF)A(FF,C5,CD,F1)A(FF,CB,D2,F3)A(FF,D2,D8,F5)A(FF,D8,DE,F7)A(FF,DD,E2,F9)A(FF,E2,E6,FA)A(FF,96,A6,E5)A(FF,EA,EE,FC)A(FF,FE,FE,FF)A(FF,FD,FD,FF)
				A(FF,FC,FD,FF)A(FF,FB,FD,FE)A(FF,FB,FB,FF)A(FF,FA,FB,FF)A(FF,F6,F7,FC)A(FF,E8,EA,EF)A(FF,93,93,93)A(FF,D4,D6,DC)A(FF,E9,EA,F2)A(FF,F3,F6,FF)A(FF,F2,F5,FF)A(FF,F2,F4,FE)A(FF,F0,F3,FE)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B6,BF,EC)A(FF,BA,C3,EE)A(FF,BF,C8,EF)A(FF,C6,CD,F1)A(FF,CB,D3,F3)A(FF,D2,D9,F5)A(FF,D8,DE,F7)A(FF,DE,E3,F9)A(FF,E2,E7,FA)A(FF,D0,D9,F8)A(FF,F7,F8,FE)A(FF,FD,FE,FF)A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,FA,FB,FF)A(FF,F9,FB,FE)A(FF,F8,FA,FF)A(FF,F8,F9,FF)A(FF,F3,F5,FC)A(FF,E7,E8,EE)A(FF,DF,E2,E9)A(FF,E9,EC,F4)A(FF,F2,F4,FF)A(FF,F1,F3,FF)A(FF,EF,F2,FF)A(FF,EE,F2,FE)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,BA,C4,ED)A(FF,BF,C8,EF)A(FF,C5,CE,F1)A(FF,CB,D3,F3)A(FF,D2,D9,F5)A(FF,D8,DE,F7)A(FF,DD,E3,F8)A(FF,E2,E7,FA)A(FF,E6,EA,FB)A(FF,FD,FD,FF)
				A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,FA,FB,FF)A(FF,F9,FA,FF)A(FF,F8,F9,FE)A(FF,F7,F9,FF)A(FF,F6,F8,FF)A(FF,F5,F7,FF)A(FF,F1,F3,FB)A(FF,ED,EF,F9)A(FF,EF,F1,FC)A(FF,F0,F3,FF)A(FF,EF,F3,FF)A(FF,EE,F1,FE)A(FF,ED,F1,FE)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B5,BF,EC)A(FF,BA,C3,EE)A(FF,C0,C8,EF)A(FF,C5,CD,F1)A(FF,CB,D3,F3)A(FF,D2,D8,F5)A(FF,D8,DD,F7)A(FF,DD,E2,F9)A(FF,E2,E6,FA)A(FF,A0,AF,EC)A(FF,E9,ED,FC)A(FF,FB,FC,FF)A(FF,FA,FA,FF)A(FF,F9,FA,FF)A(FF,F8,F9,FF)A(FF,F7,F8,FF)A(FF,F6,F7,FE)A(FF,F4,F7,FF)A(FF,F3,F6,FF)A(FF,F2,F4,FE)A(FF,F1,F4,FF)A(FF,F0,F3,FF)A(FF,EF,F2,FF)A(FF,EE,F1,FE)A(FF,ED,F0,FE)A(FF,EB,EF,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,BD,C4,DF)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)
				A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,B7,BE,D9)A(FF,CE,D1,DA)A(FF,D6,D9,E3)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DB,DE,E8)A(FF,D7,DA,E4)A(FF,D0,D3,DC)A(FF,CC,CE,D8)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,CC,CE,D8)A(FF,D0,D3,DC)A(FF,D7,DA,E4)A(FF,DB,DE,E8)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(DC,7F,8E,D2)A(FF,A5,A9,BA)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DB,DE,E8)A(FF,D9,DC,E5)A(FF,D4,D7,E1)A(FF,D0,D3,DC)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)
				A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,D0,D3,DC)A(FF,D4,D7,E1)A(FF,D9,DC,E5)A(FF,DB,DE,E8)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(7C,77,85,C4)A(FF,93,9D,C6)A(FF,CB,CE,D7)A(FF,DC,DF,E9)A(FF,DC,DF,E9)A(FF,DB,DE,E8)A(FF,D9,DC,E5)A(FF,D7,DA,E4)A(FF,D6,D9,E3)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D6,D9,E3)A(FF,D7,DA,E4)A(FF,D9,DC,E5)A(FF,DB,DE,E8)A(FF,DC,DF,E9)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(18,36,3C,58)A(A3,77,85,C3)A(FF,A0,A9,D3)A(FF,CD,D1,E3)A(FF,DD,E0,EA)A(FF,DC,DF,E9)A(FF,DB,DE,E8)A(FF,DB,DE,E8)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_3 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DB,DE,E8)A(FF,DB,DE,E8)A(FF,DC,DF,E9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(58,00,00,00)A(3B,00,00,00)A(23,00,00,00)A(0D,00,00,00)A(24,24,28,3B)A(8D,69,75,AD)A(E4,7B,89,CA)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(C0,65,70,A5)A(51,00,00,00)A(36,00,00,00)A(20,00,00,00)A(0A,00,00,00)A(15,00,00,00)A(25,00,00,00)A(3A,00,00,00)A(4E,00,00,00)A(5E,00,00,00)A(6A,00,00,00)A(71,00,00,00)A(73,00,00,00)
				A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(70,00,00,00)A(67,00,00,00)A(58,00,00,00)A(46,00,00,00)A(2F,00,00,00)A(1C,00,00,00)A(07,00,00,00)A(0F,00,00,00)A(1B,00,00,00)A(2B,00,00,00)A(3A,00,00,00)A(47,00,00,00)A(52,00,00,00)A(58,00,00,00)A(5B,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(58,00,00,00)A(51,00,00,00)A(46,00,00,00)A(37,00,00,00)A(25,00,00,00)A(16,00,00,00)A(04,00,00,00)A(09,00,00,00)A(11,00,00,00)A(1B,00,00,00)A(25,00,00,00)A(2F,00,00,00)A(35,00,00,00)
				A(3A,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3B,00,00,00)A(36,00,00,00)A(2F,00,00,00)A(25,00,00,00)A(19,00,00,00)A(0E,00,00,00)A(02,00,00,00)A(05,00,00,00)A(09,00,00,00)A(0F,00,00,00)A(15,00,00,00)A(1B,00,00,00)A(20,00,00,00)A(23,00,00,00)A(24,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(23,00,00,00)A(20,00,00,00)A(1C,00,00,00)A(16,00,00,00)A(0E,00,00,00)A(09,00,00,00);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	build_colors (a_ptr: POINTER)
			-- Build `colors'.
		do
			c_colors_0 (a_ptr, 0)
			c_colors_1 (a_ptr, 400)
			c_colors_2 (a_ptr, 800)
			c_colors_3 (a_ptr, 1200)
		end

feature {NONE} -- Image data filling.

	fill_memory
			-- Fill image data into memory.
		local
			l_pointer: POINTER
		do
			if attached {EV_PIXEL_BUFFER_IMP} implementation as l_imp then
				l_pointer := l_imp.data_ptr
				if not l_pointer.is_default_pointer then
					build_colors (l_pointer)
					l_imp.unlock
				end
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- SD_LEFT_LIGHT_ICON
