CREATE OR REPLACE VIEW V_INVENTOR_ALL AS
SELECT B.REF_ID
     , A.INV_USER
     , A.MAIN_INVENTOR_YN
     , A.IN_INVENTOR_YN
     , A.QUOTA_RATIO
FROM   TB_MAPP_INVENTOR A
     , (SELECT REF_ID GRP_ID
             , REF_ID
        FROM   TB_APP_MST_INT
        UNION
        SELECT GRP_ID
             , GRP_ID REF_ID
        FROM   TB_APP_EXT_GRP
        UNION
        SELECT GRP_ID
             , REF_ID
        FROM   TB_APP_MST_EXT
       ) B
WHERE  A.REF_ID = B.GRP_ID
/**
 * 발명자 뷰 : REF_ID 및 GRP_ID에 해당하는 모든 발명자
 */;
