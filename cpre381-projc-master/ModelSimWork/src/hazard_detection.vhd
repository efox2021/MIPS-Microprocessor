library IEEE;
use IEEE.std_logic_1164.all;

entity hazard_detection is
	port(
		IDEX_RegRt, IFID_RegRs, IFID_RegRt : in std_logic_vector(4 downto 0);
		Jump, Branch, IDEX_MemRE : in std_logic;
		Stall, FlushIFID, FlushIDEX, WrEn : out std_logic
	);
end hazard_detection;

architecture behavior of hazard_detection is
	begin
	
	process(IDEX_RegRt, IFID_RegRs, IFID_RegRt, Jump, Branch, IDEX_MemRE, Stall, FlushIFID, FlushIDEX)
	begin
		
		Stall <= '0';
		FlushIFID <= '0';
		FlushIDEX <= '0';
		WrEn <= '1';
	
		if( Jump = '1' ) then
			Stall <= '0';
			FlushIFID <= '1';
			FlushIDEX <=  '0';
		end if;
		
		if(Branch = '1') then
			Stall <= '0';
			FlushIFID <= '1';
			FlushIDEX <=  '0';
		end if;
		
		if((IDEX_MemRE = '1' and ((IDEX_RegRt = IFID_RegRs) or (IDEX_RegRt = IFID_RegRt)))) then
			FlushIFID <= '0';
			FlushIDEX <= '1';
			Stall <= '1';
			WrEn <= '0';
		end if;
		
	end process;
end behavior;