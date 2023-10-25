library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Filter_Mux is
	port (Left_Filter, Left_Sound : in signed(15 downto 0);
			Right_Filter, Right_Sound : in signed(15 downto 0);
			Filter_Select : in unsigned(1 downto 0);
			Left_Out, Right_Out : out signed(15 downto 0)
			);
end entity;


architecture FM of Filter_Mux is

begin

	Left_Out <= Left_Sound when Filter_Select(0) ='0'	else Left_Filter when Filter_Select(0) ='1';
	Right_Out <= Right_Sound when Filter_Select(1) ='0'	else Right_Filter when Filter_Select(1) ='1';

	
end architecture;