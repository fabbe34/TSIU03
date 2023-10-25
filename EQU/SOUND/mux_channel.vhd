library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_channel is
	port(
		dacdat_L, dacdat_R, daclrc: in std_logic;
		dacdat_out: out std_logic);
end entity;

architecture rtl of mux_channel is
begin
	dacdat_out <= dacdat_L when daclrc = '1' else
	dacdat_R;
end architecture;