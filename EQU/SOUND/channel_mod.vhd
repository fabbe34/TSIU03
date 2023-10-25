
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity channel_mod is

port (clk, rstnout : in std_logic;
		ADC_en : in std_logic;
		men : in std_logic;
		SCCnt : in unsigned(1 downto 0);
		BitCnt : in unsigned(4 downto 0);
		sel : in std_logic;	-- Indicates that SndBus is active (sel=0 bit serial part active)
		DAC_en : in std_logic;
		adcdat : in std_logic;
		dacdat : out std_logic;
		ADC : out signed(15 downto 0);
		DAC : in signed(15 downto 0);
		DAC_EN_OUT: out std_logic
		);
		--mclk,  bclk, adclrc, daclrc : out std_logic);
end entity;

architecture RTL of channel_mod is
	-- Shift registers
	signal RXReg: signed(15 downto 0);
	signal TXReg: signed(15 downto 0);
	signal TX_msb: std_logic := '0';
	signal RX_ADC: signed(15 downto 0);
begin

	--Handles ADC
	rx : process(clk, rstnout) begin
		if rstnout = '0' then
			--Reset signals
			RXReg <= (others => '0');
		elsif rising_edge(clk) then
			if sel = '0' then
				if SCCnt = "01" and men = '1' and BitCnt < "10000" then
					RXReg <= RXReg(14 downto 0) & adcdat;
							DAC_EN_OUT <= '1';
				else
					DAC_EN_OUT <= '0';
				end if;
			--else
				--if ADC_en ='1' then
					--RX_ADC <= RXReg;
					--ADC <= RXReg;
				--end if;
			end if;
		end if;
	end process;
	ADC <= RXReg;
	
	--Handles DAC
	tx : process(clk, rstnout) begin
		if rstnout = '0' then
			--Reset signals
		  TXReg <= (others => '0');
		elsif rising_edge(clk) then
			if sel = '0' then
				if SCCnt = "11" and men = '1' and BitCnt < "10000" then
					--dacdat <= TXReg(15);
					--TX_msb <= TXReg(15);
					TXReg <= TXReg(14 downto 0) & '0';		--Shift TXReg so next MSB is available
				end if;
			else
				if DAC_en = '1' then
			
					TXReg <= DAC;
					--dacdat <= TXReg(15);
					--TX_msb <= TXReg(15);
			
				end if;
			end if;	
		end if;
	end process;
	dacdat <= TXReg(15);
	--ADC <= RX_ADC;
	--dacdat <= TX_msb;
end architecture;