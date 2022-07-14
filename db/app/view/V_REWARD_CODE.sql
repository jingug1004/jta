CREATE OR REPLACE VIEW V_REWARD_CODE AS
SELECT A.RIGHT_DIV
     , A.RIGHT_ORD
     , A.INOUT_DIV
     , A.INOUT_ORD
     , A.REWARD_DIV
     , A.REWARD_ORD
     , A.INV_GRADE
     , A.INV_GRADE_ORD
     , B.REWARD_PRICE
FROM   (SELECT A.RIGHT_DIV
             , A.RIGHT_ORD
             , B.INOUT_DIV
             , B.INOUT_ORD
             , C.REWARD_DIV
             , C.REWARD_ORD
             , D.INV_GRADE
             , D.INV_GRADE_ORD
        FROM   (SELECT CODE_VALUE_ID RIGHT_DIV
                     , DISP_ORD RIGHT_ORD
                FROM   TB_COM_CODE_VALUE
                WHERE  CODE_GRP = (SELECT CODE_GRP FROM TB_COM_CODE_GRP WHERE CODE_GRP_ID = 'RIGHT_DIV')
                AND    USE_YN = '1'
               ) A
             , (SELECT CODE_VALUE_ID INOUT_DIV
                     , DISP_ORD INOUT_ORD
                FROM   TB_COM_CODE_VALUE
                WHERE  CODE_GRP = (SELECT CODE_GRP FROM TB_COM_CODE_GRP WHERE CODE_GRP_ID = 'INOUT_DIV')
                AND    USE_YN = '1'
               ) B
             , (SELECT CODE_VALUE_ID REWARD_DIV
                     , DISP_ORD REWARD_ORD
                FROM   TB_COM_CODE_VALUE
                WHERE  CODE_GRP = (SELECT CODE_GRP FROM TB_COM_CODE_GRP WHERE CODE_GRP_ID = 'REWARD_DIV')
                AND    USE_YN = '1'
               ) C
             , (SELECT 'N' INV_GRADE
                     , 0 INV_GRADE_ORD
                FROM   DUAL
                UNION ALL
                SELECT CODE_VALUE_ID INV_GRADE
                     , DISP_ORD INV_GRADE_ORD
                FROM   TB_COM_CODE_VALUE
                WHERE  CODE_GRP = (SELECT CODE_GRP FROM TB_COM_CODE_GRP WHERE CODE_GRP_ID = 'INV_GRADE')
                AND    USE_YN = '1'
               ) D
       ) A
     , TB_COST_MGT_REWARD B
WHERE  A.RIGHT_DIV = B.RIGHT_DIV(+)
AND    A.INOUT_DIV = B.INOUT_DIV(+)
AND    A.REWARD_DIV = B.REWARD_DIV(+)
AND    A.INV_GRADE = B.INV_GRADE(+)
ORDER BY A.RIGHT_ORD, A.INOUT_DIV DESC, A.REWARD_ORD, A.INV_GRADE_ORD;
