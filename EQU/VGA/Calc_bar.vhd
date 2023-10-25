library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--00 inget 
-- 01 svart
---10 grönt
---11 rött 
entity Calc_bar is
  Port ( clk, rstn : in std_logic;
			volume: in unsigned(3 downto 0);
			balance : in unsigned(3 downto 0);
			treble : in unsigned(3 downto 0);
			bas : in unsigned(3 downto 0);
			mid_low : in unsigned(3 downto 0);
			mid_high	: in unsigned(3 downto 0);
			filter_select : in unsigned(1 downto 0);
         vcnt2 : in unsigned(9 downto 0);
			hcnt2 : in unsigned(9 downto 0);
			Color_change  :  out unsigned(1 downto 0)			
			);

end entity;

architecture rtl of Calc_bar is
	type all_y_pos is array (0 to 10) of
		unsigned(9 downto 0);
		
	constant y_pos: all_y_pos := (
	0 => to_unsigned(244,10),
	1 => TO_UNSIGNED(223,10),
	2 => TO_UNSIGNED(202,10),
	3 => TO_UNSIGNED(181,10),
	4 => TO_UNSIGNED(160,10),
	5 => TO_UNSIGNED(139,10),
	6 => TO_UNSIGNED(118,10),
	7 => TO_UNSIGNED(97,10),
	8 => TO_UNSIGNED(76,10),
	9 => TO_UNSIGNED(55,10),
	10 => TO_UNSIGNED(34,10));

	signal output : unsigned(1 downto 0 ):= (others=>'0');
	signal Bass_y_max :  unsigned(9 downto 0);
	signal trebble_y_max :  unsigned(9 downto 0);
	signal volym_y_max :  unsigned(9 downto 0);
	signal mid_low_y_max :  unsigned(9 downto 0);
	signal mid_high_y_max :  unsigned(9 downto 0);
	signal balance_xleft:  unsigned(9 downto 0);
	signal balance_xright:  unsigned(9 downto 0);


begin

	process(clk,rstn) begin
	

		if rising_edge(clk)  then
			Bass_y_max <= y_pos(to_integer(bas));
			trebble_y_max <= y_pos(to_integer(treble));
			volym_y_max <= y_pos(to_integer(volume));
			mid_low_y_max <= y_pos(to_integer(mid_low));
			mid_high_y_max <=  y_pos(to_integer(mid_high));
			if(balance = 5) then
				balance_xleft <= TO_UNSIGNED(195,10);
				balance_xright <=   TO_UNSIGNED(445,10);
			elsif(balance < 5) then
				balance_xleft <=to_unsigned(195,10)- (to_unsigned(150,10)- (to_unsigned(25,6)*(balance+1)));
				balance_xright <=to_unsigned(445,10)- (to_unsigned(150,10)- (to_unsigned(25,6)*(balance+1)));

			elsif(balance > 5) then
				balance_xleft <=to_unsigned(195,10)+ (to_unsigned(25,6)*(balance-5));
				balance_xright <=to_unsigned(445,10)+ (to_unsigned(25,6)*(balance-5));
				
			end if;
		end if;
	end process;
	process(clk,rstn) begin
	

		if rising_edge(clk)  then
			if(vcnt2 <244 and vcnt2 > bass_y_max and hcnt2 >23 and hcnt2 <63 ) then --bas
				output<="01";
			elsif (vcnt2 <244 and vcnt2 > mid_low_y_max and hcnt2 >106 and hcnt2 <147 ) then --mid_high
				output<="01";
			elsif (vcnt2 <244 and vcnt2 > mid_high_y_max and hcnt2 >189 and hcnt2 <230 ) then --treble mid_high_y_max
				output<="01";
			elsif (vcnt2 <244 and vcnt2 > trebble_y_max and hcnt2 >272 and hcnt2 <313 ) then --mid_low 
				output<="01";
			elsif (vcnt2 <244 and vcnt2 > volym_y_max and hcnt2 >550 and hcnt2 <591 ) then --volym_y_maxtrebble_y_max
				output<="01";
			elsif (vcnt2 > 115 and vcnt2 <156 and hcnt2 >345 and hcnt2 <386 ) then -- left
				if (filter_select="11" or filter_select="10")  then
					output <= "10";
				else
					output <= "11";
				end if;
			elsif (vcnt2 > 115 and vcnt2 <156 and hcnt2 >484 and hcnt2 <525 ) then -- right
				if (filter_select="11" or filter_select="01")  then
					output <= "10";
				else
					output <= "11";
				end if;
			elsif (vcnt2 > 403 and vcnt2 <440 and hcnt2 > balance_xleft and hcnt2 < balance_xright ) then
				output<= "01";
			else 
				output <= "00";
			end if; 
			
			
		end if;
		
	end process;
	
	color_change <= output;
end architecture;
