CREATE OR REPLACE PROCEDURE SP_FAMILY(I_WORK_ID IN TB_FAMILY_ENTITY.WORK_ID%TYPE,
                                      I_REF_ID  IN TB_FAMILY_ENTITY.REF_ID%TYPE) IS

  V_REF_ID   TB_FAMILY_ENTITY.REF_ID%TYPE;
  V_REF_TYPE TB_FAMILY_ENTITY.REF_TYPE%TYPE; -- REF����(1.����REF, 2.�ؿ�GROUP, 3.�ؿ�REF)
  V_REF_CNT  NUMBER;

  CURSOR CUR_ENTITY IS
    SELECT REF_ID, REF_TYPE
      FROM TB_FAMILY_ENTITY
     WHERE WORK_ID = I_WORK_ID
       AND DO_GUBUN IS NULL;

BEGIN

  DELETE FROM TB_FAMILY_ENTITY WHERE WORK_ID = I_WORK_ID;

  DELETE FROM TB_FAMILY_LINK WHERE WORK_ID = I_WORK_ID;

  IF I_REF_ID IS NULL THEN
    RETURN;
  END IF;

  -- �������ǰ��
  IF V_REF_ID IS NULL THEN
    BEGIN
      SELECT REF_ID, '1'
        INTO V_REF_ID, V_REF_TYPE
        FROM TB_APP_INT_CONSULT
       WHERE REF_ID = I_REF_ID;
    EXCEPTION
      WHEN OTHERS THEN
        V_REF_ID := NULL;
    END;
  END IF;

  -- ���������
  IF V_REF_ID IS NULL THEN
    BEGIN
      SELECT REF_ID, DECODE(INOUT_DIV, 'INT', '1', 'EXT',DECODE((SELECT COUNT(GRP_ID) FROM TB_MAPP_REF_ID WHERE REF_ID= I_REF_ID AND MAPP_KIND='G'),0,'3','1'))
        INTO V_REF_ID, V_REF_TYPE
        FROM TB_APP_MST
       WHERE REF_ID = I_REF_ID;
    EXCEPTION
      WHEN OTHERS THEN
        V_REF_ID := NULL;
    END;
  END IF;

  -- �ؿܱ׷�
  IF V_REF_ID IS NULL THEN
    BEGIN
      SELECT GRP_ID, '2'
        INTO V_REF_ID, V_REF_TYPE
        FROM TB_APP_EXT_GRP
       WHERE GRP_ID = I_REF_ID;
    EXCEPTION
      WHEN OTHERS THEN
        V_REF_ID := NULL;
    END;
  END IF;

  IF V_REF_ID IS NULL THEN
    RAISE_APPLICATION_ERROR(-20000, '���� �����ϴ�.');
  END IF;

  -- ����REF ������ ��´�
  INSERT INTO TB_FAMILY_ENTITY
  VALUES
    (I_WORK_ID, V_REF_ID, V_REF_TYPE, NULL);

  -----------------------------------------------------------------------------------------------
  -- ���赵�� �����Ѵ�
  -----------------------------------------------------------------------------------------------
  LOOP

    -- ���赵�� ������ REF�� �����ϴ��� Ȯ��
    SELECT COUNT(1)
      INTO V_REF_CNT
      FROM TB_FAMILY_ENTITY
     WHERE WORK_ID = I_WORK_ID
       AND DO_GUBUN IS NULL;
    EXIT WHEN V_REF_CNT = 0;

    -- ���赵 ���� (Ŀ�� ����)
    FOR CUR_ROW IN CUR_ENTITY LOOP

      -- Ŀ���� �ҷ��� ���赵���� REF�� ���� ������ �߰��Ѵ�
      INSERT INTO TB_FAMILY_LINK
      VALUES
        (I_WORK_ID, CUR_ROW.REF_ID, NULL, NULL);

      -- ����REF
      IF CUR_ROW.REF_TYPE = '1' THEN

        -- ���հ� ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.REF_ID, '1', NULL
            FROM TB_MAPP_REF_ID A,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = T.REF_ID(+)
             AND A.REF_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.REF_ID)
             AND A.MAPP_KIND = 'U';
        -- ���հ�(������) ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.GRP_ID, '1', NULL
            FROM TB_MAPP_REF_ID A,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.GRP_ID = T.REF_ID(+)
             AND A.REF_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.GRP_ID)
             AND A.MAPP_KIND = 'U';
        -- ���հ� �������� ����
        INSERT INTO TB_FAMILY_LINK
          SELECT I_WORK_ID, A.GRP_ID, A.REF_ID, 'N'
            FROM TB_MAPP_REF_ID A
           WHERE A.GRP_ID = CUR_ROW.REF_ID
             AND A.MAPP_KIND = 'U';

        -- �켱�� ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.GRP_ID, '1', NULL
            FROM TB_MAPP_REF_ID A,
                 TB_APP_MST B,
                 TB_APP_MST C,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = B.REF_ID
             AND A.GRP_ID = C.REF_ID
             AND A.GRP_ID = T.REF_ID(+)
             AND B.REF_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.GRP_ID)
             AND A.MAPP_KIND = 'P'
             AND B.INOUT_DIV = 'INT'
             AND C.INOUT_DIV = 'INT'
             UNION ALL
            SELECT I_WORK_ID, A.GRP_ID, '1', NULL
            FROM TB_MAPP_REF_ID A,
                 TB_APP_MST B,
                 TB_APP_MST C,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = B.REF_ID
             AND A.GRP_ID = C.REF_ID
             AND A.GRP_ID = T.REF_ID(+)
             AND B.REF_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.GRP_ID)
             AND A.MAPP_KIND = 'P'
             AND B.INOUT_DIV = 'EXT'
             AND C.INOUT_DIV = 'INT';
        -- �켱��(������) ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, C.REF_ID, '1', NULL
            FROM TB_MAPP_REF_ID A,
                 TB_APP_MST B,
                 TB_APP_MST C,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.GRP_ID = B.REF_ID
             AND A.REF_ID = C.REF_ID
             AND C.REF_ID = T.REF_ID(+)
             AND A.GRP_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = C.REF_ID)
             AND A.MAPP_KIND = 'P'
             AND B.INOUT_DIV = 'INT'
             AND C.INOUT_DIV = 'INT'
             UNION ALL
             SELECT I_WORK_ID, C.REF_ID, '1', NULL
            FROM TB_MAPP_REF_ID A,
                 TB_APP_MST B,
                 TB_APP_MST C,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.GRP_ID = B.REF_ID
             AND A.REF_ID = C.REF_ID
             AND C.REF_ID = T.REF_ID(+)
             AND A.GRP_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = C.REF_ID)
             AND A.MAPP_KIND = 'P'
             AND B.INOUT_DIV = 'INT'
             AND C.INOUT_DIV = 'EXT';
        -- �켱�� �������� ����
        INSERT INTO TB_FAMILY_LINK
          SELECT I_WORK_ID, B.REF_ID, A.GRP_ID, 'PR'
            FROM TB_MAPP_REF_ID A, TB_APP_MST B, TB_APP_MST C
           WHERE A.REF_ID = B.REF_ID
             AND A.GRP_ID = C.REF_ID
             AND B.REF_ID = CUR_ROW.REF_ID
             AND A.MAPP_KIND = 'P'
             AND B.INOUT_DIV = 'INT'
             UNION ALL
             SELECT I_WORK_ID, B.REF_ID, A.GRP_ID, 'PR'
            FROM TB_MAPP_REF_ID A, TB_APP_MST B, TB_APP_MST C
           WHERE A.REF_ID = B.REF_ID
             AND A.GRP_ID = C.REF_ID
             AND B.REF_ID = CUR_ROW.REF_ID
             AND A.MAPP_KIND = 'P'
             AND B.INOUT_DIV = 'EXT';

        -- ���Ұ� ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.REF_ID, '1', NULL
            FROM TB_APP_MST A,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.DIVISION_PRIOR_REF_ID = CUR_ROW.REF_ID
             AND A.REF_ID = T.REF_ID(+)
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.REF_ID)
             AND A.INOUT_DIV = 'INT';
        -- ���Ұ�(������) ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.DIVISION_PRIOR_REF_ID, '1', NULL
            FROM TB_APP_MST A,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = CUR_ROW.REF_ID
             AND A.DIVISION_PRIOR_REF_ID = T.REF_ID(+)
             AND A.DIVISION_PRIOR_REF_ID IS NOT NULL
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.DIVISION_PRIOR_REF_ID)
             AND A.INOUT_DIV = 'INT';
        -- ���Ұ� �������� ����
        INSERT INTO TB_FAMILY_LINK
          SELECT I_WORK_ID, A.DIVISION_PRIOR_REF_ID, A.REF_ID, 'D'
            FROM TB_APP_MST A
           WHERE A.DIVISION_PRIOR_REF_ID = CUR_ROW.REF_ID
             AND A.INOUT_DIV = 'INT';

        -- �ؿܱ׷� ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.GRP_ID, '2', NULL
            FROM TB_MAPP_REF_ID A,
                 TB_APP_MST B,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = B.REF_ID
             AND A.GRP_ID = T.REF_ID(+)
             AND B.REF_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.GRP_ID)
             AND A.MAPP_KIND = 'G';
        -- �ؿܱ׷� �������� ����
        INSERT INTO TB_FAMILY_LINK
          SELECT I_WORK_ID, B.REF_ID, A.GRP_ID, 'G'
            FROM TB_MAPP_REF_ID A, TB_APP_MST B
           WHERE A.REF_ID = B.REF_ID
             AND B.REF_ID = CUR_ROW.REF_ID
             AND A.MAPP_KIND = 'G';

      END IF;

      -- �ؿ�GROUP
      IF CUR_ROW.REF_TYPE = '2' THEN

        -- �ؿ���� ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.REF_ID, '3', NULL
            FROM TB_APP_MST_EXT A,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = T.REF_ID(+)
             AND A.GRP_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.REF_ID);
        -- �������(������) ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.REF_ID, '1', NULL
            FROM TB_MAPP_REF_ID A,
                 TB_APP_MST B,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = B.REF_ID
             AND A.REF_ID = T.REF_ID(+)
             AND A.GRP_ID = CUR_ROW.REF_ID
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.REF_ID)
             AND A.MAPP_KIND = 'G';
        -- �ؿ���� �������� ����
        INSERT INTO TB_FAMILY_LINK
          SELECT I_WORK_ID, B.GRP_ID, A.REF_ID, 'O'
            FROM TB_APP_MST A, TB_APP_MST_EXT B
           WHERE A.REF_ID = B.REF_ID
             AND A.DIVISION_PRIOR_REF_ID IS  NULL
             AND B.GRP_ID = CUR_ROW.REF_ID;

      END IF;

      -- �ؿ�REF
      IF CUR_ROW.REF_TYPE = '3' THEN

        -- �ؿܱ׷� ����Ƽ ����
        INSERT INTO TB_FAMILY_ENTITY
          SELECT I_WORK_ID, A.GRP_ID, '2', NULL
            FROM TB_APP_MST_EXT A,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = CUR_ROW.REF_ID
             AND A.GRP_ID = T.REF_ID(+)
             AND NOT EXISTS (SELECT 1
                    FROM TB_FAMILY_ENTITY X
                   WHERE X.WORK_ID = I_WORK_ID
                     AND X.REF_ID = A.GRP_ID)
            UNION ALL
        --�ؿ�����ǿ��� �ؿܱ׷� ���� �� ���
          SELECT I_WORK_ID, A.GRP_ID, '2',NULL
            FROM TB_MAPP_REF_ID A,
                 (SELECT REF_ID
                    FROM TB_FAMILY_ENTITY
                   WHERE WORK_ID = I_WORK_ID
                     AND DO_GUBUN IS NULL) T
           WHERE A.REF_ID = CUR_ROW.REF_ID
             AND A.GRP_ID = T.REF_ID(+)
             AND A.MAPP_KIND='G';

        -- ���Ұ� �������� ����
        INSERT INTO TB_FAMILY_LINK
          SELECT I_WORK_ID,
                 NVL(A.DIVISION_PRIOR_REF_ID,B.GRP_ID) GRP_ID,
                 A.REF_ID,
                 DECODE(C.COUNTRY_CODE, 'EP', 'E','PC','E',A.DIVISION_TYPE)
            FROM TB_APP_MST A, TB_APP_MST_EXT B, TB_APP_MST C
           WHERE A.REF_ID = B.REF_ID
              AND A.DIVISION_PRIOR_REF_ID = C.REF_ID
             AND A.REF_ID = CUR_ROW.REF_ID;

      END IF;

      -- �������� ������� �ʵ��� ó�� (DO_GUBUN = '1' ó��)
      UPDATE TB_FAMILY_ENTITY
         SET DO_GUBUN = '1'
       WHERE WORK_ID = I_WORK_ID
         AND REF_ID = CUR_ROW.REF_ID;

    END LOOP;

  END LOOP;

END;
