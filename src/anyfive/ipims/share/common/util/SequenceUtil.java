package anyfive.ipims.share.common.util;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NDateUtil;
import anyfive.framework.sequence.biz.SequenceBiz;

public class SequenceUtil extends NAbstractServletBiz
{
    private final SequenceBiz seq;

    public SequenceUtil(NServiceResource nsr)
    {
        super(nsr);

        this.seq = new SequenceBiz(nsr);
    }

    /**
     * 사용자 ID
     *
     * @param userType
     *            사용자형태(P:특허팀, F:사무소, X:외부발명자)
     * @return
     * @throws NException
     */
    public String getUserId(String userType) throws NException
    {
        return this.seq.get("USER_ID", userType, 9, "");
    }

    /**
     * 업무 ID
     *
     * @return
     * @throws NException
     */
    public String getBizId() throws NException
    {
        return this.seq.get("BIZ_ID", null, 15, null);
    }

    /**
     * 업무 ID 별 History SEQ
     *
     * @return
     * @throws NException
     */
    public String getBizHistSeq(String bizId) throws NException
    {
        return this.seq.get("BIZ_HIST_SEQ", bizId, 5, null);
    }

    /**
     * 진행서류 목록 SEQ
     *
     * @param refId
     * @return
     * @throws NException
     */
    public String getPaperListSeq(String refId) throws NException
    {
        return this.seq.get("PAPER_LIST", refId, 5, null);
    }

    /**
     * OA SEQ
     *
     * @param refId
     * @return
     * @throws NException
     */
    public String getOASeq(String refId) throws NException
    {
        return this.seq.get("OA_SEQ", refId, 4, null);
    }

    /**
     * 비용대분류 코드
     *
     * @return
     * @throws NException
     */
    public String getCostGrandCode() throws NException
    {
        return this.seq.get("GRAND_CODE", null, 2, null);
    }

    /**
     * 비용대분류 상세분류코드
     *
     * @param grandCode
     * @return
     * @throws NException
     */
    public String getCostDetailCode(String grandCode) throws NException
    {
        return this.seq.get("DETAIL_CODE", grandCode, 4, null);
    }

    /**
     * 사무소 코드
     *
     * @return
     * @throws NException
     */
    public String getOfficeCode() throws NException
    {
        return this.seq.get("OFFICE_CODE", null, 3, null);
    }

    /**
     * 메뉴 코드
     *
     * @return
     * @throws NException
     */
    public String getMenuCode(String systemType) throws NException
    {
        return this.seq.get("MENU_CODE", systemType, 5, null);
    }

    /**
     * 결재 번호
     *
     * @return
     * @throws NException
     */
    public String getApprNo() throws NException
    {
        return this.seq.get("APPR_NO", null, 12, null);
    }

    /**
     * 결재 번호별 결재요청 SEQ
     *
     * @return
     * @throws NException
     */
    public String getApprReqSeq(String apprNo) throws NException
    {
        return this.seq.get("APPR_REQ_SEQ", apprNo, 3, null);
    }

    /**
     * 평가서 ID
     *
     * @return
     * @throws NException
     */
    public String getEvalSheetId() throws NException
    {
        return this.seq.get("EVAL_SHEET_ID", null, 5, null);
    }

    /**
     * 게시판 글번호
     *
     * @return
     * @throws NException
     */
    public String getBrdNo(String brdId) throws NException
    {
        return this.seq.get("BRD_NO", brdId, 12, null);
    }

    /**
     * 비용 SEQ
     *
     * @return
     * @throws NException
     */
    public String getCostSeq() throws NException
    {
        return this.seq.get("COST_SEQ", null, 15, null);
    }

    /**
     * 해외출원비용 레터 SEQ
     *
     * @return
     * @throws NException
     */
    public String getLetterSeq() throws NException
    {
        return this.seq.get("LETTER_SEQ", null, 15, null);
    }

    /**
     * 조사의뢰 번호
     *
     * @return
     * @throws NException
     */
    public String getPrschNo() throws NException
    {
        return "S" + this.seq.get("PRSCH_NO", NDateUtil.getFormatDate("yyyyMM"), 4, "-");
    }

