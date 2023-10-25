library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sum_Filter is
	port (y_in_bas, y_in_midlow, y_in_midhigh, y_in_treble : in signed(15 downto 0);
			y_out : out signed(15 downto 0)
			);
end entity;


architecture SF of Sum_Filter is

begin

	y_out <= y_in_bas + y_in_midlow + y_in_midhigh + y_in_treble;
	
end architecture;