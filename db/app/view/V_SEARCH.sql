CREATE OR REPLACE VIEW V_SEARCH AS
SELECT
/**
 * 검색 색인용 뷰
 */
       A.REF_ID "ID"
     , A.REF_NO "NO"
     , CASE WHEN A.ABD_YN = '1' THEN 'ABD' -- 포기
            WHEN A.APP_NO IS NULL THEN 'NON' -- 출원전
            WHEN A.APP_NO IS NOT NULL AND A.REG_NO IS NULL THEN 'APP' -- 출원
            WHEN A.APP_NO IS NOT NULL AND A.REG_NO IS NOT NULL THEN 'REG' -- 등록
       END "STATE" -- 출원/등록상태
     , A.KO_APP_TITLE "TL" -- 발명(고안)의 명칭
     , B.ABSTRACT "AB" -- 초록
     , B.CLAIM "CL" -- 청구범위
     , A.IPC_CLS_CODE "IPC" -- IPC
     , A.APP_NO "AN" -- 출원번호
     , A.PUB_NO "OPN" -- 공개번호
     , A.REG_NO "GN" -- 등록번호
     , FN_PRIORITY_APP_NOS(A.REF_ID) "RN" -- 우선권주장번호
     , A.APP_DATE "AD" -- 출원일자
     , A.PUB_DATE "OPD" -- 공개일자
     , A.REG_DATE "GD" -- 등록일자
     , FN_PRIORITY_APP_DATES(A.REF_ID) "RD" -- 우선권주장일자
     , FN_INVENTOR_NAMES(A.REF_ID) "IN" -- 발명자 이름
     , FN_OFFICE_NAME(A.OFFICE_CODE) "AG" -- 대리인 이름
     , A.APPDOC_FILE "FILE_ID"
     , DECODE(A.UPD_DATE, NULL, A.CRE_DATE, A.UPD_DATE) CHG_DATE
     , (SELECT
          SUBSTR(XMLAGG(XMLELEMENT(A,CHR(10) || FE.FILE_NAME_ORG)).EXTRACT('//text()'), 2)
       FROM   TB_COM_FILE FE
       WHERE  FE.FILE_ID = A.APPDOC_FILE) "FILE_NAME" -- 파일명 목록
     , (SELECT
          SUBSTR(XMLAGG(XMLELEMENT(A,CHR(10) || '\D:\Anyfive\product\IPIMS\files\'||FE.FILE_POLICY||FE.FILE_PATH||'\'||FE.FILE_NAME)).EXTRACT('//text()'), 2)
       FROM   TB_COM_FILE FE
       WHERE  FE.FILE_ID = A.APPDOC_FILE) "FILE_PATH" -- 파일경로 목록
FROM   TB_APP_MST A
     , TB_APP_ABSTRACT B
WHERE  A.REF_ID = B.REF_ID(+);
