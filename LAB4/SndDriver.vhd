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
-- CREATED		"Wed Sep 21 11:03:42 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
LIBRARY work;

ENTITY SndDriver IS 
	PORT(clk,rstn  : IN  STD_LOGIC;
		     -- serial interface:
		     adcdat    : IN  STD_LOGIC;
		     mclk,bclk,adclrc,daclrc,dacdat :  OUT  STD_LOGIC;
		     -- parallel interface:
		     lrsel     : OUT  STD_LOGIC;
		     DAC_en    : in std_logic;
		     ADC_en    : out std_logic;
		     LDAC,RDAC : IN  signed(15 DOWNTO 0);
		     LADC,RADC : OUT  signed(15 DOWNTO 0)
		);
END SndDriver;

ARCHITECTURE bdf_type OF SndDriver IS 

COMPONENT my_mux
	PORT(daclrc : IN STD_LOGIC;
		 dacdatr : IN STD_LOGIC;
		 dacdatl : IN STD_LOGIC;
		 dacdat : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ctrl
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 mclk : OUT STD_LOGIC;
		 bclk : OUT STD_LOGIC;
		 adclrc : OUT STD_LOGIC;
		 daclrc : OUT STD_LOGIC;
		 lrsel : OUT STD_LOGIC;
		 men : OUT STD_LOGIC;
		 ADC_en : OUT STD_LOGIC;
		 BitCnt : OUT unsigned(4 DOWNTO 0);
		 SCCnt : OUT unsigned(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT channel_mod
	PORT(clk : IN STD_LOGIC;
		 rstn : IN STD_LOGIC;
		 men : IN STD_LOGIC;
		 lrsel : IN STD_LOGIC;
		 adcdat : IN STD_LOGIC;
		 DAC_en : IN STD_LOGIC;
		 BitCnt : IN unsigned(4 DOWNTO 0);
		 DAC : IN signed(15 DOWNTO 0);
		 SCCnt : IN unsigned(1 DOWNTO 0);
		 dacdat : OUT STD_LOGIC;
		 ADC : OUT signed(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	adccat :  STD_LOGIC;
SIGNAL	BitCnt :  unsigned(4 DOWNTO 0);
SIGNAL	dacdacr :  STD_LOGIC;
SIGNAL	dacdat_out :  STD_LOGIC;
SIGNAL	dacdatl :  STD_LOGIC;
SIGNAL	daclrc_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	LADC_OUT :  signed(15 DOWNTO 0);
SIGNAL	LDAC_IN :  signed(15 DOWNTO 0);
SIGNAL	lrsel_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	lrsel_not :  STD_LOGIC;
SIGNAL	men :  STD_LOGIC;
SIGNAL	RADC_OUT :  signed(15 DOWNTO 0);
SIGNAL	RDAC_IN :  signed(15 DOWNTO 0);
SIGNAL	SCCnt :  unsigned(1 DOWNTO 0);


BEGIN 



b2v_inst : my_mux
PORT MAP(daclrc => daclrc_ALTERA_SYNTHESIZED,
		 dacdatr => dacdacr,
		 dacdatl => dacdatl,
		 dacdat => dacdat_out);


lrsel_not <= NOT(lrsel_ALTERA_SYNTHESIZED);



b2v_inst_ctrl : ctrl
PORT MAP(clk => clk,
		 rstn => rstn,
		 mclk => mclk,
		 bclk => bclk,
		 adclrc => adclrc,
		 daclrc => daclrc_ALTERA_SYNTHESIZED,
		 lrsel => lrsel_ALTERA_SYNTHESIZED,
		 men => men,
		 ADC_en => ADC_en,
		 BitCnt => BitCnt,
		 SCCnt => SCCnt);


b2v_inst_left : channel_mod
PORT MAP(clk => clk,
		 rstn => rstn,
		 men => men,
		 lrsel => lrsel_ALTERA_SYNTHESIZED,
		 adcdat => adccat,
		 DAC_en => DAC_en,
		 BitCnt => BitCnt,
		 DAC => LDAC_IN,
		 SCCnt => SCCnt,
		 dacdat => dacdatl,
		 ADC => LADC_OUT);


b2v_inst_right : channel_mod
PORT MAP(clk => clk,
		 rstn => rstn,
		 men => men,
		 lrsel => lrsel_not,
		 adcdat => adccat,
		 DAC_en => DAC_en,
		 BitCnt => BitCnt,
		 DAC => RDAC_IN,
		 SCCnt => SCCnt,
		 dacdat => dacdacr,
		 ADC => RADC_OUT);

dacdat <= dacdat_out;
adccat <= adcdat;
RDAC_IN <= RDAC;
LDAC_IN <= LDAC;
daclrc <= daclrc_ALTERA_SYNTHESIZED;
lrsel <= lrsel_ALTERA_SYNTHESIZED;
LADC <= LADC_OUT;
RADC <= RADC_OUT;

END bdf_type;