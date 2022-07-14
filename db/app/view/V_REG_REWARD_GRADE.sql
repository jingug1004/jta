CREATE OR REPLACE VIEW V_REG_REWARD_GRADE AS
SELECT REF_ID
     , EXE_DIV
     , PJT_TYPE
     , DECODE(PJT_TYPE, 'S', DECODE(EXE_DIV, '1','1', '2','2', '3','3')
                      , 'A', DECODE(EXE_DIV, '1','2', '2','3', '3','4')
                      , 'B', DECODE(EXE_DIV, '1','3', '2','4')
             ) REWARD_GRADE
FROM   TB_EVAL_COM_REG_RESULT;
