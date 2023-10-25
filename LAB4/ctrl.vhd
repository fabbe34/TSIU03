library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity Ctrl is
	port( clk, rstn :in std_logic;
	mclk, bclk, adclrc, daclrc, lrsel,men,ADC_en: out std_logic;	
		SCCnt : out unsigned (1 downto 0);
		BitCnt : out unsigned (4 downto 0));
end entity;

architecture rtl of Ctrl is 
	signal cntr : unsigned(9 downto 0);
	signal lrsel_old : std_logic;
begin
	process(clk,rstn)
		begin
			
			if rstn ='0' then
				cntr <= (others =>'0');
			elsif rising_edge(clk) then
				cntr	<= cntr +1;	
				lrsel_old <= cntr(9);
			end if;
				
	end process;
	bclk 		<= cntr(3);
	mclk 		<= not cntr(1);
	men 		<= cntr(0) and cntr(1);
	SCCnt 	<= cntr(3 downto 2);
	BitCnt 	<= cntr(8 downto 4);
	adclrc	<= NOT cntr(9);
	daclrc	<= NOT cntr(9);
	lrsel		<= cntr(9);
	ADC_en 	<= cntr(9) XOR lrsel_old;
	
end architecture;
