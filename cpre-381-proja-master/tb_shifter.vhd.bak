library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shifter is
end tb_shifter;

architecture behavior of tb_shifter is

component shifter
port(i_A : in std_logic_vector(31 downto 0);
     i_ShiftAmount : in std_logic_vector(4 downto 0);
     i_Select : in std_logic_vector(1 downto 0);
     o_F : out std_logic_vector(31 downto 0));
end component;

signal s_A, s_F, s_expected : std_logic_vector(31 downto 0);
signal s_shamt : std_logic_vector(4 downto 0);
signal s_sel : std_logic_vector(1 downto 0);

-- Helper Function that will output strings on a modelSim waveform --
-- Will be beneficial in displaying changes or functions in the wves   --
signal info : string(1 to 20);

function string_fill(msg : string; len : natural) return string is
    variable res_v : string(1 to len);
    begin
        res_v := (others => ' ');  -- Fill with spaces to blank all for a start
	res_v(1 to msg'length) := msg;
    return res_v;
end function;

begin

DUT : shifter
port map(i_A => s_A,
	 i_ShiftAmount => s_shamt,
	 i_Select => s_sel,
	 o_F => s_F);

P_TB : process

begin

info <= string_fill("Shift Left 0", info'length);
s_A <= x"00000001";
s_shamt <= "00000";
s_sel <= "00";
s_expected <= x"00000001";
wait for 200 ns;

info <= string_fill("Shift Left 1", info'length);
s_A <= x"00000001";
s_shamt <= "00001";
s_sel <= "00";
s_expected <= x"00000002";
wait for 200 ns;

info <= string_fill("Shift Left 2", info'length);
s_A <= x"00000001";
s_shamt <= "00010";
s_sel <= "00";
s_expected <= x"00000004";
wait for 200 ns;

info <= string_fill("Shift Left 3", info'length);
s_A <= x"00000001";
s_shamt <= "00011";
s_sel <= "00";
s_expected <= x"00000008";
wait for 200 ns;

info <= string_fill("Shift Left 4", info'length);
s_A <= x"00000001";
s_shamt <= "00100";
s_sel <= "00";
s_expected <= x"00000010";
wait for 200 ns;

info <= string_fill("Shift Left 5", info'length);
s_A <= x"00000001";
s_shamt <= "00101";
s_sel <= "00";
s_expected <= x"00000020";
wait for 200 ns;

info <= string_fill("Shift Left 6", info'length);
s_A <= x"00000001";
s_shamt <= "00110";
s_sel <= "00";
s_expected <= x"00000040";
wait for 200 ns;

info <= string_fill("Shift Left 7", info'length);
s_A <= x"00000001";
s_shamt <= "00111";
s_sel <= "00";
s_expected <= x"00000080";
wait for 200 ns;

info <= string_fill("Shift Left 8", info'length);
s_A <= x"00000001";
s_shamt <= "01000";
s_sel <= "00";
s_expected <= x"00000100";
wait for 200 ns;

info <= string_fill("Shift Left 9", info'length);
s_A <= x"00000001";
s_shamt <= "01001";
s_sel <= "00";
s_expected <= x"00000200";
wait for 200 ns;

info <= string_fill("Shift Left 10", info'length);
s_A <= x"00000001";
s_shamt <= "01010";
s_sel <= "00";
s_expected <= x"00000400";
wait for 200 ns;

info <= string_fill("Shift Left 11", info'length);
s_A <= x"00000001";
s_shamt <= "01011";
s_sel <= "00";
s_expected <= x"00000800";
wait for 200 ns;

info <= string_fill("Shift Left 12", info'length);
s_A <= x"00000001";
s_shamt <= "01100";
s_sel <= "00";
s_expected <= x"00001000";
wait for 200 ns;

info <= string_fill("Shift Left 13", info'length);
s_A <= x"00000001";
s_shamt <= "01101";
s_sel <= "00";
s_expected <= x"00002000";
wait for 200 ns;

info <= string_fill("Shift Left 14", info'length);
s_A <= x"00000001";
s_shamt <= "01110";
s_sel <= "00";
s_expected <= x"00004000";
wait for 200 ns;

info <= string_fill("Shift Left 15", info'length);
s_A <= x"00000001";
s_shamt <= "01111";
s_sel <= "00";
s_expected <= x"00008000";
wait for 200 ns;

info <= string_fill("Shift Left 16", info'length);
s_A <= x"00000001";
s_shamt <= "10000";
s_sel <= "00";
s_expected <= x"00010000";
wait for 200 ns;

info <= string_fill("Shift Left 17", info'length);
s_A <= x"00000001";
s_shamt <= "10001";
s_sel <= "00";
s_expected <= x"00020000";
wait for 200 ns;

info <= string_fill("Shift Left 18", info'length);
s_A <= x"00000001";
s_shamt <= "10010";
s_sel <= "00";
s_expected <= x"00040000";
wait for 200 ns;

info <= string_fill("Shift Left 19", info'length);
s_A <= x"00000001";
s_shamt <= "10011";
s_sel <= "00";
s_expected <= x"00080000";
wait for 200 ns;

info <= string_fill("Shift Left 20", info'length);
s_A <= x"00000001";
s_shamt <= "10100";
s_sel <= "00";
s_expected <= x"00100000";
wait for 200 ns;

info <= string_fill("Shift Left 21", info'length);
s_A <= x"00000001";
s_shamt <= "10101";
s_sel <= "00";
s_expected <= x"00200000";
wait for 200 ns;

info <= string_fill("Shift Left 22", info'length);
s_A <= x"00000001";
s_shamt <= "10110";
s_sel <= "00";
s_expected <= x"00400000";
wait for 200 ns;

info <= string_fill("Shift Left 23", info'length);
s_A <= x"00000001";
s_shamt <= "10111";
s_sel <= "00";
s_expected <= x"00800000";
wait for 200 ns;

info <= string_fill("Shift Left 24", info'length);
s_A <= x"00000001";
s_shamt <= "11000";
s_sel <= "00";
s_expected <= x"01000000";
wait for 200 ns;

info <= string_fill("Shift Left 25", info'length);
s_A <= x"00000001";
s_shamt <= "11001";
s_sel <= "00";
s_expected <= x"02000000";
wait for 200 ns;

info <= string_fill("Shift Left 26", info'length);
s_A <= x"00000001";
s_shamt <= "11010";
s_sel <= "00";
s_expected <= x"04000000";
wait for 200 ns;

info <= string_fill("Shift Left 27", info'length);
s_A <= x"00000001";
s_shamt <= "11011";
s_sel <= "00";
s_expected <= x"08000000";
wait for 200 ns;

info <= string_fill("Shift Left 28", info'length);
s_A <= x"00000001";
s_shamt <= "11100";
s_sel <= "00";
s_expected <= x"10000000";
wait for 200 ns;

info <= string_fill("Shift Left 29", info'length);
s_A <= x"00000001";
s_shamt <= "11101";
s_sel <= "00";
s_expected <= x"20000000";
wait for 200 ns;

info <= string_fill("Shift Left 30", info'length);
s_A <= x"00000001";
s_shamt <= "11110";
s_sel <= "00";
s_expected <= x"40000000";
wait for 200 ns;

info <= string_fill("Shift Left 31", info'length);
s_A <= x"00000001";
s_shamt <= "11111";
s_sel <= "00";
s_expected <= x"80000000";
wait for 200 ns;

--Test shift right with x800000000 => 1000 0000 0000 0000 0000 0000 0000 0000

info <= string_fill("Shift Right 0", info'length);
s_A <= x"80000000";
s_shamt <= "00000";
s_sel <= "00";
s_expected <= x"80000000";
wait for 200 ns;

info <= string_fill("Shift Right 1", info'length);
s_A <= x"80000000";
s_shamt <= "00001";
s_sel <= "01";
s_expected <= x"40000000";
wait for 200 ns;

info <= string_fill("Shift Right 2", info'length);
s_A <= x"80000000";
s_shamt <= "00010";
s_sel <= "01";
s_expected <= x"20000000";
wait for 200 ns;

info <= string_fill("Shift Right 3", info'length);
s_A <= x"80000000";
s_shamt <= "00011";
s_sel <= "01";
s_expected <= x"10000000";
wait for 200 ns;

info <= string_fill("Shift Right 4", info'length);
s_A <= x"80000000";
s_shamt <= "00100";
s_sel <= "01";
s_expected <= x"08000000";
wait for 200 ns;

info <= string_fill("Shift Right 5", info'length);
s_A <= x"80000000";
s_shamt <= "00101";
s_sel <= "01";
s_expected <= x"04000000";
wait for 200 ns;

info <= string_fill("Shift Right 6", info'length);
s_A <= x"80000000";
s_shamt <= "00110";
s_sel <= "01";
s_expected <= x"02000000";
wait for 200 ns;

info <= string_fill("Shift Right 7", info'length);
s_A <= x"80000000";
s_shamt <= "00111";
s_sel <= "01";
s_expected <= x"01000000";
wait for 200 ns;

info <= string_fill("Shift Right 8", info'length);
s_A <= x"80000000";
s_shamt <= "01000";
s_sel <= "01";
s_expected <= x"00800000";
wait for 200 ns;

info <= string_fill("Shift Right 9", info'length);
s_A <= x"80000000";
s_shamt <= "01001";
s_sel <= "01";
s_expected <= x"00400000";
wait for 200 ns;

info <= string_fill("Shift Right 10", info'length);
s_A <= x"80000000";
s_shamt <= "01010";
s_sel <= "01";
s_expected <= x"00200000";
wait for 200 ns;

info <= string_fill("Shift Right 11", info'length);
s_A <= x"80000000";
s_shamt <= "01011";
s_sel <= "01";
s_expected <= x"00100000";
wait for 200 ns;

info <= string_fill("Shift Right 12", info'length);
s_A <= x"80000000";
s_shamt <= "01100";
s_sel <= "01";
s_expected <= x"00080000";
wait for 200 ns;

info <= string_fill("Shift Right 13", info'length);
s_A <= x"80000000";
s_shamt <= "01101";
s_sel <= "01";
s_expected <= x"00040000";
wait for 200 ns;

info <= string_fill("Shift Right 14", info'length);
s_A <= x"80000000";
s_shamt <= "01110";
s_sel <= "01";
s_expected <= x"00020000";
wait for 200 ns;

info <= string_fill("Shift Right 15", info'length);
s_A <= x"80000000";
s_shamt <= "01111";
s_sel <= "01";
s_expected <= x"00010000";
wait for 200 ns;

info <= string_fill("Shift Right 16", info'length);
s_A <= x"80000000";
s_shamt <= "10000";
s_sel <= "01";
s_expected <= x"00008000";
wait for 200 ns;

info <= string_fill("Shift Right 17", info'length);
s_A <= x"80000000";
s_shamt <= "10001";
s_sel <= "01";
s_expected <= x"00004000";
wait for 200 ns;

info <= string_fill("Shift Right 18", info'length);
s_A <= x"80000000";
s_shamt <= "10010";
s_sel <= "01";
s_expected <= x"00002000";
wait for 200 ns;

info <= string_fill("Shift Right 19", info'length);
s_A <= x"80000000";
s_shamt <= "10011";
s_sel <= "01";
s_expected <= x"00001000";
wait for 200 ns;

info <= string_fill("Shift Right 20", info'length);
s_A <= x"80000000";
s_shamt <= "10100";
s_sel <= "01";
s_expected <= x"00000800";
wait for 200 ns;

info <= string_fill("Shift Right 21", info'length);
s_A <= x"80000000";
s_shamt <= "10101";
s_sel <= "01";
s_expected <= x"00000400";
wait for 200 ns;

info <= string_fill("Shift Right 22", info'length);
s_A <= x"80000000";
s_shamt <= "10110";
s_sel <= "01";
s_expected <= x"00000200";
wait for 200 ns;

info <= string_fill("Shift Right 23", info'length);
s_A <= x"80000000";
s_shamt <= "10111";
s_sel <= "01";
s_expected <= x"00000100";
wait for 200 ns;

info <= string_fill("Shift Right 24", info'length);
s_A <= x"80000000";
s_shamt <= "11000";
s_sel <= "01";
s_expected <= x"00000080";
wait for 200 ns;

info <= string_fill("Shift Right 25", info'length);
s_A <= x"80000000";
s_shamt <= "11001";
s_sel <= "01";
s_expected <= x"00000040";
wait for 200 ns;

info <= string_fill("Shift Right 26", info'length);
s_A <= x"80000000";
s_shamt <= "11010";
s_sel <= "01";
s_expected <= x"00000020";
wait for 200 ns;

info <= string_fill("Shift Right 27", info'length);
s_A <= x"80000000";
s_shamt <= "11011";
s_sel <= "01";
s_expected <= x"00000010";
wait for 200 ns;

info <= string_fill("Shift Right 28", info'length);
s_A <= x"80000000";
s_shamt <= "11100";
s_sel <= "01";
s_expected <= x"00000008";
wait for 200 ns;

info <= string_fill("Shift Right 29", info'length);
s_A <= x"80000000";
s_shamt <= "11101";
s_sel <= "01";
s_expected <= x"00000004";
wait for 200 ns;

info <= string_fill("Shift Right 30", info'length);
s_A <= x"80000000";
s_shamt <= "11110";
s_sel <= "01";
s_expected <= x"00000002";
wait for 200 ns;

info <= string_fill("Shift Right 31", info'length);
s_A <= x"80000000";
s_shamt <= "11111";
s_sel <= "01";
s_expected <= x"00000001";
wait for 200 ns;

info <= string_fill("Shift Right Arith 0", info'length);
s_A <= x"80000000";
s_shamt <= "00000";
s_sel <= "10";
s_expected <= x"80000000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 1", info'length);
s_A <= x"80000000";
s_shamt <= "00001";
s_sel <= "10";
s_expected <= x"C0000000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 2", info'length);
s_A <= x"80000000";
s_shamt <= "00010";
s_sel <= "10";
s_expected <= x"E0000000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 3", info'length);
s_A <= x"80000000";
s_shamt <= "00011";
s_sel <= "10";
s_expected <= x"F0000000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 4", info'length);
s_A <= x"80000000";
s_shamt <= "00100";
s_sel <= "10";
s_expected <= x"F8000000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 5", info'length);
s_A <= x"80000000";
s_shamt <= "00101";
s_sel <= "10";
s_expected <= x"FC000000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 6", info'length);
s_A <= x"80000000";
s_shamt <= "00110";
s_sel <= "10";
s_expected <= x"FE000000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 7", info'length);
s_A <= x"80000000";
s_shamt <= "00111";
s_sel <= "10";
s_expected <= x"FF000000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 8", info'length);
s_A <= x"80000000";
s_shamt <= "01000";
s_sel <= "10";
s_expected <= x"FF800000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 9", info'length);
s_A <= x"80000000";
s_shamt <= "01001";
s_sel <= "10";
s_expected <= x"FFC00000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 10", info'length);
s_A <= x"80000000";
s_shamt <= "01010";
s_sel <= "10";
s_expected <= x"FFE00000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 11", info'length);
s_A <= x"80000000";
s_shamt <= "01011";
s_sel <= "10";
s_expected <= x"FFF00000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 12", info'length);
s_A <= x"80000000";
s_shamt <= "01100";
s_sel <= "10";
s_expected <= x"FFF80000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 13", info'length);
s_A <= x"80000000";
s_shamt <= "01101";
s_sel <= "10";
s_expected <= x"FFFC0000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 14", info'length);
s_A <= x"80000000";
s_shamt <= "01110";
s_sel <= "10";
s_expected <= x"FFFE0000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 15", info'length);
s_A <= x"80000000";
s_shamt <= "01111";
s_sel <= "10";
s_expected <= x"FFFF0000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 16", info'length);
s_A <= x"80000000";
s_shamt <= "10000";
s_sel <= "10";
s_expected <= x"FFFF8000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 17", info'length);
s_A <= x"80000000";
s_shamt <= "10001";
s_sel <= "10";
s_expected <= x"FFFFC000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 18", info'length);
s_A <= x"80000000";
s_shamt <= "10010";
s_sel <= "10";
s_expected <= x"FFFFE000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 19", info'length);
s_A <= x"80000000";
s_shamt <= "10011";
s_sel <= "10";
s_expected <= x"FFFFF000";
wait for 200 ns;

info <= string_fill("Shift Right Arith 20", info'length);
s_A <= x"80000000";
s_shamt <= "10100";
s_sel <= "10";
s_expected <= x"FFFFF800";
wait for 200 ns;

info <= string_fill("Shift Right Arith 21", info'length);
s_A <= x"80000000";
s_shamt <= "10101";
s_sel <= "10";
s_expected <= x"FFFFFC00";
wait for 200 ns;

info <= string_fill("Shift Right Arith 22", info'length);
s_A <= x"80000000";
s_shamt <= "10110";
s_sel <= "10";
s_expected <= x"FFFFFE00";
wait for 200 ns;

info <= string_fill("Shift Right Arith 23", info'length);
s_A <= x"80000000";
s_shamt <= "10111";
s_sel <= "10";
s_expected <= x"FFFFFF00";
wait for 200 ns;

info <= string_fill("Shift Right Arith 24", info'length);
s_A <= x"80000000";
s_shamt <= "11000";
s_sel <= "10";
s_expected <= x"FFFFFF80";
wait for 200 ns;

info <= string_fill("Shift Right Arith 25", info'length);
s_A <= x"80000000";
s_shamt <= "11001";
s_sel <= "10";
s_expected <= x"FFFFFFC0";
wait for 200 ns;

info <= string_fill("Shift Right Arith 26", info'length);
s_A <= x"80000000";
s_shamt <= "11010";
s_sel <= "10";
s_expected <= x"FFFFFFE0";
wait for 200 ns;

info <= string_fill("Shift Right Arith 27", info'length);
s_A <= x"80000000";
s_shamt <= "11011";
s_sel <= "10";
s_expected <= x"FFFFFFF0";
wait for 200 ns;

info <= string_fill("Shift Right Arith 28", info'length);
s_A <= x"80000000";
s_shamt <= "11100";
s_sel <= "10";
s_expected <= x"FFFFFFF8";
wait for 200 ns;

info <= string_fill("Shift Right Arith 29", info'length);
s_A <= x"80000000";
s_shamt <= "11101";
s_sel <= "10";
s_expected <= x"FFFFFFFC";
wait for 200 ns;

info <= string_fill("Shift Right Arith 30", info'length);
s_A <= x"80000000";
s_shamt <= "11110";
s_sel <= "10";
s_expected <= x"FFFFFFFE";
wait for 200 ns;

info <= string_fill("Shift Right Arith 31", info'length);
s_A <= x"80000000";
s_shamt <= "11111";
s_sel <= "10";
s_expected <= x"FFFFFFFF";
wait for 200 ns;

end process;
end behavior;