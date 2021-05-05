library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY IDEXReg IS PORT(
    wb	: in std_logic_vector(2 downto 0);
	mem : in std_logic_vector(2 downto 0);
	ex  : in std_logic_vector(17 downto 0);
	PC  : in std_logic_vector(31 downto 0);
	i : in std_logic_vector(31 downto 0);
	reg1Data : in std_logic_vector(31 downto 0);
	reg2Data : in std_logic_vector(31 downto 0);
	reg1Addr : in std_logic_vector(4 downto 0);
	reg2Addr : in std_logic_vector(4 downto 0);
	regDestAddr : in std_logic_vector(4 downto 0);
	extended : in std_logic_vector(31 downto 0);
    ld  : IN STD_LOGIC; -- load/enable.
	rd  : IN STD_LOGIC; --read from reg enable
    reset : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    wb_IDEX	: out std_logic_vector(2 downto 0);
	mem_IDEX : out std_logic_vector(2 downto 0);
	ex_IDEX  : out std_logic_vector(17 downto 0);
	PC_IDEX  : out std_logic_vector(31 downto 0);
	reg1Data_IDEX : out std_logic_vector(31 downto 0);
	reg2Data_IDEX : out std_logic_vector(31 downto 0);
	Instr_IDEX : out std_logic_vector(31 downto 0);
	reg1Addr_IDEX : out std_logic_vector(4 downto 0);
	reg2Addr_IDEX : out std_logic_vector(4 downto 0);
	regDestAddr_IDEX : out std_logic_vector(4 downto 0);
	extended_IDEX : out std_logic_vector(31 downto 0)
);
END IDEXReg;

ARCHITECTURE description OF IDEXReg IS

BEGIN
    process(clk, reset)
    begin
        if reset = '1' then
				wb_IDEX	<= "000";
				mem_IDEX <= "000";
				ex_IDEX  <= "000000000000000000";
				PC_IDEX  <= x"00000000";
				reg1Data_IDEX <= x"00000000";
				reg2Data_IDEX <= x"00000000";
				extended_IDEX <= x"00000000";
				Instr_IDEX <= x"00000000";
				reg1Addr_IDEX <= "00000";
				reg2Addr_IDEX <= "00000";
				regDestAddr_IDEX <= "00000";
				
        elsif rising_edge(clk) then
            if ld = '1' then
                wb_IDEX	<= wb;
				mem_IDEX <= mem;
				ex_IDEX  <= ex;
				PC_IDEX  <= PC;
				reg1Data_IDEX <= reg1Data;
				reg2Data_IDEX <= reg2Data;
				extended_IDEX <= extended;
				Instr_IDEX <= i;
				reg1Addr_IDEX <= reg1Addr;
				reg2Addr_IDEX <= reg2Addr;
				regDestAddr_IDEX <= regDestAddr;
            end if;
        end if;
    end process;
END description;