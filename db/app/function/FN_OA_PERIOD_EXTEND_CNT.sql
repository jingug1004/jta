CREATE OR REPLACE FUNCTION FN_OA_PERIOD_EXTEND_CNT
/**
 * OA 기간연장 횟수 반환
 */
(
    I_REF_ID                    IN  TB_PAPER_LIST.REF_ID%TYPE
  , I_OA_SEQ                    IN  TB_PAPER_LIST.OA_SEQ%TYPE
)
RETURN NUMBER IS R_TEXT NUMBER;

BEGIN

    SELECT COUNT(1)
    INTO   R_TEXT
    FROM   TB_PAPER_LIST
    WHERE  REF_ID = I_REF_ID
    AND    LIST_SEQ = (SELECT MAX(LIST_SEQ)
                       FROM   TB_PAPER_LIST A
                       WHERE  A.REF_ID = I_REF_ID
                       AND    A.OA_SEQ = I_OA_SEQ
                       AND    (A.PAPER_CODE, A.PAPER_SUBCODE) IN
                              (SELECT PAPER_CODE, PAPER_SUBCODE
                               FROM   TB_PAPER_MGT_EVENT_LIST
                               WHERE  EVENT_SEQ = (SELECT EVENT_SEQ FROM TB_PAPER_MGT_EVENT WHERE EVENT_ID = 'OA_PERIOD_EXTEND')
                              )
                      )
    ;

    RETURN R_TEXT;

    EXCEPTION
        WHEN OTHERS THEN
            RETURN -1;

END;
