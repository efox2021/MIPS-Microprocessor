library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY MEMWBReg IS PORT(
	wb	: in std_logic_vector(2 downto 0);
	dMemOut : in std_logic_vector(31 downto 0);
	aluResult : in std_logic_vector(31 downto 0);
	regDest : in std_logic_vector(4 downto 0);
	Instr : in std_logic_vector(31 downto 0);
	PC	: in std_logic_vector(31 downto 0);
    ld  : IN STD_LOGIC; -- load/enable.
	rd  : IN STD_LOGIC; --read from reg enable
    reset : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
	PC_MEMWB	: out std_logic_vector(31 downto 0);
    wb_MEMWB	: out std_logic_vector(2 downto 0);
	dMemOut_MEMWB : out std_logic_vector(31 downto 0);
	aluResult_MEMWB : out std_logic_vector(31 downto 0);
	Instr_MEMWB : out std_logic_vector(31 downto 0);
	regDest_MEMWB : out std_logic_vector(4 downto 0)
);
END MEMWBReg;

ARCHITECTURE description OF MEMWBReg IS

BEGIN
    process(clk, reset)
    begin
        if reset = '1' then
				wb_MEMWB	<= "000";
				aluResult_MEMWB <= x"00000000";
				dMemOut_MEMWB <= x"00000000";
				regDest_MEMWB <= "00000";
				Instr_MEMWB <= x"00000000";
				PC_MEMWB <= x"00000000";
        elsif rising_edge(clk) then
            if ld = '1' then
                wb_MEMWB	<= wb;
				aluResult_MEMWB <= aluResult;
				dMemOut_MEMWB <= dMemOut;
				regDest_MEMWB <= regDest;
				Instr_MEMWB <= Instr;
				PC_MEMWB <= PC;
            end if;
        end if;
    end process;
END description;