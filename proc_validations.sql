CREATE OR REPLACE PROCEDURE PDBADMIN.VALIADTIONS(
v_container_nr IN VARCHAR2,

v_bl IN VARCHAR2,
v_equipment IN VARCHAR2,
v_pol IN VARCHAR2,
v_pld IN VARCHAR2,
v_cuenta IN VARCHAR2,
v_ma IN VARCHAR2,
v_intercomunicador IN VARCHAR2,
v_departure_date IN VARCHAR2,
v1_p OUT NUMBER
)
AS

l_date DATE;
BEGIN

	v1_p := 1;
	IF (v_container_nr IS NOT NULL) THEN
		dbms_output.put_line('v_container_nr No nulo');
		dbms_output.put_line(v_container_nr);
		--IF (v_container_nr = ''  ) THEN
		--	dbms_output.put_line('v_container_nr No pero es empty');
	--		v_container_nr := '';
		--END IF;	
	
		IF (v_departure_date IS NOT NULL  ) THEN
			
			
		--	SELECT TO_CHAR(TO_DATE(v_departure_date,'YYYY.MM.DD'),'YYYY/MM/DD') INTO l_date  FROM DUAL;
			dbms_output.put_line('v_departure_date No nulo');
			dbms_output.put_line(l_date);
		
			IF (v_bl IS NOT NULL ) THEN
				dbms_output.put_line('v_bl No nulo');
		 
				MERGE INTO PDBADMIN.SF_IN_CONTMAR_OT USING dual ON (bl = v_bl)
				    WHEN MATCHED THEN
				        UPDATE SET CONTAINER_NR = v_container_nr,
				     
				        EQUIPMENT = v_equipment,
				        POL = v_pol,
				        PLD = v_pld,
				        CUENTA_CENTRO_DE_COSTOS = v_cuenta,
				        MA = v_ma,
				        INTERCOM = v_intercomunicador,
				        DEPARTURE_DATE = l_date
				    WHEN NOT MATCHED THEN
				        INSERT (CONTAINER_NR, BL, EQUIPMENT, POL, PLD, CUENTA_CENTRO_DE_COSTOS, MA, INTERCOM, DEPARTURE_DATE)
				        values( v_container_nr, v_bl, v_equipment, v_pol, v_pld, v_cuenta, v_ma, v_intercomunicador, l_date);
			END IF;	        
					--INSERT INTO PDBADMIN.SF_IN_CONTMAR_OT
						--( CONTAINER_NR, DEPARTURE_DATE, BL, EQUIPMENT, POL, PLD, CUENTA_CENTRO_DE_COSTOS, MA, INTERCOM)
					--	VALUES( v_container_nr, v_departure_date, v_bl, '', '', '', '', '', '');
		END IF;			
	ELSE
		v1_p := 0;
	END IF;
		dbms_output.put_line('END');

END VALIADTIONS;