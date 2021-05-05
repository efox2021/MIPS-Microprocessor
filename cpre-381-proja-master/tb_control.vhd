--------------------------------------------------------------------------------
-- Ehren Fox & Ethan McGill 
-- Department of Electrical and Computer Engineering
-- Iowa State University
--
--------------------------------------------------------------------------------

-- Full ALU Testbench
--------------------------------------------------------------------------------
-- DESCRIPTION: This file contains a Test bench for a 32 bit ALU that can perform 
-- the following functions;   shift left or right (logical) and shift right (arithmetic) 
-- 				and, or, add, sub, xor, nand, nor, and set less than
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_control is
end tb_control;


architecture behavior of tb_control is
component control
port(i_Instr : in std_logic_vector(31 downto 0);
     o_Raddr1 : out std_logic_vector(4 downto 0);
     o_Raddr2 : out std_logic_vector(4 downto 0);
     o_Waddr : out std_logic_vector(4 downto 0);
     o_Shamt : out std_logic_vector(4 downto 0);
     o_Imme : out std_logic_vector(15 downto 0);
     o_ALUSrc : out std_logic;
     o_ALUOp : out std_logic_vector(5 downto 0);
     o_MemRead : out std_logic;
     o_MemWrite : out std_logic;
     o_RegWrite : out std_logic;
     o_signCont : out std_logic);
end component;

