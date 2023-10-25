library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity my_mux is
port (daclrc,dacdatr,dacdatl : in std_logic;
		dacdat : out std_logic);

end entity;

architecture dac of my_mux is
begin
	dacdat <= dacdatl when daclrc = '1' else dacdatr;
end architecture;

