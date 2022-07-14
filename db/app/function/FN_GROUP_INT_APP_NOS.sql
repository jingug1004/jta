CREATE OR REPLACE FUNCTION FN_GROUP_INT_APP_NOS
/**
 * 그룹별 국내출원번호 반환
 */
(
    I_GRP_ID                    IN  TB_MAPP_REF_ID.GRP_ID%TYPE
)
RETURN VARCHAR2 IS R_TEXT VARCHAR2(4000);

    CURSOR C1 IS
    SELECT B.APP_NO
    FROM   TB_MAPP_REF_ID A
         , TB_APP_MST B
    WHERE  A.GRP_ID = I_GRP_ID
    AND    A.MAPP_KIND = 'G'
    AND    A.REF_ID = B.REF_ID
    ;

BEGIN

    FOR R1 IN C1 LOOP
        IF LENGTH(R_TEXT) > 0 THEN
            R_TEXT := R_TEXT || ',';
        END IF;
        R_TEXT := R_TEXT || R1.APP_NO;
    END LOOP;

    RETURN R_TEXT;

END;
