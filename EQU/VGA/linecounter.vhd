library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity linecounter is
  Port ( clk, rstn, ce : in std_logic;
         hcnt  : in unsigned(9 downto 0);
         vcnt : out unsigned(9 downto 0));
end entity;

architecture rtl of linecounter is
  signal counter: unsigned(9 downto 0);
begin
  process(clk, rstn)
  begin
    if(rstn = '0') then
      counter <= (others =>'0');
    elsif rising_edge(clk) AND ce = '1' then --Kollar Enable, pixlar dvs a och clk 
      if (hcnt = 654  ) then
			   if(counter < 524) then
			      counter <= counter + 1;
			   else
			       counter <= (others =>'0');
				    
			   end if;
		  end if; 
	
	   end if;

	 end process;
	 vcnt <= counter;
end architecture;
