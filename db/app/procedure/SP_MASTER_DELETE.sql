CREATE OR REPLACE PROCEDURE SP_MASTER_DELETE
/***************************************************
 출원마스터 삭제
***************************************************/
(
    I_REF_ID                IN  TB_APP_MST.REF_ID%TYPE
)
IS

BEGIN

    /***************************************************
     업무내역
    ***************************************************/
    DELETE FROM TB_BIZ_COM_HIST WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_BIZ_COM_STEP WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_BIZ_COM_MST WHERE REF_ID = I_REF_ID;

    /***************************************************
     평가내역
    ***************************************************/
    DELETE FROM TB_EVAL_COM_ITEM WHERE EVAL_ID IN (SELECT EVAL_ID FROM TB_EVAL_COM_MST WHERE REF_ID = I_REF_ID);
    DELETE FROM TB_EVAL_COM_MST WHERE REF_ID = I_REF_ID;

    /***************************************************
     비용내역
    ***************************************************/
    DELETE FROM TB_COST_MST_REWARD WHERE COST_SEQ IN (SELECT COST_SEQ FROM TB_COST_MST WHERE REF_ID = I_REF_ID);
    DELETE FROM TB_COST_REMINDER WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_COST_MST_ANNUAL WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_COST_MST WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_COST_EXT_LETTER WHERE REF_ID = I_REF_ID;

    /***************************************************
     진행서류
    ***************************************************/
    DELETE FROM TB_OA_REJECT_EXAM_INT WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_OA_REJECT_EXAM_EXT WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_OA_HIST WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_PAPER_LIST WHERE REF_ID = I_REF_ID;

    /***************************************************
     사무소 요청사항
    ***************************************************/
    DELETE FROM TB_APP_OFFICE_REQ WHERE REF_ID = I_REF_ID;

    /***************************************************
     맵핑내역
    ***************************************************/
    DELETE FROM TB_MAPP_PJT WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_MAPP_TECH_CLS WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_MAPP_TMARK_CLS WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_MAPP_COUNTRY WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_MAPP_PRSCH WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_MAPP_INVENTOR WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_MAPP_REF_ID WHERE REF_ID = I_REF_ID;

    /***************************************************
     출원의뢰
    ***************************************************/
    DELETE FROM TB_APP_INT_REQ_PAT WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_INT_REQ_DESIGN WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_INT_REQ_TMARK WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_INT_REQ WHERE REF_ID = I_REF_ID;

    /***************************************************
     출원품의
    ***************************************************/
    DELETE FROM TB_APP_INT_CONSULT_PAT WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_INT_CONSULT_DESIGN WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_INT_CONSULT_TMARK WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_INT_CONSULT WHERE REF_ID = I_REF_ID;

    /***************************************************
     출원마스터
    ***************************************************/
    DELETE FROM TB_APP_REWARD WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_MST_INT WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_MST_EXT WHERE REF_ID = I_REF_ID;
    DELETE FROM TB_APP_MST WHERE REF_ID = I_REF_ID;

END;
