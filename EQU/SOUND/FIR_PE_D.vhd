library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use work.common.all;

entity FIR_PE_D is -- One for left and one for right channel
	generic(
		coeff : coefficients := (
  X"0101", -- mem(D0) = 0,00392567288842119
  X"FDD8", -- mem(D1) = -0,00841337552246887
  X"FAF3", -- mem(D2) = -0,0197297836712259
  X"1E89", -- mem(D3) = 0,119291853966136
  X"BE0B", -- mem(D4) = -0,257641973534519
  X"5346", -- mem(D5) = 0,325298595884331
  X"BE0B", -- mem(D6) = -0,257641973534519
  X"1E89", -- mem(D7) = 0,119291853966136
  X"FAF3", -- mem(D8) = -0,0197297836712259
  X"FDD8", -- mem(D9) = -0,00841337552246887
  X"0101", -- mem(D10) = 0,00392567288842119
  X"0000", -- mem(D11) = 0
  X"0000", -- mem(D12) = 0
  X"0000", -- mem(D13) = 0
  X"0000", -- mem(D14) = 0
  X"0000", -- mem(D15) = 0
  X"0000", -- mem(D16) = 0
  X"0000", -- mem(D17) = 0
  X"0000", -- mem(D18) = 0
  X"0000", -- mem(D19) = 0
  X"0000", -- mem(D20) = 0
  X"0000", -- mem(D21) = 0
  X"0000", -- mem(D22) = 0
  X"0000", -- mem(D23) = 0
  X"0000", -- mem(D24) = 0
  X"0000", -- mem(D25) = 0
  X"0000", -- mem(D26) = 0
  X"0000", -- mem(D27) = 0
  X"0000", -- mem(D28) = 0
  X"0000", -- mem(D29) = 0
  X"0000", -- mem(D30) = 0
  X"0000", -- mem(D31) = 0
  X"0000", -- mem(D32) = 0
  X"0000", -- mem(D33) = 0
  X"0000", -- mem(D34) = 0
  X"0000", -- mem(D35) = 0
  X"0000", -- mem(D36) = 0
  X"0000", -- mem(D37) = 0
  X"0000", -- mem(D38) = 0
  X"0000", -- mem(D39) = 0
  X"0000", -- mem(D40) = 0
  X"0000", -- mem(D41) = 0
  X"0000", -- mem(D42) = 0
  X"0000", -- mem(D43) = 0
  X"0000", -- mem(D44) = 0
  X"0000", -- mem(D45) = 0
  X"0000", -- mem(D46) = 0
  X"0000", -- mem(D47) = 0
  X"0000", -- mem(D48) = 0
  X"0000", -- mem(D49) = 0
  X"0000", -- mem(D50) = 0
  X"0000", -- mem(D51) = 0
  X"0000", -- mem(D52) = 0
  X"0000", -- mem(D53) = 0
  X"0000", -- mem(D54) = 0
  X"0000", -- mem(D55) = 0
  X"0000", -- mem(D56) = 0
  X"0000", -- mem(D57) = 0
  X"0000", -- mem(D58) = 0
  X"0000", -- mem(D59) = 0
  X"0000", -- mem(D60) = 0
  X"0000", -- mem(D61) = 0
  X"0000", -- mem(D62) = 0
  X"0000", -- mem(D63) = 0
  X"0000", -- mem(D64) = 0
  X"0000", -- mem(D65) = 0
  X"0000", -- mem(D66) = 0
  X"0000", -- mem(D67) = 0
  X"0000", -- mem(D68) = 0
  X"0000", -- mem(D69) = 0
  X"0000", -- mem(D70) = 0
  X"0000", -- mem(D71) = 0
  X"0000", -- mem(D72) = 0
  X"0000", -- mem(D73) = 0
  X"0000", -- mem(D74) = 0
  X"0000", -- mem(D75) = 0
  X"0000", -- mem(D76) = 0
  X"0000", -- mem(D77) = 0
  X"0000", -- mem(D78) = 0
  X"0000", -- mem(D79) = 0
  X"0000", -- mem(D80) = 0
  X"0000", -- mem(D81) = 0
  X"0000", -- mem(D82) = 0
  X"0000", -- mem(D83) = 0
  X"0000", -- mem(D84) = 0
  X"0000", -- mem(D85) = 0
  X"0000", -- mem(D86) = 0
  X"0000", -- mem(D87) = 0
  X"0000", -- mem(D88) = 0
  X"0000", -- mem(D89) = 0
  X"0000", -- mem(D90) = 0
  X"0000", -- mem(D91) = 0
  X"0000", -- mem(D92) = 0
  X"0000", -- mem(D93) = 0
  X"0000", -- mem(D94) = 0
  X"0000", -- mem(D95) = 0
  X"0000", -- mem(D96) = 0
  X"0000", -- mem(D97) = 0
  X"0000", -- mem(D98) = 0
  X"0000", -- mem(D99) = 0
  X"0000", -- mem(D100) = 0
  X"0000", -- mem(D101) = 0
  X"0000", -- mem(D102) = 0
  X"0000", -- mem(D103) = 0
  X"0000", -- mem(D104) = 0
  X"0000", -- mem(D105) = 0
  X"0000", -- mem(D106) = 0
  X"0000", -- mem(D107) = 0
  X"0000", -- mem(D108) = 0
  X"0000", -- mem(D109) = 0
  X"0000", -- mem(D110) = 0
  X"0000", -- mem(D111) = 0
  X"0000", -- mem(D112) = 0
  X"0000", -- mem(D113) = 0
  X"0000", -- mem(D114) = 0
  X"0000", -- mem(D115) = 0
  X"0000", -- mem(D116) = 0
  X"0000", -- mem(D117) = 0
  X"0000", -- mem(D118) = 0
  X"0000", -- mem(D119) = 0
  X"0000", -- mem(D120) = 0
  X"0000", -- mem(D121) = 0
  X"0000", -- mem(D122) = 0
  X"0000", -- mem(D123) = 0
  X"0000", -- mem(D124) = 0
  X"0000", -- mem(D125) = 0
  X"0000", -- mem(D126) = 0
  X"0000", -- mem(D127) = 0
  X"0000", -- mem(D128) = 0
  X"0000", -- mem(D129) = 0
  X"0000", -- mem(D130) = 0
  X"0000", -- mem(D131) = 0
  X"0000", -- mem(D132) = 0
  X"0000", -- mem(D133) = 0
  X"0000", -- mem(D134) = 0
  X"0000", -- mem(D135) = 0
  X"0000", -- mem(D136) = 0
  X"0000", -- mem(D137) = 0
  X"0000", -- mem(D138) = 0
  X"0000", -- mem(D139) = 0
  X"0000", -- mem(D140) = 0
  X"0000", -- mem(D141) = 0
  X"0000", -- mem(D142) = 0
  X"0000", -- mem(D143) = 0
  X"0000", -- mem(D144) = 0
  X"0000", -- mem(D145) = 0
  X"0000", -- mem(D146) = 0
  X"0000", -- mem(D147) = 0
  X"0000", -- mem(D148) = 0
  X"0000", -- mem(D149) = 0
  X"0000", -- mem(D150) = 0
  X"0000", -- mem(D151) = 0
  X"0000", -- mem(D152) = 0
  X"0000", -- mem(D153) = 0
  X"0000", -- mem(D154) = 0
  X"0000", -- mem(D155) = 0
  X"0000", -- mem(D156) = 0
  X"0000", -- mem(D157) = 0
  X"0000", -- mem(D158) = 0
  X"0000", -- mem(D159) = 0
  X"0000", -- mem(D160) = 0
  X"0000", -- mem(D161) = 0
  X"0000", -- mem(D162) = 0
  X"0000", -- mem(D163) = 0
  X"0000", -- mem(D164) = 0
  X"0000", -- mem(D165) = 0
  X"0000", -- mem(D166) = 0
  X"0000", -- mem(D167) = 0
  X"0000", -- mem(D168) = 0
  X"0000", -- mem(D169) = 0
  X"0000", -- mem(D170) = 0
  X"0000", -- mem(D171) = 0
  X"0000", -- mem(D172) = 0
  X"0000", -- mem(D173) = 0
  X"0000", -- mem(D174) = 0
  X"0000", -- mem(D175) = 0
  X"0000", -- mem(D176) = 0
  X"0000", -- mem(D177) = 0
  X"0000", -- mem(D178) = 0
  X"0000", -- mem(D179) = 0
  X"0000", -- mem(D180) = 0
  X"0000", -- mem(D181) = 0
  X"0000", -- mem(D182) = 0
  X"0000", -- mem(D183) = 0
  X"0000", -- mem(D184) = 0
  X"0000", -- mem(D185) = 0
  X"0000", -- mem(D186) = 0
  X"0000", -- mem(D187) = 0
  X"0000", -- mem(D188) = 0
  X"0000", -- mem(D189) = 0
  X"0000", -- mem(D190) = 0
  X"0000", -- mem(D191) = 0
  X"0000", -- mem(D192) = 0
  X"0000", -- mem(D193) = 0
  X"0000", -- mem(D194) = 0
  X"0000", -- mem(D195) = 0
  X"0000", -- mem(D196) = 0
  X"0000", -- mem(D197) = 0
  X"0000", -- mem(D198) = 0
  X"0000", -- mem(D199) = 0
  X"0000", -- mem(D200) = 0
  X"0000", -- mem(D201) = 0
  X"0000", -- mem(D202) = 0
  X"0000", -- mem(D203) = 0
  X"0000", -- mem(D204) = 0
  X"0000", -- mem(D205) = 0
  X"0000", -- mem(D206) = 0
  X"0000", -- mem(D207) = 0
  X"0000", -- mem(D208) = 0
  X"0000", -- mem(D209) = 0
  X"0000", -- mem(D210) = 0
  X"0000", -- mem(D211) = 0
  X"0000", -- mem(D212) = 0
  X"0000", -- mem(D213) = 0
  X"0000", -- mem(D214) = 0
  X"0000", -- mem(D215) = 0
  X"0000", -- mem(D216) = 0
  X"0000", -- mem(D217) = 0
  X"0000", -- mem(D218) = 0
  X"0000", -- mem(D219) = 0
  X"0000", -- mem(D220) = 0
  X"0000", -- mem(D221) = 0
  X"0000", -- mem(D222) = 0
  X"0000", -- mem(D223) = 0
  X"0000", -- mem(D224) = 0
  X"0000", -- mem(D225) = 0
  X"0000", -- mem(D226) = 0
  X"0000", -- mem(D227) = 0
  X"0000", -- mem(D228) = 0
  X"0000", -- mem(D229) = 0
  X"0000", -- mem(D230) = 0
  X"0000", -- mem(D231) = 0
  X"0000", -- mem(D232) = 0
  X"0000", -- mem(D233) = 0
  X"0000", -- mem(D234) = 0
  X"0000", -- mem(D235) = 0
  X"0000", -- mem(D236) = 0
  X"0000", -- mem(D237) = 0
  X"0000", -- mem(D238) = 0
  X"0000", -- mem(D239) = 0
  X"0000", -- mem(D240) = 0
  X"0000", -- mem(D241) = 0
  X"0000",
  
  			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000", -- mem(A242) = 0,0
			X"0000"  -- mem(A242) = 0,0
			)-- mem(C242) = 0
	);
	port(
		clk, rstn : in std_logic;
		x_in 		 : in signed(15 downto 0);
		y_out		 : out signed(15 downto 0);
		start 	 : IN std_logic
	);
