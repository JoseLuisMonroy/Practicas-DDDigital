LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SERIES IS
	PORT(
		D, CLK, CLR: IN STD_LOGIC;
		Q: OUT STD_LOGIC
		);

END ENTITY;

ARCHITECTURE A_SERIES OF SERIES IS
SIGNAL Q1, Q2: STD_LOGIC;
BEGIN 
	PROCESS(CLK, CLR) BEGIN
		IF (CLR ='1') THEN
			Q1<= '0';
			Q2<= '0';
			Q<= '0';
		ELSIF (CLK'EVENT AND CLK = '1') THEN 
			Q1<= D;
			Q2<= Q1;
			Q<= Q2;
		END IF;
	END PROCESS;
END A_SERIES;