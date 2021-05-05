library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shifter is
port(i_A : in std_logic_vector(31 downto 0);
     i_ShiftAmount : in std_logic_vector(4 downto 0);
     i_Select : in std_logic_vector(1 downto 0);
     o_F : out std_logic_vector(31 downto 0));
end entity shifter;

architecture behavior of shifter is

--signal s_shifted : std_logic_vector(31 downto 0);

begin

process(i_A, i_ShiftAmount, i_Select)

variable s_shifted : std_logic_vector(31 downto 0);

begin
s_shifted := i_A;

if i_ShiftAmount(0) = '1' and i_Select = "00" then				--shift left 1 bit if shiftAmount is 1 and select is 00
s_shifted := s_shifted(30 downto 0) & '0';
elsif i_ShiftAmount(0) = '1' and i_Select = "01" then				--shift right 1 bit if shiftAmount is 1 and select is 01
s_shifted := '0' & i_A(31 downto 1);
elsif i_ShiftAmount(0) = '1' and i_Select = "10" and s_shifted(31) = '0' then	--shift right 1 bit and preserve MSB if shiftAmount is 1 and select is 10
s_shifted := '0' & i_A(31 downto 1);
elsif i_ShiftAmount(0) = '1' and i_Select = "10" and s_shifted(31) = '1' then	--shift right 1 bit and preserve MSB if shiftAmount is 1 and select is 10
s_shifted := '1' & i_A(31 downto 1);
end if;

if i_ShiftAmount(1) = '1' and i_Select = "00" then				--shift left 2 bits if shiftAmount is 2 and select is 00
s_shifted := s_shifted(29 downto 0) & "00";
elsif i_ShiftAmount(1) = '1' and i_Select = "01" then				--shift right 2 bits if shiftAmount is 2 and select is 01
s_shifted := "00" & s_shifted(31 downto 2);
elsif i_ShiftAmount(1) = '1' and i_Select = "10" and s_shifted(31) = '0' then	--shift right 2 bits and preserve MSB if shiftAmount is 2 and select is 10
s_shifted := "00" & s_shifted(31 downto 2);
elsif i_ShiftAmount(1) = '1' and i_Select = "10" and s_shifted(31) = '1' then	--shift right 2 bit and preserve MSB if shiftAmount is 2 and select is 10
s_shifted := "11" & i_A(31 downto 2);
end if;

if i_ShiftAmount(2) = '1' and i_Select = "00" then				--shift left 4 bits if shiftAmount is 4 and select is 00
s_shifted := s_shifted(27 downto 0) & x"0";
elsif i_ShiftAmount(2) = '1' and i_Select = "01" then				--shift right 4 bits if shiftAmount is 4 and select is 01
s_shifted := x"0" & s_shifted(31 downto 4);
elsif i_ShiftAmount(2) = '1' and i_Select = "10" and s_shifted(31) = '0' then	--shift right 4 bits and preserve MSB if shiftAmount is 4 and select is 10
s_shifted := x"0" & s_shifted(31 downto 4);
elsif i_ShiftAmount(2) = '1' and i_Select = "10" and s_shifted(31) = '1' then	--shift right 4 bits and preserve MSB if shiftAmount is 4 and select is 10
s_shifted := x"F" & i_A(31 downto 4);
end if;

if i_ShiftAmount(3) = '1' and i_Select = "00" then				--shift left 8 bits if shiftAmount is 8 and select is 00
s_shifted := s_shifted(23 downto 0) & x"00";
elsif i_ShiftAmount(3) = '1' and i_Select = "01" then				--shift right 8 bits if shiftAmount is 4 and select is 01
s_shifted := x"00" & s_shifted(31 downto 8);
elsif i_ShiftAmount(3) = '1' and i_Select = "10" and s_shifted(31) = '0' then	--shift right 8 bits and preserve MSB if shiftAmount is 8 and select is 10
s_shifted := x"00" & s_shifted(31 downto 8);
elsif i_ShiftAmount(3) = '1' and i_Select = "10" and s_shifted(31) = '1' then	--shift right 8 bits and preserve MSB if shiftAmount is 8 and select is 10
s_shifted := x"FF" & s_shifted(31 downto 8);
end if;

if i_ShiftAmount(4) = '1' and i_Select = "00" then				--shift left 16 bits if shiftAmount is 16 and select is 00
s_shifted := s_shifted(15 downto 0) & x"0000";
elsif i_ShiftAmount(4) = '1' and i_Select = "01" then				--shift right 16 bits if shiftAmount is 16 and select is 01
s_shifted := x"0000" & s_shifted(31 downto 16);
elsif i_ShiftAmount(4) = '1' and i_Select = "10" and s_shifted(31) = '0' then	--shift right 16 bits and preserve MSB if shiftAmount is 16 and select is 10
s_shifted := x"0000" & s_shifted(31 downto 16);
elsif i_ShiftAmount(4) = '1' and i_Select = "10" and s_shifted(31) = '1' then	--shift right 16 bits and preserve MSB if shiftAmount is 16 and select is 10
s_shifted := x"FFFF" & s_shifted(31 downto 16);
end if;

o_F <= s_shifted;

end process;

end architecture behavior;