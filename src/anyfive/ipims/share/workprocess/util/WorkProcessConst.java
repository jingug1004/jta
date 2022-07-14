package anyfive.ipims.share.workprocess.util;

public class WorkProcessConst
{
    public class Step
    {
        /**
         * 선행기술조사 의뢰
         */
        public static final String PRIOR_SEARCH_REQUEST  = "WP_S01_100";

        /**
         * 선행기술조사 품의
         */
        public static final String PRIOR_SEARCH_CONSULT  = "WP_S01_300";

        /**
         * 선행기술조사 진행
         */
        public static final String PRIOR_SEARCH_PROGRESS = "WP_S01_400";

        /**
         * 국내 특허 의뢰
         */
        public static final String INT_PATENT_REQUEST    = "WP_P01_100";

        /**
         * 국내 특허 품의
         */
        public static final String INT_PATENT_CONSULT    = "WP_P01_300";

        /**
         * 국내 상표 의뢰
         */
        public static final String INT_TMARK_REQUEST     = "WP_T01_100";

        /**
         * 국내 상표 품의
         */
        public static final String INT_TMARK_CONSULT     = "WP_T01_300";

        /**
         * 국내 디자인 의뢰
         */
        public static final String INT_DESIGN_REQUEST    = "WP_D01_100";

        /**
         * 국내 디자인 품의
         */
        public static final String INT_DESIGN_CONSULT    = "WP_D01_300";

        /**
         * 해외 특허 신규OL
         */
        public static final String EXT_PATENT_NEW_OL     = "WP_P11_100";

        /**
         * 해외 상표 신규OL
         */
        public static final String EXT_TMARK_NEW_OL      = "WP_T11_100";

        /**
         * 해외 디자인 신규OL
         */
        public static final String EXT_DESIGN_NEW_OL     = "WP_D11_100";

        /**
         * 해외 특허 계속분할OL
         */
        public static final String EXT_PATENT_CONDIV_OL  = "WP_P11_200";

        /**
         * 해외 특허 EP/PCT OL
         */
        public static final String EXT_PATENT_EPPCT_OL   = "WP_P11_300";

        /**
         * 발명부서 등록평가
         */
        public static final String INVDEPT_REG_EVAL      = "WP_E02_100";

        /**
         * 특허부서 등록평가
         */
        public static final String PATDEPT_REG_EVAL      = "WP_E02_200";

        /**
         * 발명부서 등록유지평가
         */
        public static final String INVDEPT_REG_KEEP_EVAL = "WP_E03_100";

        /**
         * 특허부서 등록유지평가
         */
        public static final String PATDEPT_REG_KEEP_EVAL = "WP_E03_200";

        /**
         * 프로그램 의뢰
         */
        public static final String PROGRAM_REQUEST       = "WP_G01_100";

        /**
         * 프로그램 품의
         */
        public static final String PROGRAM_CONSULT       = "WP_G01_200";

        /**
         * 프로그램 검토
         */
        public static final String PROGRAM_PROGRESS      = "WP_G01_300";

        /**
         * 프로그램 진행
         */
        public static final String PROGRAM_MASTER        = "WP_G01_400";
    }

    public class Action
    {
        /**
         * NONE
         */
        public static final String NONE                  = "AZ0000";

        /**
         * START
         */
        public static final String START                 = "AZ1111";

        /**
         * AUTO
         */
        public static final String AUTO                  = "AZ5555";

        /**
         * END
         */
        public static final String END                   = "AZ9999";

        /**
         * 작성
         */
        public static final String WRITE                 = "A00001";

        /**
         * 재작성
         */
        public static final String REWRITE               = "A00013";

        /**
         * 수정
         */
        public static final String MODIFY                = "A00002";

        /**
         * 결재 요청
         */
        public static final String APPR_REQUEST          = "A00003";

        /**
         * 결재 없음
         */
        public static final String APPR_NONE             = "A00004";

        /**
         * 결재 취소
         */
        public static final String APPR_CANCEL           = "A00005";

        /**
         * 결재 최종승인
         */
        public static final String APPR_AGREEALL         = "A00006";

        /**
         * 결재 반려
         */
        public static final String APPR_REJECT           = "A00007";

        /**
         * 결재 재작성
         */
        public static final String APPR_REWRITE          = "A00008";

        /**
         * 건담당자 지정
         */
        public static final String JOB_MAN_ASSIGN        = "A00009";

        /**
         * 사무소 접수
         */
        public static final String OFFICE_RECEIPT        = "A00010";

        /**
         * 조사결과 입력
         */
        public static final String PRSCH_RESULT_INPUT    = "A00011";

        /**
         * 조사결과 완료
         */
        public static final String PRSCH_RESULT_COMPLETE = "A00012";
    }

    public class Status
    {
        /**
         * NONE
         */
        public static final String NONE = "SZ0000";

        /**
         * END
         */
        public static final String END  = "SZ9999";

    }
}
