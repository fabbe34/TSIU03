library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Left_Right_Balance is
	port (Left_Sound, Right_Sound : in signed(15 downto 0);
			Balance : in unsigned(3 downto 0);
			Left_Out, Right_Out : out signed(15 downto 0)
			);
end entity;


architecture LRB of Left_Right_Balance is


begin
	
	
	Left_Out <= (others=>'0') when Balance = 0 else Left_Sound when Balance >= 5 else Left_Sound / (1+to_signed(3,4)  *to_signed(5-to_integer(Balance),4));
	Right_Out <= (others=>'0') when Balance = 10 else Right_Sound when Balance <= 5 else Right_Sound / (1+to_signed(3,4) *to_signed(to_integer(Balance)-5,4));

	
end architecture;