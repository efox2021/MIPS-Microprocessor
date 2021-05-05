library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY register32 IS PORT(
    d   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ld  : IN STD_LOGIC; -- load/enable.
    reset : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END register32;

ARCHITECTURE description OF register32 IS

BEGIN
    process(clk, reset)
    begin
        if reset = '1' then
            q <= x"00000000";
        elsif rising_edge(clk) then
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
END description;