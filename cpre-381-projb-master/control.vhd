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
     o_slvCont  : out std_logic);
end control;

architecture behavior of control is

signal s_op, s_funct : std_logic_vector(5 downto 0);

begin

s_op <= i_Instr(31 downto 26);
s_funct <= i_Instr(5 downto 0);

process(i_Instr, s_op, s_funct)
begin

if s_op = "000000" then			--If we have an R type instruction we will proceed to read the function, set register addresses and shamt according to R type
o_Raddr1 <= i_Instr(25 downto 21);
o_Raddr2 <= i_Instr(20 downto 16);
o_Waddr <= i_Instr(15 downto 11);
o_Shamt <= i_Instr(10 downto 6);
o_Imme <= x"0000";
--Now we want to read the function code to decided what instruction we are doing
	if s_funct = "100000" then	--Add
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "010001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "100001" then	--Addu
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "010001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "100100" then	--And
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "000001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "100111" then	--Nor
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "110001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "100110" then	--Xor
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "100001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "100101" then	--Or
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "001001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "101010" then	--Slt
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "111001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "101011" then	--Sltu
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "111001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "000000" then	--Sll
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "000000";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "000010" then	--Srl
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "000010";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "000011" then	--Sra
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "000100";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "000100" then	--Sllv
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "000000";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
	elsif s_funct = "000110" then	--Srlv
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "000010";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '1';
	elsif s_funct = "000111" then	--Srav
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "000100";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '1';
	elsif s_funct = "100010" then	--Sub
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "011001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	elsif s_funct = "100011" then	--Subu
		o_ALUSrc <= '0';
		o_signCont <= '0';
		o_ALUOp <= "011001";
		o_MemRead <= '0';
		o_MemWrite <= '0';
		o_RegWrite <= '1';
		o_luiCont <= '0';
		o_slvCont <= '0';
	end if;
else					--If op code is not 00000 then the instruction is of I type so set the registers accordingly
o_Raddr1 <= i_Instr(25 downto 21);
o_Raddr2 <= "00000";
o_Waddr <= i_Instr(20 downto 16);
o_Imme <= i_Instr(15 downto 0);
o_Shamt <= "00000";
end if;

if s_op = "001000" then			--Addi
	o_ALUSrc <= '1';
	o_signCont <= '1';
	o_ALUOp <= "010001";
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
elsif s_op = "010000" then		--Addiu
	o_ALUSrc <= '1';
	o_signCont <= '1';
	o_ALUOp <= "010001";
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
elsif s_op = "001100" then		--Andi
	o_ALUSrc <= '1';
	o_signCont <= '1';
	o_ALUOp <= "000001";
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
elsif s_op = "101111" then		--Lui
	o_ALUSrc <= '1';
	o_signCont <= '1';
	o_ALUOp <= "010001";
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '1';
	o_slvCont <= '0';
elsif s_op = "100011" then		--Lw
	o_ALUSrc <= '1';
	o_signCont <= '0';
	o_ALUOp <= "010001";
	o_MemRead <= '1';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
elsif s_op = "001110" then		--Xori
	o_ALUSrc <= '1';
	o_signCont <= '1';
	o_ALUOp <= "100001";
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
elsif s_op = "001101" then		--Ori
	o_ALUSrc <= '1';
	o_signCont <= '1';
	o_ALUOp <= "001001";
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
elsif s_op = "001010" then		--Slti
	o_ALUSrc <= '1';
	o_signCont <= '1';
	o_ALUOp <= "111001";
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
elsif s_op = "001011" then		--Sltiu
	o_ALUSrc <= '1';
	o_signCont <= '1';
	o_ALUOp <= "111001";
	o_MemRead <= '0';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
elsif s_op = "101011" then		--Sw
	o_ALUSrc <= '1';
	o_signCont <= '0';
	o_ALUOp <= "010001";
	o_MemRead <= '1';
	o_MemWrite <= '0';
	o_RegWrite <= '1';
	o_luiCont <= '0';
	o_slvCont <= '0';
end if;
end process;
end behavior;