library IEEE;
use IEEE.std_logic_1164.all;

-- Hazard Detection unit, currently having issues where signals only stay enabled for about 1 ns -- 

entity hazard_detect is
	port(
		IFID_Function, IFID_Op	: in std_logic_vector(5 downto 0);
		IDEX_RegRt, IDEX_Rd, EXMEM_RD, IFID_RegRs, IFID_RegRt : in std_logic_vector(4 downto 0);
		equiv : in std_logic;
		IDEX_WrEn, EXMEM_WrEn : std_logic;
		IDEX_MemRE : in std_logic;
		Stall, IFID_Flush, IDEX_Flush, PC_WrEn : out std_logic
	);
end hazard_detect;

architecture behavior of hazard_detect is
	signal r_Type : std_logic_vector(5 downto 0);
	
	begin
	r_Type <= "000000";
	
	process(IDEX_RegRt, IDEX_Rd, EXMEM_RD, IFID_RegRs, IFID_RegRt, equiv, IDEX_WrEn, EXMEM_WrEn, IDEX_MemRE)
	begin
	-- handle load-use hazard
	if((IDEX_MemRE = '1') and ((IDEX_RegRt = IFID_RegRs) or (IDEX_RegRt = IFID_RegRt))) then
		PC_WrEn <= '1';
		IDEX_Flush <= '1';
		IFID_Flush <= '0';
		Stall <= '1';
	
	-- handle (BEQ or BNE or JR) and ((EX_DestReg = (ID_SourceReg or ID_tReg) and ExRegWr = 1) or some other stuff as well too much commenting <3 
	elsif(((IFID_Op = "000100") or (IFID_Op = "000101") or ((IFID_Op = r_Type) and (IFID_Function = "001000")))
		and ((((IDEX_Rd = IFID_RegRs) or (IDEX_Rd = IFID_RegRt)) and (IDEX_WrEn = '1')) or (((EXMEM_RD = IFID_RegRs) or (EXMEM_RD = IFID_RegRt)) and (EXMEM_WrEn = '1')))) then
		PC_WrEn <= '0';
		IDEX_Flush <= '0';
		IFID_Flush <= '0';
		Stall 	   <= '1';
	
	-- handle jump or a jump register instruction or a BEQ/BNE instruction with no special forwarding needed
	elsif(((IFID_Op = "000010") or ((IFID_Op = r_Type) and (IFID_Function = "001000")) or ((IFID_Op = "000100") and (equiv = '1')) or ((IFID_Op = "000101") and (equiv = '0')))) then
		PC_WrEn <= '1';
		IDEX_Flush <= '0';
		IFID_Flush <= '1';
		Stall <= '0';
		
	-- this be that yung jump and link instruction that my granpappy tells me about
	elsif(IFID_Op = "000011") then
		PC_WrEn <= '1';
		IDEX_Flush <= '0';
		IFID_Flush <= '1';
		Stall <= '0';
		
	-- Otherwise behave as normal	
	else
		PC_WrEn <= '1';
		IDEX_Flush <= '0';
		IFID_Flush <= '0';
		Stall <= '0';
	end if;
end process;
end behavior;
	