--------------------------------------------------------------------------------
-- Ehren Fox & Ethan McGill 
-- Department of Electrical and Computer Engineering
-- Iowa State University
--
--------------------------------------------------------------------------------

-- Full ALU
--------------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32 bit ALU that can perform the following
-- functions;   shift left or right (logical) and shift right (arithmetic) 
-- 				and, or, add, sub, xor, nand, nor, and set less than
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity fullALU is
	port(op_ALU		:	in std_logic_vector(2 downto 0);
	     op_Shifter         :	in std_logic_vector(1 downto 0);
	     op_Select	        :	in std_logic;
	     i_A		: 	in std_logic_vector(31 downto 0);
	     i_B		:	in std_logic_vector(31 downto 0);
	     i_Shamt	        :	in std_logic_vector(4 downto 0);
	     o_F		:	out std_logic_vector(31 downto 0);
             o_Zero		:	out std_logic;
	     o_Overflow	        :	out std_logic);
end fullALU;

architecture structural of fullALU is
	
	component ALU32Bit
		port(opCode 		: 	in std_logic_vector(2 downto 0);
		     iA			: 	in std_logic_vector(31 downto 0);
		     iB			:	in std_logic_vector(31 downto 0);
		     zero		: 	out std_logic;
		     overFlow		: 	out std_logic;
		     o_F		: 	out std_logic_vector(31 downto 0));
	end component;
	
	component shifter
		port(i_A 		: in std_logic_vector(31 downto 0);
		     i_ShiftAmount 	: in std_logic_vector(4 downto 0);
		     i_Select 		: in std_logic_vector(1 downto 0);
		     o_F 		: out std_logic_vector(31 downto 0));
	end component;	

	component mux_df
		port(iA 	:	in std_logic_vector(31 downto 0);
		     iB 	: 	in std_logic_vector(31 downto 0);
		     iCtrl	: 	in std_logic;
		     Q		: 	out std_logic_vector(31 downto 0));
	end component;
	
	
	--signal s_Cout			: 	std_logic;
	signal s_MuxA, s_MuxB, s_A, s_B	:	std_logic_vector(31 downto 0);
	
	
begin
	
	s_A <= i_A;
	s_B <= i_B;

	barrel_Shifter:	shifter
		port MAP(i_A			=> 	s_A,
			 i_Select		=> 	op_Shifter,
			 i_ShiftAmount		=> 	i_Shamt,
			 o_F			=>	s_MuxA);
	
	alu_32Bit: ALU32Bit
		port MAP(opCode			=> 	op_ALU,
			 iA			=> 	s_A,
			 iB			=> 	s_B,
			 zero			=> 	o_Zero,
			 overFlow		=>	o_Overflow,
			 o_F			=>	s_MuxB);

	mux_2_to_1: mux_df
		port MAP(iA			=>  	s_MuxA,
			 iB			=>  	s_MuxB,
			 iCtrl			=>  	op_Select,
			 Q			=>  	o_F);
	

end structural;