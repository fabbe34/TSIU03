library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity SUM2 is -- number of address bits; N = 2^A
port (
	clk : in std_logic;
	SEND: in std_logic; -- active high write enable
	DIN: in signed (31 downto 0); -- write data

	DOUT: out signed (15 downto 0);-- read data
	D_BACK :out signed (31 downto 0));
	end entity SUM2;


architecture rtl of SUM2 is
	
begin 

	D_BACK <= DIN when SEND ='0' else (others=>'0');
	dout <= DIN(30 downto 15
	) when SEND ='1' else (others=>'0');
end architecture;