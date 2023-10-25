library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity channel_mod is
port	(clk, rstn : in std_logic;
		DAC : in signed (15 downto 0);
		men,lrsel,adcdat ,DAC_en: in std_logic;
		SCCnt : unsigned (1 downto 0);
		BitCnt : unsigned (4 downto 0);
		dacdat : out std_logic;
		ADC : out signed (15 downto 0);
		enable_dac: out std_logic);
end entity;

architecture arch of channel_mod is 
	signal RXReg, TXReg : signed (15 downto 0);
begin
	
	rx: process(clk,rstn) is begin
		if(rstn ='0') then
			RXReg <= (others => '0');
		elsif rising_edge(clk) then
			if (lrsel = '0' and SCCnt = 1 and men = '1' and BitCnt < 16) then
				RXReg <= RXReg(14 downto 0) & adcdat;

			end if;
				
		end if;
	end process;
	ADC <= RXReg;
	
	tx: process(clk,rstn) is begin
		if(rstn ='0') then
			TXReg <= (others => '0');
		elsif rising_edge(clk) then
			if (lrsel = '0' and SCCnt = 3 and men ='1'  and BitCnt < 16) then 
				TXReg <= TXReg(14 downto 0) & '0';
			elsif lrsel= '1' and DAC_en ='1' then
				TXReg <= DAC;
				enable_dac <= '1';
			else
				enable_dac <= '0';
			end if;
			
		end if;
	end process;
	
	dacdat <= TXReg(15);
	
	
end architecture;