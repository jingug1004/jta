CREATE OR REPLACE FUNCTION FN_PRIORITY_APP_DATES
(
    I_REF_ID                    IN  TB_APP_MST.REF_ID%TYPE
)
RETURN VARCHAR2 IS R_TEXT VARCHAR2(4000);

    CURSOR C1 IS
    SELECT T1.APP_DATE
    FROM   TB_APP_MST T1
         , TB_APP_MST_INT T2
    WHERE  T2.PRIORITY_REF_ID = I_REF_ID
    AND    T1.REF_ID = T2.REF_ID
    ORDER BY APP_DATE, APP_NO
    ;

BEGIN

    FOR R1 IN C1 LOOP
        IF LENGTH(R_TEXT) > 0 THEN
            R_TEXT := R_TEXT || ',';
        END IF;
        R_TEXT := R_TEXT || R1.APP_DATE;
    END LOOP;

    RETURN R_TEXT;

END;
