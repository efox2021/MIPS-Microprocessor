library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mux32BitArray.all;

entity registerFile is
	port(clk              : in std_logic;
	     readOne, readTwo : in std_logic_vector(4 downto 0);
	     writeAddress     : in std_logic_vector(4 downto 0);
	     writeData        : in std_logic_vector(31 downto 0);
	     reset            : in std_logic;
	     we               : in std_logic;
	     readDataOne      : out std_logic_vector(31 downto 0);
	     readDataTwo      : out std_logic_vector(31 downto 0);
		 regTwoData		  : out std_logic_vector(31 downto 0));
end registerFile;

architecture structural of registerFile is

component register32 is 
port(
    d   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ld  : IN STD_LOGIC; -- load/enable.
    reset : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
end component;


component decoder32to5 is

port(input : in std_logic_vector(4 downto 0);
     output : out std_logic_vector(31 downto 0));

end component;


component mux32to1 is

port(i_In     : in muxArray;
     i_Select : in std_logic_vector(4 downto 0);
     o_Out    : out std_logic_vector(31 downto 0));

end component;

signal s_enable : std_logic_vector(31 downto 0);
signal s_enableAndWrite : std_logic_vector(31 downto 0);
signal s_data   : muxArray;

begin

decoder : decoder32to5
port map(input  => writeAddress,
         output => s_enable);

s_data(0) <= x"00000000";

--s_enableAndWrite <= s_enable(0) & (s_enable(1) and we) & (s_enable(2) and we) & (s_enable(3) and we) & (s_enable(4) and we) & (s_data(5) && we) & (s_enable(6) and we) & (s_enable(7) and we) & (s_enable(8) and we) & (s_enable(9) and we) & (s_enable(10) and we) & (s_enable(11) and we) & (s_enable(12) and we) & (s_enable(13) and we) & (s_enable(14) and we) & (s_enable(15) and we) & (s_enable(16) and we) & (s_enable(17) and we) & (s_enable(18) and we) & (s_enable(19) and we) & (s_enable(20) and we) & (s_enable(21) and we) & (s_enable(22) and we) & (s_enable(23) and we) & (s_enable(24) and we) & (s_enable(25) and we) & (s_enable(26) and we) & (s_enable(27) and we) & (s_enable(28) and we) & (s_enable(29) and we) & (s_enable(30) and we) & (s_enable(31) and we);


registers : for i in 1 to 31 generate
begin
register_i : register32
port map(d => writeData,
         ld  => s_enable(i) and we,
		 reset => reset, 
         clk => clk,
		 q   => s_data(i));
end generate;

mux1 : mux32to1
port map(i_In => s_data,
	 i_Select => readOne,
	 o_Out => readDataOne);

mux2 : mux32to1
port map(i_In => s_data,
	 i_Select => readTwo,
	 o_Out => readDataTwo);

regTwoData <= s_data(2);

end structural;