end FIR_PE_D;
 
architecture Structure of FIR_PE_D is
	
	constant FIR_TAPS 			: integer := 256;
	constant COEFFICIENT_ROM 	: coefficients := coeff;
	signal INPUT_RAM 				: coefficients;
	
	--
	-- Constrol signals
	--
	type STATE_TYPE is (STOP, NEW_SAMPLE, RUN);
	signal state, state_delay					: STATE_TYPE;
	signal cnt, offset_cnt						: unsigned(7 downto 0);
	
	--
	-- RAM signals;
	--
	signal ram_we 									: std_logic;
	signal ram_addr_read, ram_addr_write 	: unsigned(7 downto 0);
	signal ram_out 								: signed(15 downto 0);
	signal ram_in									: signed(15 downto 0);
	
	--
	-- ROM signals
	--
	signal rom_addr								: unsigned(7 downto 0);
	signal rom_out 								: signed(15 downto 0);
	
	--
	-- Multiply and accumulate signals
	--
	signal accumulate 							: std_logic;
	signal accumulate_zero 						: std_logic;
	signal accumulator 							: signed(31 downto 0);
	signal mul_out 								: signed(31 downto 0);
	signal add_out 								: signed(31 downto 0);

	
begin
	
	--
	-- FIR Processing element control logic
	--
	process(clk, rstn)
	begin
		if rstn = '0' then
			state <= STOP;
			state_delay <= STOP;
			cnt <= (others => '0');
			offset_cnt <= (others => '0');
		elsif rising_edge(clk) then
		
			-- Always delay the delay-state
			state_delay <= state;
		
			case state is
				when STOP =>
					if start = '1' then
						state <= NEW_SAMPLE;
					end if;
				when NEW_SAMPLE =>
					state <= RUN;
				when RUN =>
					cnt <= cnt + 1;
					if cnt >= FIR_TAPS-1 then
					   y_out <= accumulator(31 downto 16);
						state <= STOP;
						offset_cnt <= offset_cnt + 1;
						if offset_cnt >= FIR_TAPS-1 then
							offset_cnt <= (others => '0');
						end if;
					end if;
					
			end case;
		end if;
	end process;
	
	--
	-- 2-port RAM
	--
	process(clk)
	begin
		if rising_edge(clk) then
			if ram_we = '1' then
				INPUT_RAM(to_integer(ram_addr_write)) <= ram_in;
			end if;
			ram_out <= INPUT_RAM(to_integer(ram_addr_read));
		end if;
	end process;
	ram_in <= x_in;
	ram_we <= '1' when state = NEW_SAMPLE else '0';
	ram_addr_read <= offset_cnt - cnt;
	ram_addr_write <= offset_cnt;
	
	--
	-- Coefficient ROM memory
	--
	process(clk)
	begin
		if rising_edge(clk) then
			rom_out <= COEFFICIENT_ROM(to_integer(rom_addr));
		end if;
	end process;
	rom_addr <= cnt;
	
	--
	-- Multiply and accumulate processing element
	--
	add_out <= accumulator + mul_out;
	mul_out <= rom_out * ram_out;
	process(clk,rstn)
	begin
		if rstn = '0' then
			accumulator <= (others => '0');
		elsif rising_edge(clk) then
			if state_delay /= RUN then
				accumulator <= (others => '0');
			else
				accumulator <= add_out;
			end if;
		end if;	
	end process;

end architecture;