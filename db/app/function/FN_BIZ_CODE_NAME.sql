CREATE OR REPLACE FUNCTION FN_BIZ_CODE_NAME
(
    I_CODE_VALUE                IN  TB_BIZ_MGT_CODE.CODE_VALUE%TYPE
  , I_LANG_CODE                 IN  TB_BIZ_MGT_CODE.LANG_CODE%TYPE
  , I_DEFAULT_LANG_CODE         IN  TB_BIZ_MGT_CODE.LANG_CODE%TYPE
)
RETURN VARCHAR2 IS R_TEXT TB_BIZ_MGT_CODE.CODE_NAME%TYPE;

BEGIN

    SELECT CODE_NAME
    INTO   R_TEXT
    FROM   TB_BIZ_MGT_CODE
    WHERE  CODE_VALUE = I_CODE_VALUE
    AND    LANG_CODE = I_LANG_CODE
    ;

    RETURN R_TEXT;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            IF I_DEFAULT_LANG_CODE IS NOT NULL AND I_LANG_CODE <> I_DEFAULT_LANG_CODE THEN
                RETURN FN_BIZ_CODE_NAME(I_CODE_VALUE, I_DEFAULT_LANG_CODE, NULL);
            END IF;
            RETURN I_CODE_VALUE;

END;
