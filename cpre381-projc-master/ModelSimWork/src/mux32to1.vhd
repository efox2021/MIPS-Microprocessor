library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mux32BitArray.all;

entity mux32to1 is
    port(i_In     : in muxArray;
         i_Select : in std_logic_vector(4 downto 0);
         o_Out    : out std_logic_vector(31 downto 0));
end mux32to1;

architecture dataflow of mux32to1 is

begin

    o_Out <= i_In(to_integer(unsigned(i_Select)));

end dataFlow;
