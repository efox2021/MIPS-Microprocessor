library IEEE;
use IEEE.std_logic_1164.all;

entity ALU32Bit is
generic(N : integer := 32);
port(opCode : in std_logic_vector(2 downto 0);
     iA : in std_logic_vector(N-1 downto 0);
     iB : in std_logic_vector(N-1 downto 0);
     zero : out std_logic;
     overFlow : out std_logic;
     o_F : out std_logic_vector(N-1 downto 0));
end ALU32Bit;

architecture structural of ALU32Bit is

component ALUBit0to30
port(opCode : std_logic_vector(2 downto 0);
     i_A : std_logic;
     i_B : std_logic;
     i_Cin : std_logic;
     less : in std_logic;
     o_Cout : out std_logic;
     o_F : out std_logic);
end component;

component ALUBit31
port(opCode : std_logic_vector(2 downto 0);
     i_A : std_logic;
     i_B : std_logic;
     i_Cin : std_logic;
     less : in std_logic;
     o_set : out std_logic;
     o_Cout : out std_logic;
     o_F : out std_logic);
end component;

signal s_F : std_logic_vector(N-1 downto 0);
signal s_zero, s_set : std_logic;
signal s_Cin : std_logic_vector(N downto 0);

begin


process(opCode, iA, iB)
begin
case(opCode) is
when "011" | "111" =>
s_Cin(0) <= '1';
when others =>
s_Cin(0) <= '0';
end case;
end process;


Bit0 : ALUBit0to30
port map(opCode => opCode,
	 i_A => iA(0),
	 i_B => iB(0),
	 i_Cin => s_Cin(0),
	 less => s_set,
	 o_Cout => s_Cin(1),
	 o_F => s_F(0));

Gen: for i in 1 to N-2 generate
Bit1to30 : ALUBit0to30
port map(opCode => opCode,
	 i_A => iA(i),
	 i_B => iB(i),
	 i_Cin => s_Cin(i),
	 less => '0',
	 o_Cout => s_Cin(i+1),
	 o_F => s_F(i));
end generate Gen;

Bit31 : ALUBit31
port map(opCode => opCode,
	 i_A => iA(31),
	 i_B => iB(31),
	 i_Cin => s_Cin(31),
	 less => '0',
	 o_set => s_set,
	 o_Cout => s_Cin(32),
	 o_F => s_F(31));

process(s_F)
begin

	case s_F is
		
		when x"00000000" =>
			zero <= '1';
		when others =>
			zero <= '0';
	end case;
end process;

overflow <= s_Cin(30) xor s_Cin(31);
o_F <= s_F;

end structural;