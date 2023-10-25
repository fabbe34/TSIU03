library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Lab2_KB_exercise3 is
	port(rstn,clk,PS2_CLK,PS2_DAT : in std_logic;
		  scancode_en : out std_logic;
		  Button : out unsigned(9 downto 0));
		  --HEX0 : out std_logic_vector(6 downto 0));

end entity;

architecture rtl of Lab2_KB_exercise3 is
	signal shiftreg : std_logic_vector(9 downto 0);
	signal PS2_CLK2, PS2_DAT2, PS2_CLK2_OLD, detected_fall : std_logic;
	signal PS2_byte : std_logic_vector(7 downto 0);
	signal PS2_byte_en : std_logic;
	signal scancode : std_logic_vector(9 downto 0);
	signal E0 : std_logic;
	signal F0 : std_logic;
	
begin
	p1 : process(clk) begin
		if rising_edge(clk) then
			--assign unput DFFs here
			PS2_DAT2 <= PS2_DAT;
			PS2_CLK2 <= PS2_CLK;
			PS2_CLK2_OLD <= PS2_CLK2;
		end if; --rising edge clk
	end process;
	detected_fall <= not PS2_CLK2 AND PS2_CLK2_OLD; -- problem va ska in här?
	
	--Process 2 handle shift register
	p2 : process(clk,rstn) begin
		if rstn = '0' then
			--insert reset values here
			shiftreg <= (others => '1');
		
		elsif rising_edge(clk) then
			--assign shift register here
			if detected_fall = '1' then
				shiftreg(8 downto 0) <= shiftreg(9 downto 1);
				shiftreg(9) <= PS2_DAT2;
			
			elsif PS2_byte_en = '1' then
				
				shiftreg <= (others => '1');
				
			end if;
			
		end if;
	end process;
	PS2_byte <= shiftreg(8 downto 1);
	PS2_byte_en <= not shiftreg(0);
	
	p3 : process(clk,rstn) begin
	
		if rstn = '0' then
			scancode <= (others => '0');
			scancode_en <= '0';
			
		elsif rising_edge(clk) then
			scancode_en <= '0'; -- default
			if PS2_byte_en = '1' then
				--scancode(7 downto 0) <= PS2_byte;
				if PS2_byte = "11100000" then
					E0 <= '1';
				elsif PS2_byte = "11110000" then
					F0 <= '1';
					scancode <= F0 & '0' & PS2_byte;
					scancode_en <= '1';
				else
					scancode <= F0 & E0 & PS2_byte;
					--scancode_en <= '1';
					E0 <= '0';
					F0 <= '0';
				end if;
			end if;
		end if;
	end process;

	Button <= unsigned(scancode(9 downto 0));
	
	-- Recode the scan code shiftreg(7..0) here:
--	HEX0 <= "1111001" when scancode(7 downto 0) = "00010110" else	--1
--			  "0100100" when scancode(7 downto 0) = "00011110" else	--2
--			  "0110000" when scancode(7 downto 0) = "00100110" else	--3
--			  "0011001" when scancode(7 downto 0) = "00100101" else	--4
--			  "0010010" when scancode(7 downto 0) = "00101110" else	--5
--			  "0000010" when scancode(7 downto 0) = "00110110" else	--6
--			  "1111000" when scancode(7 downto 0) = "00111101" else	--7
--			  "0000000" when scancode(7 downto 0) = "00111110" else	--8
--			  "0010000" when scancode(7 downto 0) = "01000110" else	--9
--			  "1000000" when scancode(7 downto 0) = "01000101" else	--0
--			  "0000110";											--else

end architecture;