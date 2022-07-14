CREATE OR REPLACE FUNCTION FN_USER_NAME
(
    I_USER_ID                   IN  TB_USR_MST.USER_ID%TYPE
)
RETURN VARCHAR2 IS R_TEXT TB_USR_MST.EMP_HNAME%TYPE;

BEGIN

    BEGIN
        SELECT EMP_HNAME
        INTO   R_TEXT
        FROM   TB_USR_MST
        WHERE  USER_ID = I_USER_ID
        ;
        EXCEPTION WHEN NO_DATA_FOUND THEN BEGIN
            SELECT EMP_HNAME
            INTO   R_TEXT
            FROM   TB_USR_MST
            WHERE  USER_ID = (SELECT USER_ID
                              FROM   TB_USR_PATENT
                              WHERE  EMP_NO = I_USER_ID
                             )
            ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                RETURN I_USER_ID;
        END;
    END;

    RETURN R_TEXT;

END;
