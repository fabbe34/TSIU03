library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controller is

	Port( rstn,clk,scancode_en : in std_logic;
			Button : in unsigned(9 downto 0);
			Volume, Balance, Treble, Bass, Mid_Low, Mid_High : out unsigned(3 downto 0);
			Fil_Sel : out unsigned(1 downto 0)); --Fil_Sel_Two
			
end entity;

architecture rtl of Controller is

	signal Button_temp : unsigned(9 downto 0);
	
begin

	p1 : process(clk,rstn,scancode_en)
	
	variable Vol_temp, Bal_temp, Tre_temp, Bas_temp, vMid_Low, vMid_High : integer := 0;
	variable vFil_Sel_One, vFil_Sel_Two : integer := 0;
	
	begin

	if rstn = '0' then

		Vol_temp := 0; 
		Bal_temp := 0; 
		Tre_temp := 0; 
		Bas_temp := 0; 
		vMid_Low := 0; 
		vMid_High := 0;
		vFil_Sel_One := 0; 
		vFil_Sel_Two := 0;
		Bal_temp := 5;
		Button_temp <= "0000000000";
		
	elsif rising_edge(clk) then
		
		Button_temp <= Button;
		
		if scancode_en = '1' then

			if Button_temp(7 downto 0) = "00010110" then					--Button 1-- Bass up
			
				if Bas_temp >= 10 then
					Bas_temp := 10;
				elsif Bas_temp < 10 then
					Bas_temp := Bas_temp + 1;
				else
					Bas_temp := Bas_temp;
				end if;
				
			elsif Button_temp(7 downto 0) = "00011110" then				--Button 2-- Bass down		
			
				if Bas_temp <= 0 then
					Bas_temp := 0;
				elsif Bas_temp > 0 then
					Bas_temp := Bas_temp - 1;
				else
					Bas_temp := Bas_temp;
				end if;
				
			elsif Button_temp(7 downto 0) = "00100110" then				--Button 3-- vMid_Low left

				if vMid_Low >= 10 then
					vMid_Low := 10;
				elsif vMid_Low < 10 then
					vMid_Low := vMid_Low + 1;
				else
					vMid_Low := vMid_Low;
				end if;
				
			elsif Button_temp(7 downto 0) = "00100101" then				--Button 4-- vMid_Low Right

				if vMid_Low <= 0 then
					vMid_Low := 0;
				elsif vMid_Low > 0 then
					vMid_Low := vMid_Low - 1;
				else
					vMid_Low := vMid_Low;
				end if;

				
			elsif Button_temp(7 downto 0) = "00101110" then				--Button 5-- vMid_High up
				
				if vMid_High >= 10 then
					vMid_High := 10;
				elsif vMid_High < 10 then
					vMid_High := vMid_High + 1;
				else
					vMid_High := vMid_High;
				end if;

			elsif Button_temp(7 downto 0) = "00110110" then				--Button 6-- vMid_High down

				if vMid_High <= 0 then
					vMid_High := 0;
				elsif vMid_High > 0 then
					vMid_High := vMid_High - 1;
				else
					vMid_High := vMid_High;
				end if;

			elsif Button_temp(7 downto 0) = "00111101" then				--Button 7-- Treble up

				if Tre_temp >= 10 then
					Tre_temp := 10;
				elsif Tre_temp < 10 then
					Tre_temp := Tre_temp + 1;
				else
					Tre_temp := Tre_temp;
				end if;

			elsif Button_temp(7 downto 0) = "00111110" then				--Button 8-- Treble down
				
				if Tre_temp <= 0 then
					Tre_temp := 0;
				elsif Tre_temp > 0 then
					Tre_temp := Tre_temp - 1;
				else 
					Tre_temp := Tre_temp;
				end if;

			elsif Button_temp(7 downto 0) = "01000110" then				--Button 9-- Filter one

				if vFil_Sel_One = 1 then
					vFil_Sel_One := 0;
				else
					vFil_Sel_One := 1;
				end if;
				
			elsif Button_temp(7 downto 0) = "01000101" then				--Button 0-- Filter two
			
				if vFil_Sel_Two = 1 then
					vFil_Sel_Two := 0;
				else
					vFil_Sel_Two := 1;
				end if;
				
			elsif Button_temp(7 downto 0) = "00011101" then				--Button up-arrow-- Volume up "1101110101" // W = 1D = "00011101"

				if Vol_temp >= 10 then
					Vol_temp := 10;
				elsif Vol_temp < 10 then
					Vol_temp := Vol_temp + 1;
				else
					Vol_temp := Vol_temp;
				end if;
				
			elsif Button_temp(7 downto 0) = "00011011" then				--Button down-arrow-- Volume down "1101110010" S = 1B = "00011011"
			
				if Vol_temp <= 0 then
					Vol_temp := 0;
				elsif Vol_temp > 0 then
					Vol_temp := Vol_temp - 1;
				else 
					Vol_temp := Vol_temp;
				end if;
				
			elsif Button_temp(7 downto 0) = "00100011" then				--Button right-arrow-- Balance right "1101101011" D = 23 = "00100011"

				if Bal_temp >= 10 then
					Bal_temp := 10;
				elsif Bal_temp < 10 then
					Bal_temp := Bal_temp + 1;
				else
					Bal_temp := Bal_temp;
				end if;
				
			elsif Button_temp(7 downto 0) = "00011100" then				--Button left-arrow-- Balance left "1101110100" A = 1C = "00011100"
			
				if Bal_temp <= 0 then
					Bal_temp := 0;
				elsif Bal_temp > 0 then
					Bal_temp := Bal_temp - 1;
				else 
					Bal_temp := Bal_temp;
				end if;
			
			else

				Button_temp <= Button_temp;
			
			end if;
		end if;
	end if;
	
	--Outputs--
	Volume <= to_unsigned(Vol_temp,4);
	Balance <= to_unsigned(Bal_temp,4);
	Bass <= to_unsigned(Bas_temp,4);
	Mid_Low <= to_unsigned(vMid_Low,4);
	Mid_High <= to_unsigned(vMid_High,4);
	Treble <= to_unsigned(Tre_temp,4);
	
	Fil_Sel(1 downto 0) <= to_unsigned(vFil_Sel_One,1) & to_unsigned(vFil_Sel_Two,1);
	--Fil_Sel(1) <= to_unsigned(vFil_Sel_Two,1);
	--Fil_Sel_Two <= to_unsigned(vFil_Sel_Two,2);
	
	end process p1;

end architecture;