signal s_instr : std_logic_vector(31 downto 0);
signal s_addr1, s_addr2, s_waddr, s_shamt : std_logic_vector(4 downto 0);
signal s_aluOp : std_logic_vector(5 downto 0);
signal s_imm : std_logic_vector(15 downto 0);
signal s_ALUSrc, s_MemRead, s_MemWrite, s_RegWrite, s_sign : std_logic;



	-- Helper Function that will output strings on a modelSim waveform --
	-- Will be beneficial in displaying changes or functions in the wves   --
	signal info, info1 : string(1 to 30);

	  function string_fill(msg : string; len : natural) return string is
		variable res_v : string(1 to len);
	  begin
		res_v := (others => ' ');  -- Fill with spaces to blank all for a start
		res_v(1 to msg'length) := msg;
		return res_v;
	  end function;
	  
begin

controller : control
port map(i_Instr => s_instr,
         o_Raddr1 => s_addr1,
         o_Raddr2 => s_addr2,
         o_Waddr => s_waddr,
         o_Shamt => s_shamt,
         o_Imme => s_imm,
         o_ALUSrc => s_ALUSrc,
         o_ALUOp => s_aluOp,
         o_MemRead => s_MemRead,
         o_MemWrite => s_MemWrite,
         o_RegWrite => s_RegWrite,
         o_signCont => s_sign);
		 


process
begin

-------------------------------------------------------------
--Test add throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);
	
	
	-- add $1, $2, ,$0
	info <= string_fill("add $1, $2, ,$3", info'length);
	s_instr <= "00000000001000100001100000100000";
	wait for 200 ns;

	-- add $4, $8, ,$10
	info <= string_fill("add $4, $8, ,$10", info'length);
	s_instr <= "00000000100010000101000000100000";
	wait for 200 ns;

	-- add $1, $6, ,8($3) Dont think you can do this?
	info <= string_fill("add $1, $6, ,8($3)", info'length);
	s_instr <= "00000000001001100001101000100000";
	wait for 200 ns;
	
	-- add $1, $3, $7
	info <= string_fill("add $1, $3, ,$7", info'length);
	s_instr <= "00000000001000110011100000100000";
	wait for 200 ns;
	
	-- add $17, $16, ,3($4) Dont think you can do this?
	info <= string_fill("add $17, $16, ,3($4)", info'length);
	s_instr <= "00000010001100000010000011100000";
	wait for 200 ns;
	
	-- add $9, $12, ,16($6) Dont think you can do this?
	info <= string_fill("add $9, $12, ,16($6)", info'length);
	s_instr <= "00000001001011000011010000100000";
	wait for 200 ns;
	
	
-------------------------------------------------------------
--Test addi throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);
	
	
	-- addi $1, $2, 7
	info <= string_fill("addi $1, $2, 7", info'length);
	s_instr <= "00100000001000100000000000000111";
	wait for 200 ns;  
	
	-- addi $0, $1, 1
	info <= string_fill("addi $0, $1, 1", info'length);
	s_instr <= "00100000000000010000000000000001";
	wait for 200 ns; 
	
	-- addi $4, $1, 9
	info <= string_fill("addi $4, $1, 9", info'length);
	s_instr <= "00100000100000010000000000001001";
	wait for 200 ns; 
	
	-- addi $5, $17, 17
	info <= string_fill("addi $5, $17, 17", info'length);
	s_instr <= "00100000101100010000000000010001";
	wait for 200 ns; 
	
	-- addi $24, $9, 13185
	info <= string_fill("addi $24, $9, 13185", info'length);
	s_instr <= "00100011000010010011001110000001";
	wait for 200 ns; 
	
	-- addi $0, $1, 50
	info <= string_fill("addi $0, $1, 60", info'length);
	s_instr <= "00100000000000010000000000111100";
	wait for 200 ns; 
	
	
-------------------------------------------------------------
--Test addiu throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);
	
	-- addi $1, $2, 7
	info <= string_fill("addiu $1, $2, 7", info'length);
	s_instr <= "00100000001000100000000000000111";
	wait for 200 ns;  
	
	-- addi $0, $1, 1
	info <= string_fill("addiu $0, $1, 1", info'length);
	s_instr <= "00100000000000010000000000000001";
	wait for 200 ns; 
	
	-- addi $4, $1, 9
	info <= string_fill("addiu $4, $1, 9", info'length);
	s_instr <= "00100000100000010000000000001001";
	wait for 200 ns; 
	
	-- addi $5, $17, 17
	info <= string_fill("addiu $5, $17, 17", info'length);
	s_instr <= "00100000101100010000000000010001";
	wait for 200 ns; 
	
	-- addi $24, $9, 13185
	info <= string_fill("addiu $24, $9, 13185", info'length);
	s_instr <= "00100011000010010011001110000001";
	wait for 200 ns; 
	
	-- addi $0, $1, 50
	info <= string_fill("addiu $0, $1, 60", info'length);
	s_instr <= "00100000000000010000000000111100";
	wait for 200 ns; 

-------------------------------------------------------------
--Test addu throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- add $1, $2, ,$0
	info <= string_fill("addu $1, $2, ,$3", info'length);
	s_instr <= "00000000001000100001100000100000";
	wait for 200 ns;

	-- add $4, $8, ,$10
	info <= string_fill("addu $4, $8, ,$10", info'length);
	s_instr <= "00000000100010000101000000100000";
	wait for 200 ns;

	-- add $1, $6, ,8($3) Dont think you can do this?
	info <= string_fill("addu $1, $6, ,8($3)", info'length);
	s_instr <= "00000000001001100001101000100000";
	wait for 200 ns;
	
	-- add $1, $3, $7
	info <= string_fill("addu $1, $3, ,$7", info'length);
	s_instr <= "00000000001000110011100000100000";
	wait for 200 ns;
	
	-- add $17, $16, ,3($4) Dont think you can do this?
	info <= string_fill("addu $17, $16, ,3($4)", info'length);
	s_instr <= "00000010001100000010000011100000";
	wait for 200 ns;
	
	-- add $9, $12, ,16($6) Dont think you can do this?
	info <= string_fill("addu $9, $12, ,16($6)", info'length);
	s_instr <= "00000001001011000011010000100000";
	wait for 200 ns;

-------------------------------------------------------------
-- Test AND throughly here --
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);
	
	
	-- and $1, $2, ,$0
	info <= string_fill("and $1, $2, ,$3", info'length);
	s_instr <= "00000000001000100001100000100100";
	wait for 200 ns;

	-- and $4, $8, ,$10
	info <= string_fill("and $4, $8, ,$10", info'length);
	s_instr <= "00000000100010000101000000100100";
	wait for 200 ns;

	-- and $1, $6, ,8($3) Dont think you can do this?
	info <= string_fill("and $1, $6, ,8($3)", info'length);
	s_instr <= "00000000001001100001101000100100";
	wait for 200 ns;
	
	-- and $1, $3, $7
	info <= string_fill("and $1, $3, ,$7", info'length);
	s_instr <= "00000000001000110011100000100100";
	wait for 200 ns;
	
	-- and $17, $16, ,3($4) Dont think you can do this?
	info <= string_fill("and $17, $16, ,3($4)", info'length);
	s_instr <= "00000010001100000010000011100100";
	wait for 200 ns;
	
	-- and $9, $12, ,16($6) Dont think you can do this?
	info <= string_fill("and $9, $12, ,16($6)", info'length);
	s_instr <= "00000001001011000011010000100100";
	wait for 200 ns;


-------------------------------------------------------------
--Test andi throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);


	-- andi $1, $2, 7
	info <= string_fill("andi $1, $2, 7", info'length);
	s_instr <= "00110000001000100000000000000111";
	wait for 200 ns;  
	
	-- andi $0, $1, 1
	info <= string_fill("andi $0, $1, 1", info'length);
	s_instr <= "00110000000000010000000000000001";
	wait for 200 ns; 
	
	-- andi $4, $1, 9
	info <= string_fill("andi $4, $1, 9", info'length);
	s_instr <= "00110000100000010000000000001001";
	wait for 200 ns; 
	
	-- andi $5, $17, 17
	info <= string_fill("andi $5, $17, 17", info'length);
	s_instr <= "00110000101100010000000000010001";
	wait for 200 ns; 
	
	-- andi $24, $9, 13185
	info <= string_fill("andi $24, $9, 13185", info'length);
	s_instr <= "00110011000010010011001110000001";
	wait for 200 ns; 
	
	-- andi $0, $1, 50
	info <= string_fill("andi $0, $1, 60", info'length);
	s_instr <= "00110000000000010000000000111100";
	wait for 200 ns;
	
	
-------------------------------------------------------------
--Test lui throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- lui $1, $2, 1
	info <= string_fill("lui $1, $2, 1", info'length);
	s_instr <= "10111100001000100000000000000001";
	wait for 200 ns;

	-- lui $2, $3, 2
	info <= string_fill("lui $2, $3, 2", info'length);
	s_instr <= "10111100010000110000000000000010";
	wait for 200 ns;

	-- lui $29, $30, 65534
	info <= string_fill("lui $29, $30, 65534", info'length);
	s_instr <= "10111111101111101111111111111110";
	wait for 200 ns;

	-- lui $30, $31, 65535
	info <= string_fill("lui $30, $31, 65535", info'length);
	s_instr <= "10111111110111111111111111111111";
	wait for 200 ns;

	-- lui $15, $7, 390
	info <= string_fill("lui $15, $7, 390", info'length);
	s_instr <= "10111101111001110000000110000110";
	wait for 200 ns;

	-- lui $20, $13, 5321
	info <= string_fill("lui $20, $13, 5321", info'length);
	s_instr <= "10111110100011010001010011001001";
	wait for 200 ns;

-------------------------------------------------------------
--Test lw throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- lw $1, 0($2)
	info <= string_fill("lw $1, 0($2)", info'length);
	s_instr <= "10001100001000100000000000000001";
	wait for 200 ns;

	-- lw $2, $3, 2
	info <= string_fill("lw $2, $3, 2", info'length);
	s_instr <= "10001100010000110000000000000010";
	wait for 200 ns;

	-- lw $29, 65534($30)
	info <= string_fill("lw $29, 65534($30)", info'length);
	s_instr <= "10001111101111101111111111111110";
	wait for 200 ns;

	-- lw $30, 65535($31)
	info <= string_fill("lw $30, 65535($31)", info'length);
	s_instr <= "10001111110111111111111111111111";
	wait for 200 ns;

	-- lw $15, 390($7)
	info <= string_fill("lw $15, 390($7)", info'length);
	s_instr <= "10001101111001110000000110000110";
	wait for 200 ns;

	-- lw $20, 5321($13)
	info <= string_fill("lw $20, 5321($13)", info'length);
	s_instr <= "10001110100011010001010011001001";
	wait for 200 ns;

-------------------------------------------------------------
--Test nor throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- nor $1, $1, $2
	info <= string_fill("nor $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100111";
	wait for 200 ns;

	-- nor $2, $2, $3
	info <= string_fill("nor $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000100111";
	wait for 200 ns;

	-- nor $29, $29, $30
	info <= string_fill("nor $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000100111";
	wait for 200 ns;

	-- nor $30, $30, $31
	info <= string_fill("nor $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000100111";
	wait for 200 ns;

	-- nor $12, $19, $5
	info <= string_fill("nor $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000100111";
	wait for 200 ns;

	-- nor $8, $21, $9
	info <= string_fill("nor $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000100111";
	wait for 200 ns;

-------------------------------------------------------------
--Test xor throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- xor $1, $1, $2
	info <= string_fill("xor $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100110";
	wait for 200 ns;

	-- xor $2, $2, $3
	info <= string_fill("xor $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000100110";
	wait for 200 ns;

	-- xor $29, $29, $30
	info <= string_fill("xor $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000100110";
	wait for 200 ns;

	-- xor $30, $30, $31
	info <= string_fill("xor $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000100110";
	wait for 200 ns;

	-- xor $12, $19, $5
	info <= string_fill("xor $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000100110";
	wait for 200 ns;

	-- xor $8, $21, $9
	info <= string_fill("xor $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000100110";
	wait for 200 ns;

-------------------------------------------------------------
--Test xori throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- xori $1, $2, 1
	info <= string_fill("xori $1, $2, 1", info'length);
	s_instr <= "00111000001000100000000000000001";
	wait for 200 ns;

	-- xori $2, $3, 2
	info <= string_fill("xori $2, $3, 2", info'length);
	s_instr <= "00111000010000110000000000000010";
	wait for 200 ns;

	-- xori $29, $30, 65534
	info <= string_fill("xori $29, $30, 65534", info'length);
	s_instr <= "00111011101111101111111111111110";
	wait for 200 ns;

	-- xori $30, $31, 65535
	info <= string_fill("xori $30, $31, 65535", info'length);
	s_instr <= "00111011110111111111111111111111";
	wait for 200 ns;

	-- xori $15, $7, 390
	info <= string_fill("xori $15, $7, 390", info'length);
	s_instr <= "00111001111001110000000110000110";
	wait for 200 ns;

	-- xori $20, $13, 5321
	info <= string_fill("xori $20, $13, 5321", info'length);
	s_instr <= "00111010100011010001010011001001";
	wait for 200 ns;

-------------------------------------------------------------
--Test or throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- or $1, $1, $2
	info <= string_fill("or $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100101";
	wait for 200 ns;

	-- or $2, $2, $3
	info <= string_fill("or $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000100101";
	wait for 200 ns;

	-- or $29, $29, $30
	info <= string_fill("or $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000100101";
	wait for 200 ns;

	-- or $30, $30, $31
	info <= string_fill("or $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000100101";
	wait for 200 ns;

	-- or $12, $19, $5
	info <= string_fill("or $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000100101";
	wait for 200 ns;

	-- or $8, $21, $9
	info <= string_fill("or $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000100101";
	wait for 200 ns;

-------------------------------------------------------------
--Test ori throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- ori $1, $2, 1
	info <= string_fill("ori $1, $2, 1", info'length);
	s_instr <= "00110100001000100000000000000001";
	wait for 200 ns;

	-- ori $2, $3, 2
	info <= string_fill("ori $2, $3, 2", info'length);
	s_instr <= "00110100010000110000000000000010";
	wait for 200 ns;

	-- ori $29, $30, 65534
	info <= string_fill("ori $29, $30, 65534", info'length);
	s_instr <= "00110111101111101111111111111110";
	wait for 200 ns;

	-- ori $30, $31, 65535
	info <= string_fill("ori $30, $31, 65535", info'length);
	s_instr <= "00110111110111111111111111111111";
	wait for 200 ns;

	-- ori $15, $7, 390
	info <= string_fill("ori $15, $7, 390", info'length);
	s_instr <= "00110101111001110000000110000110";
	wait for 200 ns;

	-- ori $20, $13, 5321
	info <= string_fill("ori $20, $13, 5321", info'length);
	s_instr <= "00110110100011010001010011001001";
	wait for 200 ns;

-------------------------------------------------------------
--Test slt throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- slt $1, $1, $2
	info <= string_fill("slt $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000101010";
	wait for 200 ns;

	-- slt $2, $2, $3
	info <= string_fill("slt $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000101010";
	wait for 200 ns;

	-- slt $29, $29, $30
	info <= string_fill("slt $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000101010";
	wait for 200 ns;

	-- slt $30, $30, $31
	info <= string_fill("slt $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000101010";
	wait for 200 ns;

	-- slt $12, $19, $5
	info <= string_fill("slt $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000101010";
	wait for 200 ns;

	-- slt $8, $21, $9
	info <= string_fill("slt $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000101010";
	wait for 200 ns;

-------------------------------------------------------------
--Test slti throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- slti $1, $2, 1
	info <= string_fill("slti $1, $2, 1", info'length);
	s_instr <= "00101000001000100000000000000001";
	wait for 200 ns;

	-- slti $2, $3, 2
	info <= string_fill("ori $2, $3, 2", info'length);
	s_instr <= "00101000010000110000000000000010";
	wait for 200 ns;

	-- slti $29, $30, 65534
	info <= string_fill("slti $29, $30, 65534", info'length);
	s_instr <= "00101011101111101111111111111110";
	wait for 200 ns;

	-- slti $30, $31, 65535
	info <= string_fill("slti $30, $31, 65535", info'length);
	s_instr <= "00101011110111111111111111111111";
	wait for 200 ns;

	-- slti $15, $7, 390
	info <= string_fill("slti $15, $7, 390", info'length);
	s_instr <= "00101001111001110000000110000110";
	wait for 200 ns;

	-- slti $20, $13, 5321
	info <= string_fill("slti $20, $13, 5321", info'length);
	s_instr <= "00101010100011010001010011001001";
	wait for 200 ns;

-------------------------------------------------------------
--Test sltiu throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

-------------------------------------------------------------
--Test sltu throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

-------------------------------------------------------------
--Test sll throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- sll $1, $1, 0
	info <= string_fill("sll $1, $1, 0", info'length);
	s_instr <= "00000000001000000000100000000000";
	wait for 200 ns;

	-- sl1 $2, $2, 1
	info <= string_fill("sl1 $2, $2, 1", info'length);
	s_instr <= "00000000010000000001000001000000";
	wait for 200 ns;

	-- sll $29, $29, 30
	info <= string_fill("sll $29, $29, 30", info'length);
	s_instr <= "00000011101000001110111110000000";
	wait for 200 ns;

	-- sll $31, $31, 31
	info <= string_fill("sll $31, $31, 31", info'length);
	s_instr <= "00000011111000001111111111000000";
	wait for 200 ns;

	-- sll $12, $19, 5
	info <= string_fill("sll $12, $19, 5", info'length);
	s_instr <= "00000001100000001001100101000000";
	wait for 200 ns;

	-- sll $8, $21, 9
	info <= string_fill("sll $8, $21, 9", info'length);
	s_instr <= "00000001000000001010101001000000";
	wait for 200 ns;

-------------------------------------------------------------
--Test srl throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- srl $1, $1, 0
	info <= string_fill("srl $1, $1, 0", info'length);
	s_instr <= "00000000001000000000100000000010";
	wait for 200 ns;

	-- srl $2, $2, 1
	info <= string_fill("srl $2, $2, 1", info'length);
	s_instr <= "00000000010000000001000001000010";
	wait for 200 ns;

	-- srl $29, $29, 30
	info <= string_fill("srl $29, $29, 30", info'length);
	s_instr <= "00000011101000001110111110000010";
	wait for 200 ns;

	-- srl $31, $31, 31
	info <= string_fill("srl $31, $31, 31", info'length);
	s_instr <= "00000011111000001111111111000010";
	wait for 200 ns;

	-- srl $12, $19, 5
	info <= string_fill("srl $12, $19, 5", info'length);
	s_instr <= "00000001100000001001100101000010";
	wait for 200 ns;

	-- srl $8, $21, 9
	info <= string_fill("srl $8, $21, 9", info'length);
	s_instr <= "00000001000000001010101001000010";
	wait for 200 ns;

-------------------------------------------------------------
--Test sra throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- sra $1, $1, 0
	info <= string_fill("sra $1, $1, 0", info'length);
	s_instr <= "00000000001000000000100000000011";
	wait for 200 ns;

	-- sra $2, $2, 1
	info <= string_fill("sra $2, $2, 1", info'length);
	s_instr <= "00000000010000000001000001000011";
	wait for 200 ns;

	-- sra $29, $29, 30
	info <= string_fill("sra $29, $29, 30", info'length);
	s_instr <= "00000011101000001110111110000011";
	wait for 200 ns;

	-- sra $31, $31, 31
	info <= string_fill("sra $31, $31, 31", info'length);
	s_instr <= "00000011111000001111111111000011";
	wait for 200 ns;

	-- sra $12, $19, 5
	info <= string_fill("sra $12, $19, 5", info'length);
	s_instr <= "00000001100000001001100101000011";
	wait for 200 ns;

	-- sra $8, $21, 9
	info <= string_fill("sra $8, $21, 9", info'length);
	s_instr <= "00000001000000001010101001000011";
	wait for 200 ns;

-------------------------------------------------------------
--Test sllv throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- sllv $1, $1, $2
	info <= string_fill("sllv $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000000100";
	wait for 200 ns;

	-- sllv $2, $2, $3
	info <= string_fill("sllv $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000000100";
	wait for 200 ns;

	-- sllv $29, $29, $30
	info <= string_fill("sllv $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000000100";
	wait for 200 ns;

	-- sllv $30, $30, $31
	info <= string_fill("sllv $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000000100";
	wait for 200 ns;

	-- sllv $12, $19, $5
	info <= string_fill("sllv $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000000100";
	wait for 200 ns;

	-- sllv $8, $21, $9
	info <= string_fill("sllv $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000000100";
	wait for 200 ns;

-------------------------------------------------------------
--Test srlv throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- srlv $1, $1, $2
	info <= string_fill("srlv $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000000110";
	wait for 200 ns;

	-- srlv $2, $2, $3
	info <= string_fill("srlv $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000000110";
	wait for 200 ns;

	-- srlv $29, $29, $30
	info <= string_fill("srlv $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000000110";
	wait for 200 ns;

	-- srlv $30, $30, $31
	info <= string_fill("srlv $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000000110";
	wait for 200 ns;

	-- srlv $12, $19, $5
	info <= string_fill("srlv $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000000110";
	wait for 200 ns;

	-- srlv $8, $21, $9
	info <= string_fill("srlv $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000000110";
	wait for 200 ns;

-------------------------------------------------------------
--Test srav throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- srav $1, $1, $2
	info <= string_fill("srav $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000000111";
	wait for 200 ns;

	-- srav $2, $2, $3
	info <= string_fill("srav $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000000111";
	wait for 200 ns;

	-- srav $29, $29, $30
	info <= string_fill("srav $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000000111";
	wait for 200 ns;

	-- srav $30, $30, $31
	info <= string_fill("srav $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000000111";
	wait for 200 ns;

	-- srav $12, $19, $5
	info <= string_fill("srav $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000000111";
	wait for 200 ns;

	-- srav $8, $21, $9
	info <= string_fill("srav $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000000111";
	wait for 200 ns;

-------------------------------------------------------------
--Test sw throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- sw $1, 0($2)
	info <= string_fill("sw $1, 0($2)", info'length);
	s_instr <= "10101100001000100000000000000001";
	wait for 200 ns;

	-- sw $2, $3, 2
	info <= string_fill("sw $2, $3, 2", info'length);
	s_instr <= "10101100010000110000000000000010";
	wait for 200 ns;

	-- sw $29, 65534($30)
	info <= string_fill("sw $29, 65534($30)", info'length);
	s_instr <= "10101111101111101111111111111110";
	wait for 200 ns;

	-- sw $30, 65535($31)
	info <= string_fill("sw $30, 65535($31)", info'length);
	s_instr <= "10101111110111111111111111111111";
	wait for 200 ns;

	-- sw $15, 390($7)
	info <= string_fill("sw $15, 390($7)", info'length);
	s_instr <= "10101101111001110000000110000110";
	wait for 200 ns;

	-- sw $20, 5321($13)
	info <= string_fill("sw $20, 5321($13)", info'length);
	s_instr <= "10101110100011010001010011001001";
	wait for 200 ns;

-------------------------------------------------------------
--Test sub throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- sub $1, $1, $2
	info <= string_fill("sub $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100010";
	wait for 200 ns;

	-- sub $2, $2, $3
	info <= string_fill("sub $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000100010";
	wait for 200 ns;

	-- sub $29, $29, $30
	info <= string_fill("sub $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000100010";
	wait for 200 ns;

	-- sub $30, $30, $31
	info <= string_fill("sub $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000100010";
	wait for 200 ns;

	-- sub $12, $19, $5
	info <= string_fill("sub $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000100010";
	wait for 200 ns;

	-- sub $8, $21, $9
	info <= string_fill("sub $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000100010";
	wait for 200 ns;

-------------------------------------------------------------
--Test subu throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- subu $1, $1, $2
	info <= string_fill("subu $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100010";
	wait for 200 ns;

	-- subu $2, $2, $3
	info <= string_fill("subu $2, $2, $3", info'length);
	s_instr <= "00000000010000100001100000100010";
	wait for 200 ns;

	-- subu $29, $29, $30
	info <= string_fill("subu $29, $29, $30", info'length);
	s_instr <= "00000011101111011111000000100010";

	-- subu $30, $30, $31
	info <= string_fill("subu $30, $30, $31", info'length);
	s_instr <= "00000011110111101111100000100010";
	wait for 200 ns;

	-- subu $12, $19, $5
	info <= string_fill("subu $12, $19, $5", info'length);
	s_instr <= "00000001100100110010100000100010";
	wait for 200 ns;

	-- subu $8, $21, $9
	info <= string_fill("subu $8, $21, $9", info'length);
	s_instr <= "00000001000101010100100000100010";
	wait for 200 ns;


wait;

end process;
end behavior;

