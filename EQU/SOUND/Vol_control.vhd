library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Vol_control is
	port (
		y_in : in signed(15 downto 0);
		vol : in unsigned(3 downto 0);
		y_out : out signed(15 downto 0);
		clk : in std_logic
	);
end entity;


architecture vol of Vol_control is
	type vol_scale_type is array(0 to 10) of signed(15 downto 0);
	
	-- Signed fixed point <1,15>
	constant vol_scale : vol_scale_type := (
		0 => x"0000",
		1 => x"097b",
		2 => x"0aab",
		3 => x"0c31",
		4 => x"0e39",
		5 => x"1111",
		6 => x"1555",
		7 => x"1c72",
		8 => x"2aab",
		9 => x"5555",
		10 => x"7fff"
	);
	
	-- Multiplication output: <1,31>
	signal y_out_long : signed(31 downto 0);
	
begin
	
	--y_out <= (others=>'0') when vol = 0 else y_in when vol = 10 else y_in /((shift_right(to_signed(1,2),1)+ to_signed(1,2))* to_signed(to_integer(vol)-10,4));
	y_out_long <= y_in * vol_scale(to_integer(vol));
	y_out <= y_out_long(30 downto 15);
		
	
end architecture;