----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:17:36 01/10/2023 
-- Design Name: 
-- Module Name:    xdd - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DETECTOR IS 
	PORT( CLK :IN STD_LOGIC;
	CLR, ENB: IN STD_LOGIC;						
	AUX_ENTRADA: INOUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	AUX_ENTRADA1: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	--AUX_CLK1: OUT STD_LOGIC;
	AUX_CLK: in STD_LOGIC;
	AN: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	SALIDA: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END DETECTOR;

ARCHITECTURE COMPORTAMENTAL OF DETECTOR IS 

TYPE ESTADOS IS(A, B, C, D, E, F, G);		  
--attribute ENUM_ENCODING: STRING;
--ATTRIBUTE enum_encoding OF ESTADOS: TYPE IS
--"0000" & --A--	  
--"0001" & --B--
--"0011" & --C--
--"0010" & --D--
--"0110" & --E--
--"0111" & --F--
--"1111" ; --G--
SIGNAL EDO, NEXT_EDO: ESTADOS;
--SIGNAL AUX_CLK: STD_LOGIC;
--SIGNAL CONTADOR: INTEGER RANGE 0 TO 50000000 := 0;
BEGIN 
	AN<="0111";
--	
--	DIVISOR_FRECUENCIA: PROCESS (CLR, CLK) BEGIN
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
--	AUX_CLK1 <= AUX_CLK;

PROCESS (CLR, AUX_CLK)
BEGIN 
	IF(CLR = '1') THEN
		EDO <= A;						   						   
	ELSIF(AUX_CLK'EVENT AND AUX_CLK = '1') THEN
		EDO <= NEXT_EDO;
	END IF;
END PROCESS;	   

PROCESS(AUX_CLK, CLR) BEGIN
		IF (CLR ='1') THEN
			AUX_ENTRADA <= AUX_ENTRADA1;
		ELSIF (AUX_CLK'EVENT AND AUX_CLK = '1') THEN 
				AUX_ENTRADA(5 DOWNTO 0) <= AUX_ENTRADA(6 DOWNTO 1);
				AUX_ENTRADA(6) <= '0';
			
		END IF;
END PROCESS;

PROCESS (AUX_ENTRADA(0), EDO)
BEGIN 
	CASE EDO IS WHEN 
		A => IF AUX_ENTRADA(0) = '0' THEN
			NEXT_EDO <= C;
		ELSIF AUX_ENTRADA(0) = '1' THEN
			NEXT_EDO <= B;
		END IF;
		WHEN
		B => IF AUX_ENTRADA(0) = '0' THEN 
			NEXT_EDO <= C;
		ELSIF AUX_ENTRADA(0) = '1' THEN
			NEXT_EDO  <= F;
		END IF;	
		WHEN
		C => IF AUX_ENTRADA(0) = '0' THEN 
			NEXT_EDO <= D;
		ELSIF AUX_ENTRADA(0) ='1' THEN
			NEXT_EDO <= B;
		END IF;
		WHEN
		D => IF AUX_ENTRADA(0) = '0' THEN 
			NEXT_EDO <= E;
		ELSIF AUX_ENTRADA(0) ='1' THEN
			NEXT_EDO <= B;
		END IF;			 
		WHEN
		E => IF AUX_ENTRADA(0) = '0' THEN 
			NEXT_EDO <= E;
		ELSIF AUX_ENTRADA(0) ='1' THEN
			NEXT_EDO <= B;
		END IF;			  
		WHEN
		F => IF AUX_ENTRADA(0) = '0' THEN 
			NEXT_EDO <= C;
		ELSIF AUX_ENTRADA(0) ='1' THEN
			NEXT_EDO <= G;
		END IF;			  
		WHEN
		G => IF AUX_ENTRADA(0) = '0' THEN 
			NEXT_EDO <= C;
		ELSIF AUX_ENTRADA(0) ='1' THEN
			NEXT_EDO <= G;
		END IF;		   
		WHEN OTHERS => NULL;
	END CASE;
END PROCESS;
--A B C D E F G--
SALIDA <= 
	"0001001" WHEN (EDO = E AND AUX_ENTRADA(0) = '0') ELSE	--D--
	"0001001" WHEN (EDO = G AND AUX_ENTRADA(0) = '1' ) ELSE
	"0000000" WHEN (EDO = A) ELSE
	"0110000";
END COMPORTAMENTAL;
