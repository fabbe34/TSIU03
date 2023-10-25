library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.math_real.all;
use work.common.all;
entity FIR_Controller is -- 
    generic(
		Filter_order: integer := 256;
       Input_WL : integer range 8 to 32 := 16;
       Coeff_WL : integer range 8 to 32 := 16;
       Output_WL : integer range 8 to 32 := 16 
      
    );
    Port ( 
		-- Volume on each band, 5 levels, linear
		A_vol: in integer range 0 to 4;
		B_vol: in integer range 0 to 4;
		C_vol: in integer range 0 to 4;
		D_vol: in integer range 0 to 4;
		-- 8 levels of balance, linear
		L_bal: in integer range 0 to 7;
		R_bal: in integer range 0 to 7;
		-- 10 levels of balance, logarithmic
		T_vol: in integer range 0 to 10;
		
		
		
		clk: inout std_logic;
		rst: in std_logic;
		clr: in std_logic;
		
		Band_A: out coefficients;
		Band_B: out coefficients;
		Band_C: out coefficients;
		Band_D: out coefficients;
		
		
		
		-- gain and balance as constants, fixed point arithmetic
		A_gain: out integer range 0 to 1;
		B_gain: out integer range 0 to 1;
		C_gain: out integer range 0 to 1;
		D_gain: out integer range 0 to 1;
		LR_bal: out integer range 0 to 1
		
		
		);
end FIR_Controller;
 
architecture Filter_adress of FIR_Controller is
 
	signal coeff_en: std_logic;
	signal test: signed(15 downto 0);
	Signal A,B,C,D: coefficients;
	
	signal Ag,Bg,Cg,Dg: integer range 0 to 1 := 1;

