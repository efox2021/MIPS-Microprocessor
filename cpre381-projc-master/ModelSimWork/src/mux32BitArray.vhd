--Used in mux32to1

library IEEE;
use IEEE.std_logic_1164.all;

package mux32BitArray is
type muxArray is array(0 to 31) of std_logic_vector(31 downto 0);
end package mux32BitArray;