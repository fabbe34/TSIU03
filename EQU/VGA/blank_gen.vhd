library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blank_gen is
  Port ( vcnt : in unsigned(9 downto 0);
         hcnt : in unsigned(9 downto 0);
         blank : out std_logic);
end entity;

architecture rtl of blank_gen is
begin

	blank <= '1' when (hcnt < 640) and (vcnt<480) else
				    '0';
	

end architecture;
