CREATE OR REPLACE FUNCTION FN_STATE_NAMES
(
     I_APP_NO           IN TB_APP_MST.APP_NO%TYPE
   , I_REG_NO           IN TB_APP_MST.REG_NO%TYPE
   , I_ABD_YN           IN TB_APP_MST.ABD_YN%TYPE
)
RETURN VARCHAR2 IS R_TEXT VARCHAR2(6);

BEGIN

     IF (I_APP_NO IS NULL AND I_ABD_YN = 0) THEN
        R_TEXT := '출원전';
     ELSIF (I_APP_NO IS NOT NULL AND I_ABD_YN = 0 AND I_REG_NO IS NULL) THEN
        R_TEXT := '출원';
     ELSIF (I_REG_NO IS NOT NULL AND I_ABD_YN = 0) THEN
        R_TEXT := '등록';
     ELSIF (I_ABD_YN = 1) THEN
        R_TEXT := '포기';
     END IF;

     RETURN R_TEXT;

END;
