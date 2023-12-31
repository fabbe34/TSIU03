library ieee;
use ieee.std_logic_1164.all;
library work;



entity Lab2_KB_TB is
end entity;


architecture sim of Lab2_KB_TB is
    signal rstn,PS2_CLK,PS2_DAT :  std_logic;
    signal clk : std_logic:= '0';
    signal HEX0:   std_logic_vector(6 downto 0);
    signal LEDR:  std_logic_vector(7 downto 0);
    signal HEX7,HEX6:  std_logic_vector(6 downto 0);
component Lab2_KB is 
    port(rstn, clk,PS2_CLK, PS2_DAT : in std_logic;
        HEX0: out  std_logic_vector(6 downto 0);
        LEDR: out std_logic_vector(7 downto 0);
        HEX7,HEX6: out std_logic_vector(6 downto 0));
end component;
begin
 clk <= not clk after 100 ns;
 rstn <= '0', '1' after 300 ns;
 process begin
    PS2_CLK <= '1'; PS2_DAT <= '0';
    wait for 100 us;

    PS2_DAT <= '1';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;


    PS2_DAT <= '0';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;

    PS2_DAT <= '1';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;


    PS2_DAT <= '0';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;

    PS2_DAT <= '0';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;

    PS2_DAT <= '1';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;

    PS2_DAT <= '0';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;

    PS2_DAT <= '0';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;



    PS2_DAT <= '0';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;


    PS2_DAT <= '1';
    PS2_CLK <= '0' after 10 us, '1' after 35 us;
    wait for 100 us;
    
    if HEX0 = "0011001" then
        Report "OK" severity note;
    else
        report "NOK" severity error;
    end if;
    wait;
end process;

DUT : Lab2_KB
port map ( rstn => rstn, clk => clk, PS2_DAT => PS2_DAT, PS2_CLK => PS2_CLK, HEX0 => HEX0, HEX6=> HEX6, HEX7 => HEX7, LEDR => LEDR);
end architecture;

