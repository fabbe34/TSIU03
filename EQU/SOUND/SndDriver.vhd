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
-- CREATED		"Wed Sep 28 10:28:36 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
LIBRARY work;

ENTITY SndDriver IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rstn :  IN  STD_LOGIC;
		adcdat :  IN  STD_LOGIC;
		DAC_en :  IN  STD_LOGIC;
		LDAC :  IN  SIGNED(15 DOWNTO 0);
		RDAC :  IN  SIGNED(15 DOWNTO 0);
		dacdat_L :  OUT  STD_LOGIC;
		dacdat_R :  OUT  STD_LOGIC;
		mclk :  OUT  STD_LOGIC;
		bclk :  OUT  STD_LOGIC;
		adclrc :  OUT  STD_LOGIC;
		daclrc :  OUT  STD_LOGIC;
		lrsel :  OUT  STD_LOGIC;
		ADC_en :  OUT  STD_LOGIC;
		LADC :  OUT  SIGNED(15 DOWNTO 0);
		RADC :  OUT  SIGNED(15 DOWNTO 0)
	);
END SndDriver;

ARCHITECTURE bdf_type OF SndDriver IS 

COMPONENT ctrl
	PORT(clk : IN STD_LOGIC;
		 rstnout : IN STD_LOGIC;
		 mclk : OUT STD_LOGIC;
		 bclk : OUT STD_LOGIC;
		 adclrc : OUT STD_LOGIC;
		 daclrc : OUT STD_LOGIC;
		 lrsel : OUT STD_LOGIC;
		 ADC_en : OUT STD_LOGIC;
		 men : OUT STD_LOGIC;
		 dacdat : OUT STD_LOGIC;
		 bitCnt : OUT UNSIGNED(4 DOWNTO 0);
		 sCCnt : OUT UNSIGNED(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT channel_mod
	PORT(clk : IN STD_LOGIC;
		 rstnout : IN STD_LOGIC;
		 ADC_en : IN STD_LOGIC;
		 men : IN STD_LOGIC;
		 sel : IN STD_LOGIC;
		 DAC_en : IN STD_LOGIC;
		 adcdat : IN STD_LOGIC;
		 BitCnt : IN UNSIGNED(4 DOWNTO 0);
		 DAC : IN SIGNED(15 DOWNTO 0);
		 SCCnt : IN UNSIGNED(1 DOWNTO 0);
		 dacdat : OUT STD_LOGIC;
		 ADC : OUT SIGNED(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux_channel
	PORT(dacdat_L : IN STD_LOGIC;
		 dacdat_R : IN STD_LOGIC;
		 daclrc : IN STD_LOGIC;
		 dacdat_out : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	ADC_en_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	bitCnt :  UNSIGNED(4 DOWNTO 0);
SIGNAL	dacdat_L :  STD_LOGIC;
SIGNAL	dacdat_out :  STD_LOGIC;
SIGNAL	dacdat_R :  STD_LOGIC;
SIGNAL	daclrc_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	men :  STD_LOGIC;
SIGNAL	not_sel :  STD_LOGIC;
SIGNAL	SCCnt :  UNSIGNED(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;


BEGIN 
lrsel <= SYNTHESIZED_WIRE_2;



not_sel <= NOT(SYNTHESIZED_WIRE_2);



b2v_inst_ctrl : ctrl
PORT MAP(clk => clk,
		 rstnout => rstn,
		 mclk => mclk,
		 bclk => bclk,
		 adclrc => adclrc,
		 daclrc => daclrc_ALTERA_SYNTHESIZED,
		 lrsel => SYNTHESIZED_WIRE_2,
		 ADC_en => ADC_en_ALTERA_SYNTHESIZED,
		 men => men,
		 bitCnt => bitCnt,
		 sCCnt => SCCnt);


b2v_inst_left : channel_mod
PORT MAP(clk => clk,
		 rstnout => rstn,
		 ADC_en => ADC_en_ALTERA_SYNTHESIZED,
		 men => men,
		 sel => SYNTHESIZED_WIRE_2,
		 DAC_en => DAC_en,
		 adcdat => adcdat,
		 BitCnt => bitCnt,
		 DAC => LDAC,
		 SCCnt => SCCnt,
		 dacdat => dacdat_L,
		 ADC => LADC);


b2v_inst_mux : mux_channel
PORT MAP(dacdat_L => dacdat_L,
		 dacdat_R => dacdat_R,
		 daclrc => daclrc_ALTERA_SYNTHESIZED,
		 dacdat_out => dacdat_out);


b2v_inst_right : channel_mod
PORT MAP(clk => clk,
		 rstnout => rstn,
		 ADC_en => ADC_en_ALTERA_SYNTHESIZED,
		 men => men,
		 sel => not_sel,
		 DAC_en => DAC_en,
		 adcdat => adcdat,
		 BitCnt => bitCnt,
		 DAC => RDAC,
		 SCCnt => SCCnt,
		 dacdat => dacdat_R,
		 ADC => RADC);

dacdat <= dacdat_out;
daclrc <= daclrc_ALTERA_SYNTHESIZED;
ADC_en <= ADC_en_ALTERA_SYNTHESIZED;

END bdf_type;