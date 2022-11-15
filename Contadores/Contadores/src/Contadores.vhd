LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CONTADOR IS
	PORT(
		CLK, CLR: IN STD_LOGIC;
		SEL: IN STD_LOGIC;
		Q: INOUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		QN: INOUT STD_LOGIC_VECTOR (2 DOWNTO 0) 
		);
	--ATTRIBUTE PIN_NUMBERS OF SERIES: ENTITY IS "CLK:1, CLR:2,D(3):3, D(2):4, D(1):5, D(0):6, SEL(1):7, SEL(0):8, ";
END ENTITY;

ARCHITECTURE A_CONTADOR OF CONTADOR IS
BEGIN 
	PROCESS(CLK, CLR) BEGIN
		IF (CLR ='1') THEN
			Q <= "100";
			QN <= "011";
		ELSIF (CLK'EVENT AND CLK = '1') THEN 
			IF (SEL = '0') THEN 
				Q <= Q;
				QN <= QN;
			ELSE
				Q(2) <= NOT(Q(1));
				Q(2) <= Q(1);
				Q(1) <= NOT(Q(0));
				Q(1) <= Q(0);
				Q(0) <= NOT(Q(2));
				Q(0) <= Q(2);
			END IF;
		END IF;
	END PROCESS;
END A_CONTADOR;