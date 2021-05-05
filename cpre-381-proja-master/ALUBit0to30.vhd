library IEEE;
use IEEE.std_logic_1164.all;

entity ALUBit0to30 is
port(opCode : std_logic_vector(2 downto 0);
     i_A : std_logic;
     i_B : std_logic;
     i_Cin : std_logic;
     less : in std_logic;
     o_Cout : out std_logic;
     o_F : out std_logic);

end ALUBit0to30;

architecture dataflow of ALUBit0to30 is

signal s_Cout : std_logic;

begin

P1: process(opCode, i_A, i_B, i_Cin, less)
begin
case(opCode) is
when "000" =>
o_F <= i_A and i_B;

when "001" =>
o_F <= i_A or i_B;

when "010" =>
o_F <= (i_A xor i_B xor i_Cin);
o_Cout <= (i_A and i_B) or (i_B and i_Cin) or (i_A and i_Cin);

when "011" =>
o_F <= (i_A xor (not i_B) xor i_Cin);
o_Cout <= (i_A and (not i_B)) or ((not i_B) and i_Cin) or (i_A and i_Cin);

when "100" =>
o_F <= i_A xor i_B;

when "101" =>
o_F <= i_A nand i_B;

when "110" =>
o_F <= i_A nor i_B;

when "111" =>
o_F <= less;
o_Cout <= (i_A and (not i_B)) or ((not i_B) and i_Cin) or (i_A and i_Cin);

when others =>
o_F <= '0';
o_Cout <= '0';

--o_Cout <= s_Cout;

end case;
end process P1;
end dataflow;