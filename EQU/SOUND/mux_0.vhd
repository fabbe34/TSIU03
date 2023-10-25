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
-- CREATED		"Wed Sep 21 16:12:25 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY altera;
USE altera.maxplus2.all; 

LIBRARY work;

ENTITY mux_0 IS 
PORT 
( 
	dacdat_L	:	IN	 STD_LOGIC;
	dacdat_R	:	IN	 STD_LOGIC;
	dacdat_out	:	OUT	 STD_LOGIC
); 
END mux_0;

ARCHITECTURE bdf_type OF mux_0 IS 
BEGIN 

-- instantiate macrofunction 

b2v_inst2 : mux
PORT MAP(dacdat_L => dacdat_L,
		 dacdat_R => dacdat_R,
		 dacdat_out => dacdat_out);

END bdf_type; 