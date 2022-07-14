CREATE OR REPLACE FUNCTION FN_REF_NO
(
    I_REF_ID                    IN  TB_APP_MST.REF_ID%TYPE
)
RETURN VARCHAR2 IS R_TEXT TB_APP_MST.REF_NO%TYPE;

BEGIN

    BEGIN
        SELECT REF_NO
        INTO   R_TEXT
        FROM   TB_APP_MST
        WHERE  REF_ID = I_REF_ID
        ;
        EXCEPTION WHEN NO_DATA_FOUND THEN BEGIN
            SELECT REF_NO
            INTO   R_TEXT
            FROM   TB_APP_INT_CONSULT
            WHERE  REF_ID = I_REF_ID
            ;
            EXCEPTION WHEN NO_DATA_FOUND THEN BEGIN
                SELECT REF_NO
                INTO   R_TEXT
                FROM   TB_APP_INT_REQ
                WHERE  REF_ID = I_REF_ID
                ;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                    RETURN I_REF_ID;
            END;
        END;
    END;

    RETURN R_TEXT;

END;
