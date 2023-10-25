-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"
-- CREATED		"Wed Sep 21 11:51:57 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Sound IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rstn :  IN  STD_LOGIC;
		adcdat :  IN  STD_LOGIC;
		SW :  IN  STD_LOGIC_VECTOR(5 TO 7);
		mclk :  OUT  STD_LOGIC;
		bclk :  OUT  STD_LOGIC;
		adclrc :  OUT  STD_LOGIC;
		daclrc :  OUT  STD_LOGIC;
		dacdat :  OUT  STD_LOGIC;
		HEX6 :  OUT  STD_LOGIC_VECTOR(0 TO 6);
		HEX7 :  OUT  STD_LOGIC_VECTOR(0 TO 6);
		LEDR :  OUT  STD_LOGIC_VECTOR(0 TO 17)
	);
END Sound;

ARCHITECTURE bdf_type OF Sound IS 

COMPONENT group_no
GENERIC (number : INTEGER
			);
	PORT(		 HEX6 : OUT STD_LOGIC_VECTOR(0 TO 6);
		 HEX7 : OUT STD_LOGIC_VECTOR(0 TO 6)
	);
END COMPONENT;

COMPONENT my_fancy_application
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 lrsel : IN STD_LOGIC;
		 ADC_en : IN STD_LOGIC;
		 LADC : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 RADC : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 SW : IN STD_LOGIC_VECTOR(5 TO 7);
		 DAC_en : OUT STD_LOGIC;
		 LDAC : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 LEDR : OUT STD_LOGIC_VECTOR(0 TO 17);
		 RDAC : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT snddriver
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 adcdat : IN STD_LOGIC;
		 DAC_en : IN STD_LOGIC;
		 LDAC : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 RDAC : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 mclk : OUT STD_LOGIC;
		 bclk : OUT STD_LOGIC;
		 adclrc : OUT STD_LOGIC;
		 daclrc : OUT STD_LOGIC;
		 lrsel : OUT STD_LOGIC;
		 dacdat : OUT STD_LOGIC;
		 ADC_en : OUT STD_LOGIC;
		 LADC : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 RADC : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	ADC_en :  STD_LOGIC;
SIGNAL	DAC_en :  STD_LOGIC;
SIGNAL	LADC :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	LDAC :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	lrsel :  STD_LOGIC;
SIGNAL	RADC :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	RDAC :  STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN 



b2v_inst : group_no
GENERIC MAP(number => 13
			)
PORT MAP(		 HEX6 => HEX6,
		 HEX7 => HEX7);


b2v_inst1 : my_fancy_application
PORT MAP(clk => clk,
		 rstn => rstn,
		 lrsel => lrsel,
		 ADC_en => ADC_en,
		 LADC => LADC,
		 RADC => RADC,
		 SW => SW,
		 DAC_en => DAC_en,
		 LDAC => LDAC,
		 LEDR => LEDR,
		 RDAC => RDAC);


b2v_instSndDrv : snddriver
PORT MAP(clk => clk,
		 rstn => rstn,
		 adcdat => adcdat,
		 DAC_en => DAC_en,
		 LDAC => LDAC,
		 RDAC => RDAC,
		 mclk => mclk,
		 bclk => bclk,
		 adclrc => adclrc,
		 daclrc => daclrc,
		 lrsel => lrsel,
		 dacdat => dacdat,
		 ADC_en => ADC_en,
		 LADC => LADC,
		 RADC => RADC);


END bdf_type;