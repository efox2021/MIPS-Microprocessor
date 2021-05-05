library IEEE;
use IEEE.std_logic_1164.all;

entity hazard_detection is
	port(
		IDEX_RegRt, IFID_RegRs, IFID_RegRt : in std_logic_vector(4 downto 0);
		Jump, Branch, IDEX_MemRE : in std_logic;
		Stall, FlushIFID, FlushIDEX, WrEn : out std_logic
	);
end hazard_detection;