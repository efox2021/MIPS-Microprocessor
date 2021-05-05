library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity extender is
  generic(N : integer := 16;
          K : integer := 32);
  port(input : in std_logic_vector(N-1 downto 0);
       sel  : in std_logic;
       output: out std_logic_vector(K-1 downto 0));
end entity extender;

architecture dataflow of extender is
    begin
      Low : for i in 0 to (N-1) generate
        output(i) <= input(i);
    end generate;
      High : for i in N to K-1 generate
        output(i) <= sel and input(N-1);
    end generate;
end dataflow;
