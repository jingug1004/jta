CREATE OR REPLACE FUNCTION FN_IS_NUMBER
(
    I_VALUE                     IN  VARCHAR2
)
RETURN CHAR IS R_TEXT CHAR(1);

    V_VALUE                     VARCHAR2(4000);

BEGIN

    SELECT TRANSLATE(TRIM(I_VALUE), ' +.0123456789', ' ') INTO V_VALUE FROM DUAL;

    IF V_VALUE IS NULL THEN
        R_TEXT := '1';
    ELSE
        R_TEXT := '0';
    END IF;

    RETURN R_TEXT;

END;