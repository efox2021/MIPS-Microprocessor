library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY IFIDReg IS PORT(
    PC   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	Instr   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ld  : IN STD_LOGIC; -- load/enable.
	rd  : IN STD_LOGIC; --read from reg enable
    reset : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    PC_IFID   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- output
	Instr_IFID   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END IFIDReg;

ARCHITECTURE description OF IFIDReg IS

BEGIN
    process(clk, reset, ld)
    begin
        if reset = '1' then
				PC_IFID <= x"00000000";
				Instr_IFID <= x"00000000";
        elsif rising_edge(clk) then
            if ld = '1' and rd = '0' then
                PC_IFID <= PC;
				Instr_IFID <= Instr;
            elsif rd ='1' then
				Instr_IFID <= x"00000000";
			end if;
		end if;
    end process;
END description;