
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl is
	port (clk, rstnout : in std_logic;
			mclk, bclk, adclrc, daclrc,lrsel, ADC_en, men : out std_logic;
			bitCnt : out unsigned(4 downto 0);
			sCCnt : out unsigned(1 downto 0));
			
end entity;
-- vcom ../ctrl.vhd; restart -force; force -freeze clk 1 0ns, 0 50ns -r 100ns
architecture RTL of ctrl is
	signal cntr: unsigned(9 downto 0) := "0000000000";
	--signal cntr4: unsigned(9 downto 0) := "0000000000";
	--signal cntr_temp: unsigned(9 downto 0) := "0000000000";
	signal men_temp: std_logic;
	signal lrc_temp: std_logic;
	signal adc_temp: std_logic:='0';
	signal adclrc_temp: std_logic :='0';
	signal daclrc_temp: std_logic :='0';
	signal sCCnt_temp: unsigned(1 downto 0);
	signal bitcnt_temp: unsigned(4 downto 0);
    
begin
	
	process(clk, rstnout) begin
		if rstnout = '0' then
			cntr <= (others => '0');
			men_temp <= '0';
			lrc_temp <= '0';
			adc_temp <= '0';
			daclrc_temp <= '0';
			sCCnt_temp <= (others => '0');
			bitcnt_temp <= (others => '0');
		elsif rising_edge(clk) then
			cntr <= cntr + 1;
		end if;
	end process;
	mclk <= not cntr(1);
	bclk <= cntr(3);

	men <= cntr(1) and cntr(0);
	
	SCCnt <= cntr(3 downto 2);
	BitCnt <= cntr(8 downto 4);
	
	adclrc <= '1' when cntr >= 512 else
		'0';
	daclrc <= '1' when cntr >= 512 else
		'0';
	lrsel <= '0' when cntr >= 512 else
		'1';

	ADC_en <= '1' when cntr = 0 else
				'1' when cntr = 512 else
			'0';
		
		
end architecture;