    /**
     * REF_NO 및 GRP_NO
     *
     * @param rightDiv
     *            권리구분
     * @return
     * @throws NException
     */
    public String getRefGrpNo(String rightDiv) throws NException
    {
        NSingleData rightInfo = new NSingleData();

        rightInfo.setString("10", "P"); // 특허
        rightInfo.setString("20", "U"); // 실용신안
        rightInfo.setString("30", "D"); // 디자인
        rightInfo.setString("40", "T"); // 상표
        rightInfo.setString("50", "KH"); // KnowHow

        String internal = "K";

        String rightCode = rightInfo.getString(rightDiv);

        if (rightCode.equals("")) rightCode = rightDiv;

        return this.seq.get("REF_GRP_NO", internal+ rightCode + NDateUtil.getFormatDate("yyyy"), 4, "-");
    }

    /**
     * 분석자료 관리번호
     *
     * @return
     * @throws NException
     */
    public String getAnalyMgtNo() throws NException
    {
        return this.seq.get("ANALY_MGT_NO", "AN" + NDateUtil.getFormatDate("yyyyMM"), 3, "-");
    }

    /**
     * 분석자료 관리번호
     *
     * @return
     * @throws NException
     */
    public String getAnalyDocNo() throws NException
    {
        return this.seq.get("ANALY_DOC_NO", "AL" + NDateUtil.getFormatDate("yyyyMM"), 3, "-");
    }

    /**
     * 라이센스 관리번호
     *
     * @return
     * @throws NException
     */
    public String getLicenseMgtNo() throws NException
    {
        return this.seq.get("LICENSE_MGT_NO", "LP" + NDateUtil.getFormatDate("yyyyMM"), 3, "-");
    }

    /**
     * 감정서 관리번호
     *
     * @return
     * @throws NException
     */
    public String getExpopinMgtNo() throws NException
    {
        return this.seq.get("EXPOPIN_MGT_NO", "OP" + NDateUtil.getFormatDate("yyyyMM"), 3, "-");
    }

    /**
     * 분쟁(소송) 관리번호
     *
     * @return
     * @throws NException
     */
    public String getDisputeMgtNo() throws NException
    {
        return this.seq.get("DISPUTE_MGT_NO", NDateUtil.getFormatDate("yyyyMM"), 4, "-");
    }

    /**
     * IP Biz. 공통 히스토리 SEQ
     *
     * @return
     * @throws NException
     */
    public String getIpBizHistorySeq(String refId) throws NException
    {
        return this.seq.get("IP_BIZ_HIST_SEQ", refId, 5, null);
    }

    /**
     * 경쟁사 관리번호
     *
     * @return
     * @throws NException
     */
    public String getRivalPatMgtId() throws NException
    {
        return this.seq.get("RIVALPAT_MGT_ID", null, 15, null);
    }

    /**
     * 경쟁사 관리 댓글 SEQ
     *
     * @return
     * @throws NException
     */
    public String getRivalPatReplySeq(String mgtId) throws NException
    {
        return this.seq.get("RIVALPAT_REPLY_SEQ", mgtId, 5, null);
    }

    /**
     * 프로그램 번호
     *
     * @return
     * @throws NException
     */
    public String getProgramNo() throws NException
    {
        return "G" + this.seq.get("PROGRAM_NO", NDateUtil.getFormatDate("yyyyMM"), 4, "-");
    }

    /**
     * 출원인 코드 번호
     *
     * @return
     * @throws NException
     */
    public String getAppManCode() throws NException
    {
        return this.seq.get("APP_MAN_CODE", "P", 4, "");
    }

    /**
     * 심사요청 번호
     *
     * @return
     * @throws NException
     */
    public String getMetNo() throws NException
    {
        return this.seq.get("MGT_NO", "RP" + NDateUtil.getFormatDate("yyyyMM"), 3, "-");
    }


    /**
     * 계약서  번호
     *
     * @return
     * @throws NException
     */
    public String getContractNo(String contractKind) throws NException
    {
        return this.seq.get("MGT_NO", contractKind + "-" + NDateUtil.getFormatDate("yyyyMM"), 4, "-");
    }
}
