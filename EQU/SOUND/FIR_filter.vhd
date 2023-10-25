library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use work.common.all;
entity FIR_Filter is -- One for left and one for right channel
   
    Port ( 
		
		A_gain: in integer range 0 to 1;
		B_gain: in integer range 0 to 1;
		C_gain: in integer range 0 to 1;
		D_gain: in integer range 0 to 1;
		LR_bal: in integer range 0 to 1;
		
		
		
		Band_A: in coefficients;
		Band_B: in coefficients;
		Band_C: in coefficients;
		Band_D: in coefficients;
		
		clk: in std_logic;
		rst: in std_logic;
		clr: in std_logic
		
	
	
		);
end FIR_Filter;
 
architecture Structure of FIR_Filter is


	

	
	
	
	
	signal coeff_en: std_logic;
	signal Band_1: coefficients;
	signal Band_2: coefficients;
	signal Band_3: coefficients;
	signal Band_4: coefficients;
	
	
	

begin



		
	
	process(clk, rst, clr)
		begin

	end process;	

	end Structure;

 
