library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY EXMEMReg IS PORT(
    wb	: in std_logic_vector(2 downto 0);
	mem : in std_logic_vector(2 downto 0);
	PC  : in std_logic_vector(31 downto 0);
	aluResult : in std_logic_vector(31 downto 0);
	wrData : in std_logic_vector(31 downto 0);
	regDest : in std_logic_vector(4 downto 0);
	Instr : in std_logic_vector(31 downto 0);
	zero : in std_logic;
    ld  : IN STD_LOGIC; -- load/enable.
	rd  : IN STD_LOGIC; --read from reg enable
    reset : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
	zero_EXMEM  : out std_logic;
    wb_EXMEM	: out std_logic_vector(2 downto 0);
	mem_EXMEM : out std_logic_vector(2 downto 0);
	PC_EXMEM  : out std_logic_vector(31 downto 0);
	aluResult_EXMEM : out std_logic_vector(31 downto 0);
	wrData_EXMEM : out std_logic_vector(31 downto 0);
	Instr_EXMEM : out std_logic_vector(31 downto 0);
	regDest_EXMEM : out std_logic_vector(4 downto 0)
);
END EXMEMReg;

ARCHITECTURE description OF EXMEMReg IS

BEGIN
    process(clk, reset)
    begin
        if reset = '1' then
				wb_EXMEM	<= "000";
				mem_EXMEM <= "000";
				PC_EXMEM  <= x"00000000";
				aluResult_EXMEM <= x"00000000";
				wrData_EXMEM <= x"00000000";
				regDest_EXMEM <= "00000";
				zero_EXMEM <= '0';
				Instr_EXMEM <= x"00000000";
        elsif rising_edge(clk) then
            if ld = '1' then
                wb_EXMEM	<= wb;
				mem_EXMEM <= mem;
				PC_EXMEM  <= PC;
				aluResult_EXMEM <= aluResult;
				wrData_EXMEM <= wrData;
				regDest_EXMEM <= regDest;
				zero_EXMEM <= zero;
				Instr_EXMEM <= Instr;
            end if;
        end if;
    end process;
END description;