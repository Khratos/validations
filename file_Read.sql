CREATE OR REPLACE PROCEDURE PDBADMIN.READ_FILES (
	p_filename IN VARCHAR2) 

IS 

      F UTL_FILE.FILE_TYPE;
      V_LINE VARCHAR2 (1000);     
      V_ENAME VARCHAR2(10);    
      V_DNAME VARCHAR2(14);
      CONTAINER_NR VARCHAR2(100);
 	  DEPARTURE_DATE VARCHAR2(100);
 	  EQUIPMENT VARCHAR2(100);
 	  BL  VARCHAR2(100);
 	  POL  VARCHAR2(100);
	  PLD  VARCHAR2(100);
	  CUENTA_CENTRO_DE_COSTOS VARCHAR2(100);
	  MA  VARCHAR2(100);
	  INTERCOM VARCHAR2(100);
	  p_ignore_headerlines number;
	  ids NUMBER;
BEGIN
    F := UTL_FILE.FOPEN ('USER_DIR', p_filename, 'R');
    IF UTL_FILE.IS_OPEN(F) THEN
      LOOP
        BEGIN
          UTL_FILE.GET_LINE(F, V_LINE, 100);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          
		 
		  CONTAINER_NR := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1);
       
          --DEPARTURE_DATE := REGEXP_SUBSTR(V_LINE, '[\d{4}/\d{2}/\d{2}^,]'+ 1, 2);
         --TO_CHAR(TO_DATE(REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2),'MM.DD.YYYY' ), 'YYYY/MM/DD');
          BL := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
          EQUIPMENT := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
          POL := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
          PLD := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5);
          CUENTA_CENTRO_DE_COSTOS := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 6);
          MA := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 7);
          INTERCOM := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 8);
          DEPARTURE_DATE := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 9); 
         
       	 dbms_output.put_line('BL');
		
       	 dbms_output.put_line(BL);
				 
          IF ( CONTAINER_NR != 'CONTAINER_NR') THEN
	          		
	          
					ids := 0;
					PDBADMIN.VALIADTIONS(CONTAINER_NR, BL, EQUIPMENT, POL, PLD, CUENTA_CENTRO_DE_COSTOS, MA, INTERCOM, DEPARTURE_DATE, ids);
				
		          	dbms_output.put_line('una vez');
				 
				    
					--		 INSERT INTO PDBADMIN.SF_IN_CONTMAR_OT(CONTAINER_NR, DEPARTURE_DATE, BL, EQUIPMENT, POL, PLD, CUENTA_CENTRO_DE_COSTOS, MA, INTERCOM) 
			        -- 		 VALUES(CONTAINER_NR, DEPARTURE_DATE, BL, EQUIPMENT, POL, PLD, CUENTA_CENTRO_DE_COSTOS, MA, INTERCOM);
			          
		END IF;	        
          --/INSERT INTO PDBADMIN.SF_IN_CONTMAR_OT(CONTAINER_NR, DEPARTURE_DATE, BL, EQUIPMENT, POL, PLD, CUENTA_CENTRO_DE_COSTOS, MA, INTERCOM) 
         --VALUES(CONTAINER_NR, DEPARTURE_DATE, BL, EQUIPMENT, POL, PLD, CUENTA_CENTRO_DE_COSTOS, MA, INTERCOM);
         -- COMMIT;        
         --END IF;
          EXCEPTION
        	WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
    END IF;
    UTL_FILE.FCLOSE(F);
  

END READ_FILES;