LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DISPMULT IS 
	PORT( 
	--CLK :IN STD_LOGIC;
	CLR: IN STD_LOGIC;						
	--AUX_CLK1: INOUT STD_LOGIC;
	AUX_CLK: IN STD_LOGIC;
	AN: INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	SALIDA: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END DISPMULT; 

ARCHITECTURE COMPORTAMENTAL OF DISPMULT IS 

TYPE ESTADOS IS(A, B, C, D);
SIGNAL EDO, NEXT_EDO: ESTADOS;
--SIGNAL AUX_CLK: STD_LOGIC;
--SIGNAL CONTADOR: INTEGER RANGE 0 TO 50000000 := 0; 
BEGIN 
--	DIVISOR_FRECUENCIA1: PROCESS (CLR, CLK) BEGIN
--		IF (CLR= '1') THEN
--			AUX_CLK <= '0';
--			CONTADOR <= 0;
--		ELSIF RISING_EDGE(CLK) THEN
--			IF(CONTADOR = 50000000) THEN
--				AUX_CLK <= NOT (AUX_CLK);
--				CONTADOR <= 0;
--			ELSE
--				CONTADOR <= CONTADOR + 1;
--			END IF;
--		END IF;
--	END PROCESS;	 

PROCESS(CLR, AUX_CLK)
BEGIN
	IF (CLR ='1') THEN
		AN <= "0001"; 
		EDO <= A;
	ELSIF (AUX_CLK'EVENT AND AUX_CLK = '1') THEN 
		EDO <= NEXT_EDO;
		AN(3 DOWNTO 1) <= AN(2 DOWNTO 0);
		AN(0) <= AN(3);
	END IF;
END PROCESS;

PROCESS (EDO)
BEGIN 
	CASE EDO IS WHEN 
		A => NEXT_EDO <= B;
		WHEN
		B => 
		NEXT_EDO <= C;

		WHEN
		C => 
		NEXT_EDO <= D;
   
		WHEN
		D =>
		NEXT_EDO <= A;

		WHEN OTHERS => NULL;
	END CASE;
END PROCESS;

SALIDA <= 
	"1001000" WHEN (EDO = A) ELSE
	"0000001" WHEN (EDO = B) ELSE
	"1110001" WHEN (EDO = C) ELSE
	"0001000" WHEN (EDO = C) ELSE
	"1111111";
END COMPORTAMENTAL;
