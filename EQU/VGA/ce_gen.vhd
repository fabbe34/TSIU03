library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ce_gen is
  Port ( clk : in std_logic;
         rstn : in std_logic;
         ce : out std_logic); -- "clock enable" in 25 MHz, to match the video clock.
end entity;

architecture rtl of ce_gen is
	signal counter: std_logic := '1';
begin
	p1: process(clk, rstn) begin
		if rstn = '0' then
			counter <= '1';
		elsif rising_edge(clk) then
			counter <= not counter;
		end if;
		
	end process;
	ce <= counter;
	
end architecture;
