--------------------------------------------------------------------------------
-- Ehren Fox & Ethan McGill 
-- Department of Electrical and Computer Engineering
-- Iowa State University
--
--------------------------------------------------------------------------------

-- CPU with memory and Full ALU
--------------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a CPU with memory and 
-- the full ALU component designed in this lab 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mux32BitArray.all;

entity cpuFullALU is
port(clk 			: in std_logic;				-- control for clock signal
     readAddr1 			: in std_logic_vector(4 downto 0);	-- First address read from register file
     readAddr2 			: in std_logic_vector(4 downto 0);	-- Second address read from register file
     writeAddr 			: in std_logic_vector(4 downto 0);	-- Address to be written to in register file
     ALUSrc 			: in std_logic;				-- control for ALU with immediate value
     opCode_ALU			: in std_logic_vector(5 downto 0);	-- control for full ALU functions
     i_shift			: in std_logic_vector(4 downto 0);	-- shift amount for full ALU barrel-shifter op
     sign 			: in std_logic;				-- control for sign extension component
     immediate			: in std_logic_vector(15 downto 0);	-- immediate value 
     memWE, memReadEnable 	: in std_logic);			-- control for memory component
end cpuFullALU;

architecture structural of cpuFullALU is

component registerFile is
port(clk 			: in std_logic;
     readOne, readTwo 		: in std_logic_vector(4 downto 0);
     writeAddress 		: in std_logic_vector(4 downto 0);
     writeData 			: in std_logic_vector(31 downto 0);
     reset 			: in std_logic;
     readDataOne 		: out std_logic_vector(31 downto 0);
     readDataTwo 		: out std_logic_vector(31 downto 0));
end component;

component fullALU is
port(i_A, i_B 			: in std_logic_vector(31 downto 0);
     i_Shamt			: in std_logic_vector(4 downto 0);
     op_ALU			: in std_logic_vector(2 downto 0);
     op_Shifter 		: in std_logic_vector(1 downto 0);
     op_Select			: in std_logic; 
     o_F 			: out std_logic_vector(31 downto 0);
     o_Zero 			: out std_logic;
     o_Overflow 		: out std_logic);
end component;

component mux_df is
port(iA 			: in std_logic_vector(31 downto 0);
     iB 			: in std_logic_vector(31 downto 0);
     iCtrl			: in std_logic;
     Q				: out std_logic_vector(31 downto 0));
end component;

component extender is
port(input 			: in std_logic_vector(15 downto 0);
     sel  			: in std_logic;
     output			: out std_logic_vector(31 downto 0));
end component;

component mem is
port(clk 			: in std_logic;
     addr 			: in std_logic_vector(9 downto 0);
     data 			: in std_logic_vector(31 downto 0);
     we 			: in std_logic := '1';
     q 				: out std_logic_vector(31 downto 0));
end component;

signal s_readData1, s_readData2, s_immMux, s_aluResult, s_memRead, s_data, s_imm32 : std_logic_vector(31 downto 0);
signal s_Overflow, s_Zero	:	std_logic;	-- These signals will handle the output of the Full ALU that we don't
							-- need to have explicitly as output signals of the CPU

begin

registers : registerFile
port map(clk 		=> clk,
         readOne 	=> readAddr1,
         readTwo 	=> readAddr2,
         writeAddress   => writeAddr,
         writeData 	=> s_data,
         reset 		=> '0',
         readDataOne    => s_readData1,
         readDataTwo    => s_readData2);

immExtend : extender
port map(input 		=> immediate,
         sel 		=> sign,
         output 	=> s_imm32);

immMux : mux_df
port map(iCtrl 		=> ALUSrc,
         iA 		=> s_readData2,
         iB 		=> s_imm32,
         Q 		=> s_immMux);


alu1 : fullALU
port map(i_A 		=> s_readData1,
         i_B 		=> s_immMux,
         i_Shamt	=> i_shift,
	 op_ALU		=> opCode_ALU(5 downto 3), 	-- opcode for the ALU function is first 3 bits of cpu op
	 op_Shifter     => opCode_ALU(2 downto 1), 	-- opcode for shifter is bits 2 and 1
	 op_Select	=> opCode_ALU(0),		-- opcode for ALU output is bit 0 of CPU opcode
         o_F 		=> s_aluResult);

dmem : mem
port map(clk 		=> clk,
         addr 		=> s_aluResult(11 downto 2),
         data 		=> s_readData2,
         we 		=> memWE,
         q 		=> s_memRead);

memMux : mux_df
port map(iCtrl 		=> memReadEnable,
         iA 		=> s_aluResult,
         iB 		=> s_memRead,
         Q 		=> s_data);

end structural;