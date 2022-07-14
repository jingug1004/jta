CREATE OR REPLACE VIEW V_SEARCH AS
SELECT
/**
 * �˻� ���ο� ��
 */
       A.REF_ID "ID"
     , A.REF_NO "NO"
     , CASE WHEN A.ABD_YN = '1' THEN 'ABD' -- ����
            WHEN A.APP_NO IS NULL THEN 'NON' -- �����
            WHEN A.APP_NO IS NOT NULL AND A.REG_NO IS NULL THEN 'APP' -- ���
            WHEN A.APP_NO IS NOT NULL AND A.REG_NO IS NOT NULL THEN 'REG' -- ���
       END "STATE" -- ���/��ϻ���
     , A.KO_APP_TITLE "TL" -- �߸�(���)�� ��Ī
     , B.ABSTRACT "AB" -- �ʷ�
     , B.CLAIM "CL" -- û������
     , A.IPC_CLS_CODE "IPC" -- IPC
     , A.APP_NO "AN" -- �����ȣ
     , A.PUB_NO "OPN" -- ������ȣ
     , A.REG_NO "GN" -- ��Ϲ�ȣ
     , FN_PRIORITY_APP_NOS(A.REF_ID) "RN" -- �켱�������ȣ
     , A.APP_DATE "AD" -- �������
     , A.PUB_DATE "OPD" -- ��������
     , A.REG_DATE "GD" -- �������
     , FN_PRIORITY_APP_DATES(A.REF_ID) "RD" -- �켱����������
     , FN_INVENTOR_NAMES(A.REF_ID) "IN" -- �߸��� �̸�
     , FN_OFFICE_NAME(A.OFFICE_CODE) "AG" -- �븮�� �̸�
     , A.APPDOC_FILE "FILE_ID"
     , DECODE(A.UPD_DATE, NULL, A.CRE_DATE, A.UPD_DATE) CHG_DATE
     , (SELECT
          SUBSTR(XMLAGG(XMLELEMENT(A,CHR(10) || FE.FILE_NAME_ORG)).EXTRACT('//text()'), 2)
       FROM   TB_COM_FILE FE
       WHERE  FE.FILE_ID = A.APPDOC_FILE) "FILE_NAME" -- ���ϸ� ���
     , (SELECT
          SUBSTR(XMLAGG(XMLELEMENT(A,CHR(10) || '\D:\Anyfive\product\IPIMS\files\'||FE.FILE_POLICY||FE.FILE_PATH||'\'||FE.FILE_NAME)).EXTRACT('//text()'), 2)
       FROM   TB_COM_FILE FE
       WHERE  FE.FILE_ID = A.APPDOC_FILE) "FILE_PATH" -- ���ϰ�� ���
FROM   TB_APP_MST A
     , TB_APP_ABSTRACT B
WHERE  A.REF_ID = B.REF_ID(+);
