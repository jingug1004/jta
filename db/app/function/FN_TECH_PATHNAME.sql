CREATE OR REPLACE FUNCTION FN_TECH_PATHNAME
(
    I_TECH_CODE                 IN  TB_COM_TECH_CLS.TECH_CODE%TYPE
  , I_DELIMITER                 IN  VARCHAR2
)
RETURN VARCHAR2 IS R_TEXT VARCHAR2(4000);

    V_TECH_CODE                 TB_COM_TECH_CLS.TECH_CODE%TYPE;
    V_TECH_NAME                 TB_COM_TECH_CLS.TECH_HNAME%TYPE;

BEGIN

    V_TECH_CODE := I_TECH_CODE;

    WHILE V_TECH_CODE IS NOT NULL LOOP
        BEGIN
            SELECT PRIOR_TECH_CODE
                 , TECH_HNAME
            INTO   V_TECH_CODE
                 , V_TECH_NAME
            FROM   TB_COM_TECH_CLS
            WHERE  TECH_CODE = V_TECH_CODE
            ;
            EXCEPTION WHEN NO_DATA_FOUND THEN EXIT;
        END;
        IF R_TEXT IS NOT NULL THEN
            R_TEXT := I_DELIMITER || R_TEXT;
        END IF;
        R_TEXT := V_TECH_NAME || R_TEXT;
    END LOOP;

    RETURN R_TEXT;

END;