CREATE OR REPLACE FUNCTION FN_PAPER_CONFIRM_OWNER
/**
 * ���༭�� Ȯ����ü ��ȯ
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

    -- �繫�Ұ����� �ƴ� ��� Ȯ���� �ʿ� ����
    IF V_OFFICE_DISP_YN != '1' THEN
        RETURN NULL;
    END IF;

    -- Ư�������� �Է��� ���༭���� �繫�ҿ��� Ȯ��
    IF V_INPUT_OWNER = 'PAT' THEN
        R_TEXT := 'OFF';
    -- �������� ��� Ư�������� Ȯ��
    ELSE
        R_TEXT := 'PAT';
    END IF;

    RETURN R_TEXT;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN R_TEXT;

END;