begin
	-- turn integer volume level into gain constants, aka fixed point arhitmetic
	-- when else sats,
	
	
	
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
		Band_A<= (
  X"0003", -- mem(A0) = 5,52345897316551E-05
  X"0004", -- mem(A1) = 6,80644238118407E-05
  X"0005", -- mem(A2) = 8,24589475370423E-05
  X"0006", -- mem(A3) = 9,84452601078052E-05
  X"0007", -- mem(A4) = 0,000116068950190736
  X"0008", -- mem(A5) = 0,000135248483153016
  X"000A", -- mem(A6) = 0,000155968483382642
  X"000B", -- mem(A7) = 0,000178155643529953
  X"000D", -- mem(A8) = 0,000201821969265627
  X"000E", -- mem(A9) = 0,000226791245218498
  X"0010", -- mem(A10) = 0,000252911486259129
  X"0012", -- mem(A11) = 0,000279962554194093
  X"0014", -- mem(A12) = 0,00030793593714325
  X"0016", -- mem(A13) = 0,000336384341656877
  X"0017", -- mem(A14) = 0,00036505315389209
  X"0019", -- mem(A15) = 0,000393764380603094
  X"001B", -- mem(A16) = 0,000421962671475817
  X"001D", -- mem(A17) = 0,000449453667631933
  X"001F", -- mem(A18) = 0,00047571587913539
  X"0020", -- mem(A19) = 0,000500356402770411
  X"0022", -- mem(A20) = 0,000522832192503619
  X"0023", -- mem(A21) = 0,000542673488164318
  X"0024", -- mem(A22) = 0,000559329327434486
  X"0025", -- mem(A23) = 0,000572241709785608
  X"0026", -- mem(A24) = 0,000580814114668601
  X"0026", -- mem(A25) = 0,000584487717924256
  X"0026", -- mem(A26) = 0,00058265572366315
  X"0025", -- mem(A27) = 0,000574688639465408
  X"0024", -- mem(A28) = 0,000560044620486117
  X"0023", -- mem(A29) = 0,000538073861900304
  X"0021", -- mem(A30) = 0,00050821343574349
  X"001E", -- mem(A31) = 0,000469925491451767
  X"001B", -- mem(A32) = 0,000422660047205058
  X"0018", -- mem(A33) = 0,000365954198445497
  X"0013", -- mem(A34) = 0,000299335869329561
  X"000E", -- mem(A35) = 0,000222443384258505
  X"0008", -- mem(A36) = 0,000134921514874078
  X"0002", -- mem(A37) = 3,65225417273913E-05
  X"FFFB", -- mem(A38) = -7,29493426174901E-05
  X"FFF3", -- mem(A39) = -0,000193587399621588
  X"FFEA", -- mem(A40) = -0,000325432202961925
  X"FFE1", -- mem(A41) = -0,00046837665772445
  X"FFD7", -- mem(A42) = -0,000622245244910659
  X"FFCC", -- mem(A43) = -0,000786758526926491
  X"FFC1", -- mem(A44) = -0,000961489229025817
  X"FFB4", -- mem(A45) = -0,00114593048250338
  X"FFA8", -- mem(A46) = -0,00133942150087028
  X"FF9B", -- mem(A47) = -0,00154119322655691
  X"FF8D", -- mem(A48) = -0,00175034293294687
  X"FF7F", -- mem(A49) = -0,00196584098315754
  X"FF70", -- mem(A50) = -0,00218654338994281
  X"FF62", -- mem(A51) = -0,00241115761968007
  X"FF53", -- mem(A52) = -0,00263828709212596
  X"FF44", -- mem(A53) = -0,00286640623694068
  X"FF35", -- mem(A54) = -0,00309388163147455
  X"FF26", -- mem(A55) = -0,00331895035035988
  X"FF18", -- mem(A56) = -0,00353977941381046
  X"FF0A", -- mem(A57) = -0,00375440536325517
  X"FEFC", -- mem(A58) = -0,00396080625689552
  X"FEEF", -- mem(A59) = -0,00415687914875703
  X"FEE3", -- mem(A60) = -0,00434045401858865
  X"FED8", -- mem(A61) = -0,00450932118459746
  X"FECE", -- mem(A62) = -0,004661223153316
  X"FEC5", -- mem(A63) = -0,00479389935618745
  X"FEBE", -- mem(A64) = -0,00490507014977938
  X"FEB8", -- mem(A65) = -0,00499247327398246
  X"FEB4", -- mem(A66) = -0,00505387509139222
  X"FEB2", -- mem(A67) = -0,00508708333639423
  X"FEB2", -- mem(A68) = -0,0050899675300111
  X"FEB4", -- mem(A69) = -0,00506048149787073
  X"FEB8", -- mem(A70) = -0,00499667755645861
  X"FEBF", -- mem(A71) = -0,00489671178382397
  X"FEC8", -- mem(A72) = -0,00475889570663942
  X"FED3", -- mem(A73) = -0,00458167039531877
  X"FEE2", -- mem(A74) = -0,0043636636512899
  X"FEF3", -- mem(A75) = -0,00410367271627798
  X"FF06", -- mem(A76) = -0,0038007026511583
  X"FF1D", -- mem(A77) = -0,00345396875335889
  X"FF37", -- mem(A78) = -0,00306290894816429
  X"FF53", -- mem(A79) = -0,002627208017236
  X"FF73", -- mem(A80) = -0,00214679032613268
  X"FF95", -- mem(A81) = -0,0016218413607925
  X"FFBB", -- mem(A82) = -0,00105280860114309
  X"FFE3", -- mem(A83) = -0,000440415747913956
  X"000E", -- mem(A84) = 0,000214348841593246
  X"003B", -- mem(A85) = 0,000910212246140831
  X"006B", -- mem(A86) = 0,00164562954448378
  X"009E", -- mem(A87) = 0,00241878466850675
  X"00D3", -- mem(A88) = 0,00322758294957264
  X"010A", -- mem(A89) = 0,00406967719689579
  X"0143", -- mem(A90) = 0,00494245190402161
  X"017E", -- mem(A91) = 0,00584306053996237
  X"01BB", -- mem(A92) = 0,00676841032562725
  X"01F9", -- mem(A93) = 0,0077151960908742
  X"0238", -- mem(A94) = 0,00867990633312393
  X"0279", -- mem(A95) = 0,00965884386650041
  X"02B9", -- mem(A96) = 0,0106481450039346
  X"02FB", -- mem(A97) = 0,0116437993071172
  X"033C", -- mem(A98) = 0,0126416752627509
  X"037D", -- mem(A99) = 0,0136375336043661
  X"03BE", -- mem(A100) = 0,0146270693199103
  X"03FE", -- mem(A101) = 0,0156059169605172
  X"043D", -- mem(A102) = 0,0165696934074244
  X"047B", -- mem(A103) = 0,0175140124354336
  X"04B8", -- mem(A104) = 0,0184345177588436
  X"04F2", -- mem(A105) = 0,0193269121662617
  X"052B", -- mem(A106) = 0,0201869747913066
  X"0561", -- mem(A107) = 0,0210106033949866
  X"0594", -- mem(A108) = 0,021793822063175
  X"05C4", -- mem(A109) = 0,0225328251194889
  X"05F2", -- mem(A110) = 0,0232239869415944
  X"061B", -- mem(A111) = 0,0238638992862979
  X"0642", -- mem(A112) = 0,0244493809839418
  X"0664", -- mem(A113) = 0,0249775077650079
  X"0683", -- mem(A114) = 0,0254456290995872
  X"069E", -- mem(A115) = 0,025851381584397
  X"06B4", -- mem(A116) = 0,0261927156120729
  X"06C6", -- mem(A117) = 0,026467893094339
  X"06D4", -- mem(A118) = 0,026675516869461
  X"06DD", -- mem(A119) = 0,0268145235502832
  X"06E1", -- mem(A120) = 0,0268842055657813
  X"06E1", -- mem(A121) = 0,0268842055657813
  X"06DD", -- mem(A122) = 0,0268145235502832
  X"06D4", -- mem(A123) = 0,026675516869461
  X"06C6", -- mem(A124) = 0,026467893094339
  X"06B4", -- mem(A125) = 0,0261927156120729
  X"069E", -- mem(A126) = 0,025851381584397
  X"0683", -- mem(A127) = 0,0254456290995872
  X"0664", -- mem(A128) = 0,0249775077650079
  X"0642", -- mem(A129) = 0,0244493809839418
  X"061B", -- mem(A130) = 0,0238638992862979
  X"05F2", -- mem(A131) = 0,0232239869415944
  X"05C4", -- mem(A132) = 0,0225328251194889
  X"0594", -- mem(A133) = 0,021793822063175
  X"0561", -- mem(A134) = 0,0210106033949866
  X"052B", -- mem(A135) = 0,0201869747913066
  X"04F2", -- mem(A136) = 0,0193269121662617
  X"04B8", -- mem(A137) = 0,0184345177588436
  X"047B", -- mem(A138) = 0,0175140124354336
  X"043D", -- mem(A139) = 0,0165696934074244
  X"03FE", -- mem(A140) = 0,0156059169605172
  X"03BE", -- mem(A141) = 0,0146270693199103
  X"037D", -- mem(A142) = 0,0136375336043661
  X"033C", -- mem(A143) = 0,0126416752627509
  X"02FB", -- mem(A144) = 0,0116437993071172
  X"02B9", -- mem(A145) = 0,0106481450039346
  X"0279", -- mem(A146) = 0,00965884386650041
  X"0238", -- mem(A147) = 0,00867990633312393
  X"01F9", -- mem(A148) = 0,0077151960908742
  X"01BB", -- mem(A149) = 0,00676841032562725
  X"017E", -- mem(A150) = 0,00584306053996237
  X"0143", -- mem(A151) = 0,00494245190402161
  X"010A", -- mem(A152) = 0,00406967719689579
  X"00D3", -- mem(A153) = 0,00322758294957264
  X"009E", -- mem(A154) = 0,00241878466850675
  X"006B", -- mem(A155) = 0,00164562954448378
  X"003B", -- mem(A156) = 0,000910212246140831
  X"000E", -- mem(A157) = 0,000214348841593246
  X"FFE3", -- mem(A158) = -0,000440415747913956
  X"FFBB", -- mem(A159) = -0,00105280860114309
  X"FF95", -- mem(A160) = -0,0016218413607925
  X"FF73", -- mem(A161) = -0,00214679032613268
  X"FF53", -- mem(A162) = -0,002627208017236
  X"FF37", -- mem(A163) = -0,00306290894816429
  X"FF1D", -- mem(A164) = -0,00345396875335889
  X"FF06", -- mem(A165) = -0,0038007026511583
  X"FEF3", -- mem(A166) = -0,00410367271627798
  X"FEE2", -- mem(A167) = -0,0043636636512899
  X"FED3", -- mem(A168) = -0,00458167039531877
  X"FEC8", -- mem(A169) = -0,00475889570663942
  X"FEBF", -- mem(A170) = -0,00489671178382397
  X"FEB8", -- mem(A171) = -0,00499667755645861
  X"FEB4", -- mem(A172) = -0,00506048149787073
  X"FEB2", -- mem(A173) = -0,0050899675300111
  X"FEB2", -- mem(A174) = -0,00508708333639423
  X"FEB4", -- mem(A175) = -0,00505387509139222
  X"FEB8", -- mem(A176) = -0,00499247327398246
  X"FEBE", -- mem(A177) = -0,00490507014977938
  X"FEC5", -- mem(A178) = -0,00479389935618745
  X"FECE", -- mem(A179) = -0,004661223153316
  X"FED8", -- mem(A180) = -0,00450932118459746
  X"FEE3", -- mem(A181) = -0,00434045401858865
  X"FEEF", -- mem(A182) = -0,00415687914875703
  X"FEFC", -- mem(A183) = -0,00396080625689552
  X"FF0A", -- mem(A184) = -0,00375440536325517
  X"FF18", -- mem(A185) = -0,00353977941381046
  X"FF26", -- mem(A186) = -0,00331895035035988
  X"FF35", -- mem(A187) = -0,00309388163147455
  X"FF44", -- mem(A188) = -0,00286640623694068
  X"FF53", -- mem(A189) = -0,00263828709212596
  X"FF62", -- mem(A190) = -0,00241115761968007
  X"FF70", -- mem(A191) = -0,00218654338994281
  X"FF7F", -- mem(A192) = -0,00196584098315754
  X"FF8D", -- mem(A193) = -0,00175034293294687
  X"FF9B", -- mem(A194) = -0,00154119322655691
  X"FFA8", -- mem(A195) = -0,00133942150087028
  X"FFB4", -- mem(A196) = -0,00114593048250338
  X"FFC1", -- mem(A197) = -0,000961489229025817
  X"FFCC", -- mem(A198) = -0,000786758526926491
  X"FFD7", -- mem(A199) = -0,000622245244910659
  X"FFE1", -- mem(A200) = -0,00046837665772445
  X"FFEA", -- mem(A201) = -0,000325432202961925
  X"FFF3", -- mem(A202) = -0,000193587399621588
  X"FFFB", -- mem(A203) = -7,29493426174901E-05
  X"0002", -- mem(A204) = 3,65225417273913E-05
  X"0008", -- mem(A205) = 0,000134921514874078
  X"000E", -- mem(A206) = 0,000222443384258505
  X"0013", -- mem(A207) = 0,000299335869329561
  X"0018", -- mem(A208) = 0,000365954198445497
  X"001B", -- mem(A209) = 0,000422660047205058
  X"001E", -- mem(A210) = 0,000469925491451767
  X"0021", -- mem(A211) = 0,00050821343574349
  X"0023", -- mem(A212) = 0,000538073861900304
  X"0024", -- mem(A213) = 0,000560044620486117
  X"0025", -- mem(A214) = 0,000574688639465408
  X"0026", -- mem(A215) = 0,00058265572366315
  X"0026", -- mem(A216) = 0,000584487717924256
  X"0026", -- mem(A217) = 0,000580814114668601
  X"0025", -- mem(A218) = 0,000572241709785608
  X"0024", -- mem(A219) = 0,000559329327434486
  X"0023", -- mem(A220) = 0,000542673488164318
  X"0022", -- mem(A221) = 0,000522832192503619
  X"0020", -- mem(A222) = 0,000500356402770411
  X"001F", -- mem(A223) = 0,00047571587913539
  X"001D", -- mem(A224) = 0,000449453667631933
  X"001B", -- mem(A225) = 0,000421962671475817
  X"0019", -- mem(A226) = 0,000393764380603094
  X"0017", -- mem(A227) = 0,00036505315389209
  X"0016", -- mem(A228) = 0,000336384341656877
  X"0014", -- mem(A229) = 0,00030793593714325
  X"0012", -- mem(A230) = 0,000279962554194093
  X"0010", -- mem(A231) = 0,000252911486259129
  X"000E", -- mem(A232) = 0,000226791245218498
  X"000D", -- mem(A233) = 0,000201821969265627
  X"000B", -- mem(A234) = 0,000178155643529953
  X"000A", -- mem(A235) = 0,000155968483382642
  X"0008", -- mem(A236) = 0,000135248483153016
  X"0007", -- mem(A237) = 0,000116068950190736
  X"0006", -- mem(A238) = 9,84452601078052E-05
  X"0005", -- mem(A239) = 8,24589475370423E-05
  X"0004", -- mem(A240) = 6,80644238118407E-05
  X"0003", -- mem(A241) = 5,52345897316551E-05
  X"0007",
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
			); -- mem(A242) = 0,000113538734273173
  
  
		Band_B<= (
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
			
		); -- mem(B242) = 0




			
					


		Band_C<= (
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
	);-- mem(C242) = 0
  
		Band_D<= (
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
			); -- mem(D242) = 0



  



	end Filter_adress;