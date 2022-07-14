CREATE OR REPLACE FUNCTION FN_PAPER_STEP
(
    I_REF_ID                    IN  TB_PAPER_LIST.REF_ID%TYPE
)
RETURN VARCHAR2 IS R_TEXT TB_PAPER_MGT_MST.PAPER_STEP%TYPE;

BEGIN

    SELECT PAPER_STEP
    INTO   R_TEXT
    FROM   TB_PAPER_MGT_MST A
         , TB_PAPER_LIST B
    WHERE  A.PAPER_CODE = B.PAPER_CODE
    AND    B.REF_ID = I_REF_ID
    AND    B.LIST_SEQ = (SELECT MAX(T1.LIST_SEQ) LIST_SEQ
                         FROM   TB_PAPER_LIST T1
                              , TB_PAPER_MGT_MST T2
                         WHERE  T1.REF_ID = I_REF_ID
                         AND    T1.PAPER_CODE = T2.PAPER_CODE
                         AND    T2.PAPER_STEP != 'ETC'
                        )
    ;

    RETURN R_TEXT;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;

END;
