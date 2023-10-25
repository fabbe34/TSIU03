library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--00 inget 
-- 01 svart
---10 grönt
---11 rött 

entity color_manipulation is
  Port ( 
         Color_change  :  in unsigned(1 downto 0);

         vga_r_out :  out unsigned(7 downto 0);
         vga_g_out :  out unsigned(7 downto 0);
         vga_b_out :  out unsigned(7 downto 0);
			
			vga_r_in :  in unsigned(7 downto 0);
         vga_g_in :  in unsigned(7 downto 0);
         vga_b_in :  in unsigned(7 downto 0));
   
end entity;

architecture rtl of color_manipulation is
	signal delete_color :  unsigned(7 downto 0) := (others => '0');
	signal set_color :  unsigned(7 downto 0) := (others => '1');

begin
	vga_r_out <= delete_color when Color_change = "01" else
					delete_color when Color_change = "10" else 
					set_color when Color_change = "11" else 
					vga_r_in;
	vga_g_out <= delete_color when Color_change = "01" else
	
					set_color when Color_change = "10" else 
					delete_color when Color_change = "11" else 
					vga_g_in;
	vga_b_out <= delete_color when Color_change = "01" else	
					delete_color when Color_change = "10" else 
					delete_color when Color_change = "11" else 
					vga_b_in;
end architecture;
