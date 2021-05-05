--------------------------------------------------------------------------------
-- Ehren Fox & Ethan McGill 
-- Department of Electrical and Computer Engineering
-- Iowa State University
--
--------------------------------------------------------------------------------

-- Control Unit 
--------------------------------------------------------------------------------
-- DESCRIPTION: This our implementation of the control unit needed for our 
-- MIPS Processor
--
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity control is
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
     o_signCont : out std_logic;
     o_luiCont  : out std_logic;
     o_slvCont  : out std_logic;
     o_branchEQ : out std_logic;
     o_branchNE : out std_logic;
     o_jump     : out std_logic;
	 o_jalCont     : out std_logic;
	 o_jumpReg     : out std_logic);
end control;

architecture behavior of control is

signal s_op, s_funct : std_logic_vector(5 downto 0);

begin

s_op <= i_Instr(31 downto 26);
s_funct <= i_Instr(5 downto 0);

process(i_Instr, s_op, s_funct)
begin

	case s_op is
		
		-- RTYPE FORMAT
		when "000000" =>
			
			case s_funct is
				
				-- ADD
				when "100000" =>
					o_ALUOp <= "010001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
					o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
					o_Imme <= x"0000";
				
				-- ADDU
				when "100001" =>
					o_ALUOp <= "010001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- AND
				when "100100" =>
					o_ALUOp <= "000100";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- NOR
				when "100111" =>
					o_ALUOp <= "110001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- XOR
				when "100110" =>
					o_ALUOp <= "100001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- OR
				when "100101" =>
					o_ALUOp <= "001001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SLT
				when "101010" =>
					o_ALUOp <= "111001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SLTU
				when "101011" =>
					o_ALUOp <= "111001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SLL
				when "000000" =>
					o_ALUOp <= "000000";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SRL
				when "000010" =>
					o_ALUOp <= "000010";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SRA
				when "000011" =>
					o_ALUOp <= "000100";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr2 <= i_Instr(25 downto 21);
					o_Raddr1 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SLLV
				when "000100" =>
					o_ALUOp <= "000000";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '1';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(20 downto 16);
					o_Raddr2 <= i_Instr(25 downto 21);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SRLV
				when "000110" =>
					o_ALUOp <= "000010";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '1';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(20 downto 16);
					o_Raddr2 <= i_Instr(25 downto 21);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SRAV
				when "000111" =>
					o_ALUOp <= "000100";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '1';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(20 downto 16);
					o_Raddr2 <= i_Instr(25 downto 21);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SUB
				when "100010" =>
					o_ALUOp <= "011001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
				-- SUBU
				when "100011" =>
					o_ALUOp <= "011001";
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '1';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= i_Instr(25 downto 21);
					o_Raddr2 <= i_Instr(20 downto 16);
					o_Waddr <= i_Instr(15 downto 11);
					o_Shamt <= i_Instr(10 downto 6);
					
				-- JR
				when "001000" =>
					o_Raddr1 <= i_Instr(25 downto 21);
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_ALUOp <= "000000";
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '0';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_BranchEQ <= '0';
					o_BranchNE <= '0';
					o_jump <= '0';
					o_jumpReg <= '1';
					o_jalCont <= '0';
					
					
				when others =>
					o_ALUSrc <= '0';
					o_signCont <= '0';
					o_ALUOp <= "000000";
					o_MemRead <= '0';
					o_MemWrite <= '0';
					o_RegWrite <= '0';
					o_luiCont <= '0';
					o_slvCont <= '0';
					o_branchEQ <= '0';
     				o_branchNE <= '0';
     				o_jump     <= '0';
					o_jalCont <= '0';
					o_jumpReg <= '0';
					o_Raddr1 <= "00000";
					o_Raddr2 <= "00000";
					o_Waddr <= "00000";
					o_Imme <= "0000000000000000";
					o_Shamt <= "00000";
			end case;
		
		-- ADDI
		when "001000"	=>
			o_ALUSrc <= '1';
			o_signCont <= '1';
			o_ALUOp <= "010001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
		
		-- ADDIU
		when "001001"	=>
			o_ALUSrc <= '1';
			o_signCont <= '1';
			o_ALUOp <= "010001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
			
		-- ANDI
		when "001100"	=>
			o_ALUSrc <= '1';
			o_signCont <= '0';
			o_ALUOp <= "000001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
		
		-- LUI
		when "001111"	=>
			o_ALUSrc <= '1';
			o_signCont <= '1';
			o_ALUOp <= "010001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '1';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
			
		-- LW
		when "100011"	=>
			o_ALUSrc <= '1';
			o_signCont <= '0';
			o_ALUOp <= "010001";
			o_MemRead <= '1';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
			
		-- XORI
		when "001110"	=>
			o_ALUSrc <= '1';
			o_signCont <= '1';
			o_ALUOp <= "100001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
			
		-- ORI
		when "001101"	=>
			o_ALUSrc <= '1';
			o_signCont <= '0';
			o_ALUOp <= "001001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
			
		-- SLTI
		when "001010"	=>
			o_ALUSrc <= '1';
			o_signCont <= '1';
			o_ALUOp <= "111001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
			
		-- SLTIU
		when "001011"	=>
			o_ALUSrc <= '1';
			o_signCont <= '1';
			o_ALUOp <= "111001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= "00000";
			o_Waddr <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";
			
		-- SW
		when "101011"	=>
			o_ALUSrc <= '1';
			o_signCont <= '0';
			o_ALUOp <= "010001";
			o_MemRead <= '0';
			o_MemWrite <= '1';
			o_RegWrite <= '0';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= i_Instr(20 downto 16);
			o_Waddr <= "00000";
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";

		-- BEQ
		when "000100" =>
			o_ALUSrc <= '0';
			o_signCont <= '1';
			o_ALUOp <= "011001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '0';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_BranchEQ <= '1';
			o_BranchNE <= '0';
			o_jump <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";

		-- BNE
		when "000101" =>
			o_ALUSrc <= '0';
			o_signCont <= '1';
			o_ALUOp <= "011001";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '0';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_BranchEQ <= '0';
			o_BranchNE <= '1';
			o_jump <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= i_Instr(25 downto 21);
			o_Raddr2 <= i_Instr(20 downto 16);
			o_Imme <= i_Instr(15 downto 0);
			o_Shamt <= "00000";

		-- J
		when "000010" =>
			o_ALUSrc <= '0';
			o_signCont <= '0';
			o_ALUOp <= "000000";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '0';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_BranchEQ <= '0';
			o_BranchNE <= '0';
			o_jump <= '1';
			o_jalCont <= '0';
			o_jumpReg <= '0';

		-- JAL
		when "000011" =>
			o_ALUSrc <= '0';
			o_signCont <= '0';
			o_ALUOp <= "000000";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '1';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_BranchEQ <= '0';
			o_BranchNE <= '0';
			o_jump <= '1';
			o_jalCont <= '1';
			o_jumpReg <= '0';
			o_Waddr <= "11111";
		

		when others =>
			o_ALUSrc <= '0';
			o_signCont <= '0';
			o_ALUOp <= "000000";
			o_MemRead <= '0';
			o_MemWrite <= '0';
			o_RegWrite <= '0';
			o_luiCont <= '0';
			o_slvCont <= '0';
			o_branchEQ <= '0';
     		o_branchNE <= '0';
     		o_jump     <= '0';
			o_jalCont <= '0';
			o_jumpReg <= '0';
			o_Raddr1 <= "00000";
			o_Raddr2 <= "00000";
			o_Waddr <= "00000";
			o_Imme <= "0000000000000000";
			o_Shamt <= "00000";
	end case;
end process;
end behavior;
