library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use work.common.all;

entity FIR_PE_C is -- One for left and one for right channel
	generic(
		coeff : coefficients := (
  X"0009", -- mem(C0) = 0,000141207401730808
  X"0000", -- mem(C1) = 4,07271930563487E-06
  X"FFEF", -- mem(C2) = -0,000247305022398485
  X"FFE2", -- mem(C3) = -0,000451821546938249
  X"FFED", -- mem(C4) = -0,000278615116780277
  X"0016", -- mem(C5) = 0,000336972306971793
  X"003E", -- mem(C6) = 0,000950691641295233
  X"0039", -- mem(C7) = 0,000883064955876421
  X"FFF9", -- mem(C8) = -9,60003039313045E-05
  X"FFA8", -- mem(C9) = -0,00132977574852973
  X"FF91", -- mem(C10) = -0,00168583858676433
  X"FFD7", -- mem(C11) = -0,000615111984594254
  X"004B", -- mem(C12) = 0,00114789164059311
  X"0089", -- mem(C13) = 0,00209927007763432
  X"0059", -- mem(C14) = 0,0013716749980254
  X"FFE8", -- mem(C15) = -0,000353080650817355
  X"FF9E", -- mem(C16) = -0,00148718542149147
  X"FFB1", -- mem(C17) = -0,00119231212013588
  X"FFEF", -- mem(C18) = -0,000259964821036108
  X"FFF9", -- mem(C19) = -9,46368831936647E-05
  X"FFCA", -- mem(C20) = -0,000818243054517285
  X"FFCB", -- mem(C21) = -0,000809112602077709
  X"0058", -- mem(C22) = 0,00134466135832475
  X"0120", -- mem(C23) = 0,00440306657966548
  X"0134", -- mem(C24) = 0,00471093352619596
  X"FFF6", -- mem(C25) = -0,000140176134165555
  X"FE0F", -- mem(C26) = -0,00757813835971689
  X"FD3A", -- mem(C27) = -0,0108279048171703
  X"FEBF", -- mem(C28) = -0,00488373636539331
  X"01E9", -- mem(C29) = 0,00747305024542545
  X"0429", -- mem(C30) = 0,0162568750339707
  X"0335", -- mem(C31) = 0,0125390282550484
  X"FF58", -- mem(C32) = -0,00255521472662089
  X"FB97", -- mem(C33) = -0,017223101348302
  X"FB34", -- mem(C34) = -0,018731679517984
  X"FEAB", -- mem(C35) = -0,00519318629749821
  X"0316", -- mem(C36) = 0,0120653559878079
  X"04C3", -- mem(C37) = 0,0186107921312713
  X"029C", -- mem(C38) = 0,0102051042018986
  X"FF08", -- mem(C39) = -0,00378283070861976
  X"FD55", -- mem(C40) = -0,0104118942542701
  X"FE5F", -- mem(C41) = -0,00636114435832091
  X"FFEC", -- mem(C42) = -0,000294031992698676
  X"FF93", -- mem(C43) = -0,00165321357333835
  X"FDE3", -- mem(C44) = -0,00824321059505548
  X"FE16", -- mem(C45) = -0,00746655751580659
  X"021B", -- mem(C46) = 0,00822531654146332
  X"0732", -- mem(C47) = 0,0281080111745523
  X"077F", -- mem(C48) = 0,0292857672822929
  X"0007", -- mem(C49) = 0,000114884511999077
  X"F551", -- mem(C50) = -0,0417236893541002
  X"F103", -- mem(C51) = -0,0585375257451416
  X"F949", -- mem(C52) = -0,0262240412235698
  X"09A7", -- mem(C53) = 0,0377039899383957
  X"14EC", -- mem(C54) = 0,0817301900799176
  X"1012", -- mem(C55) = 0,0627773426230673
  X"FCDF", -- mem(C56) = -0,0122174093010675
  X"EA17", -- mem(C57) = -0,0855855536022377
  X"E7BB", -- mem(C58) = -0,094802999163279
  X"F903", -- mem(C59) = -0,0272900014466712
  X"10AA", -- mem(C60) = 0,0651035274871585
  X"1B86", -- mem(C61) = 0,107521971617802
  X"10AA", -- mem(C62) = 0,0651035274871585
  X"F903", -- mem(C63) = -0,0272900014466712
  X"E7BB", -- mem(C64) = -0,094802999163279
  X"EA17", -- mem(C65) = -0,0855855536022377
  X"FCDF", -- mem(C66) = -0,0122174093010675
  X"1012", -- mem(C67) = 0,0627773426230673
  X"14EC", -- mem(C68) = 0,0817301900799176
  X"09A7", -- mem(C69) = 0,0377039899383957
  X"F949", -- mem(C70) = -0,0262240412235698
  X"F103", -- mem(C71) = -0,0585375257451416
  X"F551", -- mem(C72) = -0,0417236893541002
  X"0007", -- mem(C73) = 0,000114884511999077
  X"077F", -- mem(C74) = 0,0292857672822929
  X"0732", -- mem(C75) = 0,0281080111745523
  X"021B", -- mem(C76) = 0,00822531654146332
  X"FE16", -- mem(C77) = -0,00746655751580659
  X"FDE3", -- mem(C78) = -0,00824321059505548
  X"FF93", -- mem(C79) = -0,00165321357333835
  X"FFEC", -- mem(C80) = -0,000294031992698676
  X"FE5F", -- mem(C81) = -0,00636114435832091
  X"FD55", -- mem(C82) = -0,0104118942542701
  X"FF08", -- mem(C83) = -0,00378283070861976
  X"029C", -- mem(C84) = 0,0102051042018986
  X"04C3", -- mem(C85) = 0,0186107921312713
  X"0316", -- mem(C86) = 0,0120653559878079
  X"FEAB", -- mem(C87) = -0,00519318629749821
  X"FB34", -- mem(C88) = -0,018731679517984
  X"FB97", -- mem(C89) = -0,017223101348302
  X"FF58", -- mem(C90) = -0,00255521472662089
  X"0335", -- mem(C91) = 0,0125390282550484
  X"0429", -- mem(C92) = 0,0162568750339707
  X"01E9", -- mem(C93) = 0,00747305024542545
  X"FEBF", -- mem(C94) = -0,00488373636539331
  X"FD3A", -- mem(C95) = -0,0108279048171703
  X"FE0F", -- mem(C96) = -0,00757813835971689
  X"FFF6", -- mem(C97) = -0,000140176134165555
  X"0134", -- mem(C98) = 0,00471093352619596
  X"0120", -- mem(C99) = 0,00440306657966548
  X"0058", -- mem(C100) = 0,00134466135832475
  X"FFCB", -- mem(C101) = -0,000809112602077709
  X"FFCA", -- mem(C102) = -0,000818243054517285
  X"FFF9", -- mem(C103) = -9,46368831936647E-05
  X"FFEF", -- mem(C104) = -0,000259964821036108
  X"FFB1", -- mem(C105) = -0,00119231212013588
  X"FF9E", -- mem(C106) = -0,00148718542149147
  X"FFE8", -- mem(C107) = -0,000353080650817355
  X"0059", -- mem(C108) = 0,0013716749980254
  X"0089", -- mem(C109) = 0,00209927007763432
  X"004B", -- mem(C110) = 0,00114789164059311
  X"FFD7", -- mem(C111) = -0,000615111984594254
  X"FF91", -- mem(C112) = -0,00168583858676433
  X"FFA8", -- mem(C113) = -0,00132977574852973
  X"FFF9", -- mem(C114) = -9,60003039313045E-05
  X"0039", -- mem(C115) = 0,000883064955876421
  X"003E", -- mem(C116) = 0,000950691641295233
  X"0016", -- mem(C117) = 0,000336972306971793
  X"FFED", -- mem(C118) = -0,000278615116780277
  X"FFE2", -- mem(C119) = -0,000451821546938249
  X"FFEF", -- mem(C120) = -0,000247305022398485
  X"0000", -- mem(C121) = 4,07271930563487E-06
  X"0009", -- mem(C122) = 0,000141207401730808
  X"0000", -- mem(C123) = 0
  X"0000", -- mem(C124) = 0
  X"0000", -- mem(C125) = 0
  X"0000", -- mem(C126) = 0
  X"0000", -- mem(C127) = 0
  X"0000", -- mem(C128) = 0
  X"0000", -- mem(C129) = 0
  X"0000", -- mem(C130) = 0
  X"0000", -- mem(C131) = 0
  X"0000", -- mem(C132) = 0
  X"0000", -- mem(C133) = 0
  X"0000", -- mem(C134) = 0
  X"0000", -- mem(C135) = 0
  X"0000", -- mem(C136) = 0
  X"0000", -- mem(C137) = 0
  X"0000", -- mem(C138) = 0
  X"0000", -- mem(C139) = 0
  X"0000", -- mem(C140) = 0
  X"0000", -- mem(C141) = 0
  X"0000", -- mem(C142) = 0
  X"0000", -- mem(C143) = 0
  X"0000", -- mem(C144) = 0
  X"0000", -- mem(C145) = 0
  X"0000", -- mem(C146) = 0
  X"0000", -- mem(C147) = 0
  X"0000", -- mem(C148) = 0
  X"0000", -- mem(C149) = 0
  X"0000", -- mem(C150) = 0
  X"0000", -- mem(C151) = 0
  X"0000", -- mem(C152) = 0
  X"0000", -- mem(C153) = 0
  X"0000", -- mem(C154) = 0
  X"0000", -- mem(C155) = 0
  X"0000", -- mem(C156) = 0
  X"0000", -- mem(C157) = 0
  X"0000", -- mem(C158) = 0
  X"0000", -- mem(C159) = 0
  X"0000", -- mem(C160) = 0
  X"0000", -- mem(C161) = 0
  X"0000", -- mem(C162) = 0
  X"0000", -- mem(C163) = 0
  X"0000", -- mem(C164) = 0
  X"0000", -- mem(C165) = 0
  X"0000", -- mem(C166) = 0
  X"0000", -- mem(C167) = 0
  X"0000", -- mem(C168) = 0
  X"0000", -- mem(C169) = 0
  X"0000", -- mem(C170) = 0
  X"0000", -- mem(C171) = 0
  X"0000", -- mem(C172) = 0
  X"0000", -- mem(C173) = 0
  X"0000", -- mem(C174) = 0
  X"0000", -- mem(C175) = 0
  X"0000", -- mem(C176) = 0
  X"0000", -- mem(C177) = 0
  X"0000", -- mem(C178) = 0
  X"0000", -- mem(C179) = 0
  X"0000", -- mem(C180) = 0
  X"0000", -- mem(C181) = 0
  X"0000", -- mem(C182) = 0
  X"0000", -- mem(C183) = 0
  X"0000", -- mem(C184) = 0
  X"0000", -- mem(C185) = 0
  X"0000", -- mem(C186) = 0
  X"0000", -- mem(C187) = 0
  X"0000", -- mem(C188) = 0
  X"0000", -- mem(C189) = 0
  X"0000", -- mem(C190) = 0
  X"0000", -- mem(C191) = 0
  X"0000", -- mem(C192) = 0
  X"0000", -- mem(C193) = 0
  X"0000", -- mem(C194) = 0
  X"0000", -- mem(C195) = 0
  X"0000", -- mem(C196) = 0
  X"0000", -- mem(C197) = 0
  X"0000", -- mem(C198) = 0
  X"0000", -- mem(C199) = 0
  X"0000", -- mem(C200) = 0
  X"0000", -- mem(C201) = 0
  X"0000", -- mem(C202) = 0
  X"0000", -- mem(C203) = 0
  X"0000", -- mem(C204) = 0
  X"0000", -- mem(C205) = 0
  X"0000", -- mem(C206) = 0
  X"0000", -- mem(C207) = 0
  X"0000", -- mem(C208) = 0
  X"0000", -- mem(C209) = 0
  X"0000", -- mem(C210) = 0
  X"0000", -- mem(C211) = 0
  X"0000", -- mem(C212) = 0
  X"0000", -- mem(C213) = 0
  X"0000", -- mem(C214) = 0
  X"0000", -- mem(C215) = 0
  X"0000", -- mem(C216) = 0
  X"0000", -- mem(C217) = 0
  X"0000", -- mem(C218) = 0
  X"0000", -- mem(C219) = 0
  X"0000", -- mem(C220) = 0
  X"0000", -- mem(C221) = 0
  X"0000", -- mem(C222) = 0
  X"0000", -- mem(C223) = 0
  X"0000", -- mem(C224) = 0
  X"0000", -- mem(C225) = 0
  X"0000", -- mem(C226) = 0
  X"0000", -- mem(C227) = 0
  X"0000", -- mem(C228) = 0
  X"0000", -- mem(C229) = 0
  X"0000", -- mem(C230) = 0
  X"0000", -- mem(C231) = 0
  X"0000", -- mem(C232) = 0
  X"0000", -- mem(C233) = 0
  X"0000", -- mem(C234) = 0
  X"0000", -- mem(C235) = 0
  X"0000", -- mem(C236) = 0
  X"0000", -- mem(C237) = 0
  X"0000", -- mem(C238) = 0
  X"0000", -- mem(C239) = 0
  X"0000", -- mem(C240) = 0
  X"0000", -- mem(C241) = 0
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
end FIR_PE_C;
 
architecture Structure of FIR_PE_C is
	
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