library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use work.common.all;

entity FIR_PE_B is -- One for left and one for right channel
	generic(
		coeff : coefficients :=  (
  X"0000", -- mem(B0) = 8,64112236027216E-06
  X"FFF3", -- mem(B1) = -0,000197045055538627
  X"FFE6", -- mem(B2) = -0,000388500132076737
  X"FFD4", -- mem(B3) = -0,000665782532435844
  X"FFC1", -- mem(B4) = -0,000948888492776419
  X"FFB5", -- mem(B5) = -0,00114434215989202
  X"FFB5", -- mem(B6) = -0,00114431526317567
  X"FFC7", -- mem(B7) = -0,00085744672902524
  X"FFEF", -- mem(B8) = -0,000245948696031629
  X"002A", -- mem(B9) = 0,000643934244116051
  X"006D", -- mem(B10) = 0,00167066953058256
  X"00AB", -- mem(B11) = 0,00261545686935002
  X"00D3", -- mem(B12) = 0,00323058517700201
  X"00D8", -- mem(B13) = 0,00330976714632334
  X"00B4", -- mem(B14) = 0,00276104900934841
  X"006C", -- mem(B15) = 0,00165865613492818
  X"0010", -- mem(B16) = 0,000250889466161173
  X"FFB8", -- mem(B17) = -0,00108772368934476
  X"FF7F", -- mem(B18) = -0,00195580099089985
  X"FF79", -- mem(B19) = -0,00205320728305447
  X"FFAA", -- mem(B20) = -0,0013003307724229
  X"0006", -- mem(B21) = 9,28925303112969E-05
  X"006B", -- mem(B22) = 0,00164124464861674
  X"00B0", -- mem(B23) = 0,00269293756995112
  X"00AB", -- mem(B24) = 0,00261456368579729
  X"0041", -- mem(B25) = 0,00100605037179387
  X"FF75", -- mem(B26) = -0,00211910033492267
  X"FE66", -- mem(B27) = -0,00625232535680886
  X"FD53", -- mem(B28) = -0,0104502756810769
  X"FC88", -- mem(B29) = -0,0135408252844667
  X"FC4E", -- mem(B30) = -0,0144334522108905
  X"FCCF", -- mem(B31) = -0,0124527888646568
  X"FE0E", -- mem(B32) = -0,00759566315538641
  X"FFD7", -- mem(B33) = -0,000621465081647029
  X"01CF", -- mem(B34) = 0,00707386167950363
  X"0387", -- mem(B35) = 0,0137889315593632
  X"049A", -- mem(B36) = 0,01797644564471
  X"04C9", -- mem(B37) = 0,018705378287782
  X"0417", -- mem(B38) = 0,0159838857199305
  X"02C5", -- mem(B39) = 0,0108272060458113
  X"0149", -- mem(B40) = 0,00502091310030466
  X"0028", -- mem(B41) = 0,000618534764004989
  X"FFD2", -- mem(B42) = -0,000701363003376222
  X"0073", -- mem(B43) = 0,00176469636901194
  X"01E3", -- mem(B44) = 0,00737897918423705
  X"03A0", -- mem(B45) = 0,0141722782878111
  X"04EF", -- mem(B46) = 0,0192726342850233
  X"0509", -- mem(B47) = 0,0196761320987169
  X"035F", -- mem(B48) = 0,0131716800389731
  X"FFC9", -- mem(B49) = -0,000834748323903044
  X"FAA9", -- mem(B50) = -0,0208484081632748
  X"F4E7", -- mem(B51) = -0,0433426381659678
  X"EFC5", -- mem(B52) = -0,0633887174061798
  X"EC9B", -- mem(B53) = -0,0757458753546578
  X"EC80", -- mem(B54) = -0,0761604117443169
  X"EFFC", -- mem(B55) = -0,0625483385473119
  X"F6D9", -- mem(B56) = -0,0357391710060532
  X"001D", -- mem(B57) = 0,00044241062927918
  X"0A31", -- mem(B58) = 0,0398216288524579
  X"133B", -- mem(B59) = 0,0751233894762599
  X"197B", -- mem(B60) = 0,0995426759078508
  X"1BB7", -- mem(B61) = 0,108261882490482
  X"197B", -- mem(B62) = 0,0995426759078508
  X"133B", -- mem(B63) = 0,0751233894762599
  X"0A31", -- mem(B64) = 0,0398216288524579
  X"001D", -- mem(B65) = 0,00044241062927918
  X"F6D9", -- mem(B66) = -0,0357391710060532
  X"EFFC", -- mem(B67) = -0,0625483385473119
  X"EC80", -- mem(B68) = -0,0761604117443169
  X"EC9B", -- mem(B69) = -0,0757458753546578
  X"EFC5", -- mem(B70) = -0,0633887174061798
  X"F4E7", -- mem(B71) = -0,0433426381659678
  X"FAA9", -- mem(B72) = -0,0208484081632748
  X"FFC9", -- mem(B73) = -0,000834748323903044
  X"035F", -- mem(B74) = 0,0131716800389731
  X"0509", -- mem(B75) = 0,0196761320987169
  X"04EF", -- mem(B76) = 0,0192726342850233
  X"03A0", -- mem(B77) = 0,0141722782878111
  X"01E3", -- mem(B78) = 0,00737897918423705
  X"0073", -- mem(B79) = 0,00176469636901194
  X"FFD2", -- mem(B80) = -0,000701363003376222
  X"0028", -- mem(B81) = 0,000618534764004989
  X"0149", -- mem(B82) = 0,00502091310030466
  X"02C5", -- mem(B83) = 0,0108272060458113
  X"0417", -- mem(B84) = 0,0159838857199305
  X"04C9", -- mem(B85) = 0,018705378287782
  X"049A", -- mem(B86) = 0,01797644564471
  X"0387", -- mem(B87) = 0,0137889315593632
  X"01CF", -- mem(B88) = 0,00707386167950363
  X"FFD7", -- mem(B89) = -0,000621465081647029
  X"FE0E", -- mem(B90) = -0,00759566315538641
  X"FCCF", -- mem(B91) = -0,0124527888646568
  X"FC4E", -- mem(B92) = -0,0144334522108905
  X"FC88", -- mem(B93) = -0,0135408252844667
  X"FD53", -- mem(B94) = -0,0104502756810769
  X"FE66", -- mem(B95) = -0,00625232535680886
  X"FF75", -- mem(B96) = -0,00211910033492267
  X"0041", -- mem(B97) = 0,00100605037179387
  X"00AB", -- mem(B98) = 0,00261456368579729
  X"00B0", -- mem(B99) = 0,00269293756995112
  X"006B", -- mem(B100) = 0,00164124464861674
  X"0006", -- mem(B101) = 9,28925303112969E-05
  X"FFAA", -- mem(B102) = -0,0013003307724229
  X"FF79", -- mem(B103) = -0,00205320728305447
  X"FF7F", -- mem(B104) = -0,00195580099089985
  X"FFB8", -- mem(B105) = -0,00108772368934476
  X"0010", -- mem(B106) = 0,000250889466161173
  X"006C", -- mem(B107) = 0,00165865613492818
  X"00B4", -- mem(B108) = 0,00276104900934841
  X"00D8", -- mem(B109) = 0,00330976714632334
  X"00D3", -- mem(B110) = 0,00323058517700201
  X"00AB", -- mem(B111) = 0,00261545686935002
  X"006D", -- mem(B112) = 0,00167066953058256
  X"002A", -- mem(B113) = 0,000643934244116051
  X"FFEF", -- mem(B114) = -0,000245948696031629
  X"FFC7", -- mem(B115) = -0,00085744672902524
  X"FFB5", -- mem(B116) = -0,00114431526317567
  X"FFB5", -- mem(B117) = -0,00114434215989202
  X"FFC1", -- mem(B118) = -0,000948888492776419
  X"FFD4", -- mem(B119) = -0,000665782532435844
  X"FFE6", -- mem(B120) = -0,000388500132076737
  X"FFF3", -- mem(B121) = -0,000197045055538627
  X"0000", -- mem(B122) = 8,64112236027216E-06
  X"0000", -- mem(B123) = 0
  X"0000", -- mem(B124) = 0
  X"0000", -- mem(B125) = 0
  X"0000", -- mem(B126) = 0
  X"0000", -- mem(B127) = 0
  X"0000", -- mem(B128) = 0
  X"0000", -- mem(B129) = 0
  X"0000", -- mem(B130) = 0
  X"0000", -- mem(B131) = 0
  X"0000", -- mem(B132) = 0
  X"0000", -- mem(B133) = 0
  X"0000", -- mem(B134) = 0
  X"0000", -- mem(B135) = 0
  X"0000", -- mem(B136) = 0
  X"0000", -- mem(B137) = 0
  X"0000", -- mem(B138) = 0
  X"0000", -- mem(B139) = 0
  X"0000", -- mem(B140) = 0
  X"0000", -- mem(B141) = 0
  X"0000", -- mem(B142) = 0
  X"0000", -- mem(B143) = 0
  X"0000", -- mem(B144) = 0
  X"0000", -- mem(B145) = 0
  X"0000", -- mem(B146) = 0
  X"0000", -- mem(B147) = 0
  X"0000", -- mem(B148) = 0
  X"0000", -- mem(B149) = 0
  X"0000", -- mem(B150) = 0
  X"0000", -- mem(B151) = 0
  X"0000", -- mem(B152) = 0
  X"0000", -- mem(B153) = 0
  X"0000", -- mem(B154) = 0
  X"0000", -- mem(B155) = 0
  X"0000", -- mem(B156) = 0
  X"0000", -- mem(B157) = 0
  X"0000", -- mem(B158) = 0
  X"0000", -- mem(B159) = 0
  X"0000", -- mem(B160) = 0
  X"0000", -- mem(B161) = 0
  X"0000", -- mem(B162) = 0
  X"0000", -- mem(B163) = 0
  X"0000", -- mem(B164) = 0
  X"0000", -- mem(B165) = 0
  X"0000", -- mem(B166) = 0
  X"0000", -- mem(B167) = 0
  X"0000", -- mem(B168) = 0
  X"0000", -- mem(B169) = 0
  X"0000", -- mem(B170) = 0
  X"0000", -- mem(B171) = 0
  X"0000", -- mem(B172) = 0
  X"0000", -- mem(B173) = 0
  X"0000", -- mem(B174) = 0
  X"0000", -- mem(B175) = 0
  X"0000", -- mem(B176) = 0
  X"0000", -- mem(B177) = 0
  X"0000", -- mem(B178) = 0
  X"0000", -- mem(B179) = 0
  X"0000", -- mem(B180) = 0
  X"0000", -- mem(B181) = 0
  X"0000", -- mem(B182) = 0
  X"0000", -- mem(B183) = 0
  X"0000", -- mem(B184) = 0
  X"0000", -- mem(B185) = 0
  X"0000", -- mem(B186) = 0
  X"0000", -- mem(B187) = 0
  X"0000", -- mem(B188) = 0
  X"0000", -- mem(B189) = 0
  X"0000", -- mem(B190) = 0
  X"0000", -- mem(B191) = 0
  X"0000", -- mem(B192) = 0
  X"0000", -- mem(B193) = 0
  X"0000", -- mem(B194) = 0
  X"0000", -- mem(B195) = 0
  X"0000", -- mem(B196) = 0
  X"0000", -- mem(B197) = 0
  X"0000", -- mem(B198) = 0
  X"0000", -- mem(B199) = 0
  X"0000", -- mem(B200) = 0
  X"0000", -- mem(B201) = 0
  X"0000", -- mem(B202) = 0
  X"0000", -- mem(B203) = 0
  X"0000", -- mem(B204) = 0
  X"0000", -- mem(B205) = 0
  X"0000", -- mem(B206) = 0
  X"0000", -- mem(B207) = 0
  X"0000", -- mem(B208) = 0
  X"0000", -- mem(B209) = 0
  X"0000", -- mem(B210) = 0
  X"0000", -- mem(B211) = 0
  X"0000", -- mem(B212) = 0
  X"0000", -- mem(B213) = 0
  X"0000", -- mem(B214) = 0
  X"0000", -- mem(B215) = 0
  X"0000", -- mem(B216) = 0
  X"0000", -- mem(B217) = 0
  X"0000", -- mem(B218) = 0
  X"0000", -- mem(B219) = 0
  X"0000", -- mem(B220) = 0
  X"0000", -- mem(B221) = 0
  X"0000", -- mem(B222) = 0
  X"0000", -- mem(B223) = 0
  X"0000", -- mem(B224) = 0
  X"0000", -- mem(B225) = 0
  X"0000", -- mem(B226) = 0
  X"0000", -- mem(B227) = 0
  X"0000", -- mem(B228) = 0
  X"0000", -- mem(B229) = 0
  X"0000", -- mem(B230) = 0
  X"0000", -- mem(B231) = 0
  X"0000", -- mem(B232) = 0
  X"0000", -- mem(B233) = 0
  X"0000", -- mem(B234) = 0
  X"0000", -- mem(B235) = 0
  X"0000", -- mem(B236) = 0
  X"0000", -- mem(B237) = 0
  X"0000", -- mem(B238) = 0
  X"0000", -- mem(B239) = 0
  X"0000", -- mem(B240) = 0
  X"0000", -- mem(B241) = 0
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
			
		)
	);
	port(
		clk, rstn : in std_logic;
		x_in 		 : in signed(15 downto 0);
		y_out		 : out signed(15 downto 0);
		start 	 : IN std_logic
	);
end FIR_PE_B;
 
architecture Structure of FIR_PE_B is
	
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
