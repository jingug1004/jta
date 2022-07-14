CREATE OR REPLACE FUNCTION FN_PAPER_CONFIRM_OWNER
/**
 * 진행서류 확인주체 반환
 */
(
    I_REF_ID                    IN  TB_PAPER_LIST.REF_ID%TYPE
  , I_LIST_SEQ                  IN  TB_PAPER_LIST.LIST_SEQ%TYPE
)
RETURN VARCHAR2 IS R_TEXT VARCHAR2(3);

    V_OFFICE_DISP_YN            TB_PAPER_LIST.OFFICE_DISP_YN%TYPE;
    V_INPUT_OWNER               TB_PAPER_LIST.INPUT_OWNER%TYPE;

BEGIN

    SELECT OFFICE_DISP_YN
         , INPUT_OWNER
    INTO   V_OFFICE_DISP_YN
         , V_INPUT_OWNER
    FROM   TB_PAPER_LIST
    WHERE  REF_ID = I_REF_ID
    AND    LIST_SEQ = I_LIST_SEQ
    ;

    -- 사무소공개가 아닌 경우 확인할 필요 없음
    IF V_OFFICE_DISP_YN != '1' THEN
        RETURN NULL;
    END IF;

    -- 특허팀에서 입력한 진행서류는 사무소에서 확인
    IF V_INPUT_OWNER = 'PAT' THEN
        R_TEXT := 'OFF';
    -- 나머지는 모두 특허팀에서 확인
    ELSE
        R_TEXT := 'PAT';
    END IF;

    RETURN R_TEXT;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN R_TEXT;

END;
