package anyfive.ipims.patent.common.approval.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ApprovalDao extends NAbstractServletDao
{
    public ApprovalDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 결재환경정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 결재 APPR_KEYS 조회
     *
     * @param apprNo
     * @param apprMgt
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalKeys(String apprNo, NSingleData apprMgt) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalKeys");
        dao.bind("APPR_NO", apprNo);

        dao.replaceText("apprPkCols", apprMgt.getString("APPR_PK_COLS"));
        dao.replaceText("apprTable", apprMgt.getString("APPR_TABLE"));
        dao.replaceText("apprNoCol", apprMgt.getString("APPR_NO_COL"));

        return dao.executeQueryForSingle();
    }

    /**
     * 메인정보 조회
     *
     * @param apprCode
     * @param apprKey
     * @param apprMgt
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalMainInfo(String apprCode, NSingleData apprKey, NSingleData apprMgt) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMainInfo");
        dao.bind("REF_ID", apprKey.getString(apprKey.getKey(0)));
        dao.bind("APPR_CODE", apprCode);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.APPR_REQUEST);

        dao.replaceText("apprNoCol", apprMgt.getString("APPR_NO_COL"));
        dao.replaceText("apprTable", apprMgt.getString("APPR_TABLE"));

        for (int i = 0; i < apprKey.getKeySize(); i++) {
            dao.addQuery("apprKey");
            dao.replaceText("apprKey", apprKey.getKey(i));
            dao.addParam(apprKey.getString(apprKey.getKey(i)));
        }

        return dao.executeQueryForSingle();
    }

    /**
     * 결재공통 마스터 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalMaster(String apprNo, NSingleData apprMgt) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMaster");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQueryForSingle();
    }

    /**
     * 결재요청 목록 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NMultiData retrieveApprovalRequestList(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalRequestList");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQuery();
    }

    /**
     * 결재처리자 목록 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NMultiData retrieveApprovalAnswerListA(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalAnswerListA");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQuery();
    }

    /**
     * 결재배포자 목록 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NMultiData retrieveApprovalAnswerListB(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalAnswerListB");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQuery();
    }

    /**
     * 결재공통 마스터 생성
     *
     * @param apprNo
     * @param apprCode
     * @param reqSeq
     * @return
     * @throws NException
     */
    public int createApprovalMaster(String apprNo, String apprCode, String reqSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/createApprovalMaster");
        dao.bind("APPR_NO", apprNo);
        dao.bind("APPR_CODE", apprCode);
        dao.bind("LAST_REQ_SEQ", reqSeq);

        return dao.executeUpdate();
    }

    /**
     * 결재공통 마스터 수정
     *
     * @param apprNo
     * @param reqSeq
     * @return
     * @throws NException
     */
    public int updateApprovalMaster(String apprNo, String reqSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/updateApprovalMaster");
        dao.bind("APPR_NO", apprNo);
        dao.bind("LAST_REQ_SEQ", reqSeq);

        return dao.executeUpdate();
    }

    /**
     * 결재공통 마스터 상태 수정
     *
     * @param apprNo
     * @param apprStatus
     * @return
     * @throws NException
     */
    public int updateApprovalMasterStatus(String apprNo, String apprStatus) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/updateApprovalMasterStatus");
        dao.bind("APPR_NO", apprNo);
        dao.bind("APPR_STATUS", apprStatus);

        return dao.executeUpdate();
    }

    /**
     * 업무테이블의 결재번호 수정
     *
     * @param apprMgt
     * @param apprKey
     * @param apprNo
     * @return
     * @throws NException
     */
    public int updateApprovalNoOfBizTable(NSingleData apprMgt, NSingleData apprKey, String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/updateApprovalNoOfBizTable");

        dao.replaceText("apprTable", apprMgt.getString("APPR_TABLE"));
        dao.replaceText("apprNoCol", apprMgt.getString("APPR_NO_COL"));
        dao.addParam(apprNo);

        for (int i = 0; i < apprKey.getKeySize(); i++) {
            dao.addQuery("apprKey", "apprKeyWhere");
            dao.replaceText("apprKey", apprKey.getKey(i));
            dao.addParam(apprKey.getString(apprKey.getKey(i)));
        }

        return dao.executeUpdate();
    }

    /**
     * 결재요청 생성
     *
     * @param apprNo
     * @param reqSeq
     * @param reqInfo
     * @return
     * @throws NException
     */
    public int createApprovalRequest(String apprNo, String reqSeq, NSingleData reqInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/createApprovalRequest");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);
        dao.bind(reqInfo);

        return dao.executeUpdate();
    }

    /**
     * 결재요청 수정
     *
     * @param apprNo
     * @param reqSeq
     * @param reqStatus
     * @return
     * @throws NException
     */
    public int updateApprovalRequest(String apprNo, String reqSeq, String reqStatus) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/updateApprovalRequest");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);
        dao.bind("REQ_STATUS", reqStatus);

        return dao.executeUpdate();
    }

    /**
     * 결재처리자 목록 생성
     *
     * @param apprNo
     * @param reqSeq
     * @param ansUserListA
     * @return
     * @throws NException
     */
    public int[] createApprovalAnswerA(String apprNo, String reqSeq, NMultiData ansUserListA) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/createApprovalAnswerA");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);

        return dao.executeBatch(ansUserListA);
    }

    /**
     * 결재배포자 목록 생성
     *
     * @param apprNo
     * @param reqSeq
     * @param ansUserListB
     * @return
     * @throws NException
     */
    public int[] createApprovalAnswerB(String apprNo, String reqSeq, NMultiData ansUserListB) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/createApprovalAnswerB");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);

        return dao.executeBatch(ansUserListB);
    }

    /**
     * 결재처리 수정
     *
     * @param apprNo
     * @param reqSeq
     * @param ansOrd
     * @param ansInfo
     * @return
     * @throws NException
     */
    public int updateApprovalAnswer(String apprNo, String reqSeq, String ansOrd, NSingleData ansInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/updateApprovalAnswer");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);
        dao.bind("ANS_ORD", ansOrd);
        dao.bind(ansInfo);

        return dao.executeUpdate();
    }

    /**
     * 다음 결재처리자 상태 변경
     *
     * @param apprNo
     * @param reqSeq
     * @return
     * @throws NException
     */
    public int updateApprovalNextAnswerStatus(String apprNo, String reqSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/updateApprovalNextAnswerStatus");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);

        return dao.executeUpdate();
    }

    /**
     * 결재요청 삭제
     *
     * @param apprNo
     * @param reqSeq
     * @return
     * @throws NException
     */
    public int deleteApprovalRequest(String apprNo, String reqSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/deleteApprovalRequest");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);

        return dao.executeUpdate();
    }

    /**
     * 결재처리자 목록 삭제
     *
     * @param apprNo
     * @param reqSeq
     * @return
     * @throws NException
     */
    public int deleteApprovalAnswerListA(String apprNo, String reqSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/deleteApprovalAnswerListA");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);

        return dao.executeUpdate();
    }

    /**
     * 결재배포자 목록 삭제
     *
     * @param apprNo
     * @param reqSeq
     * @return
     * @throws NException
     */
    public int deleteApprovalAnswerListB(String apprNo, String reqSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/deleteApprovalAnswerListB");
        dao.bind("APPR_NO", apprNo);
        dao.bind("REQ_SEQ", reqSeq);

        return dao.executeUpdate();
    }

    /**
     * 결재메일 발송정보 조회 - 요청정보
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalMailSendInfoReq(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMailSendInfoReq");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQueryForSingle();
    }

    /**
     * 결재메일 발송정보 조회 - 처리정보
     *
     * @param apprNo
     * @param ansOrd
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalMailSendInfoAns(String apprNo, String ansOrd) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMailSendInfoAns");
        dao.bind("APPR_NO", apprNo);
        dao.bind("ANS_ORD", ansOrd);

        return dao.executeQueryForSingle();
    }

    /**
     * 결재요청/취소메일 수신정보(처리자) 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalMailAnsInfo(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMailAnsInfo");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQueryForSingle();
    }

    /**
     * 결재반려메일 수신목록(요청자) 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalMailReqInfo(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMailReqInfo");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQueryForSingle();
    }

    /**
     * 결재배포메일 수신목록(요청자 및 배포자) 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NMultiData retrieveApprovalMailDistList(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMailDistList");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQuery();
    }

    /**
     * 결재배포메일 수신목록(요청자 및 배포자) 조회 - 품의일경우
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NMultiData retrieveApprovalMailDistList2(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMailDistList2");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQuery();
    }

    /**
     * 결재메일 진행내역 목록 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NMultiData retrieveApprovalMailHistoryList(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveApprovalMailHistoryList");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQuery();
    }

    /**
     * 결재메일 KEY 생성
     *
     * @param mailKey
     * @param apprNo
     * @param userId
     * @return
     * @throws NException
     */
    public int createApprovalMailKey(String mailKey, String apprNo, String userId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/createApprovalMailKey");
        dao.bind("MAIL_KEY", mailKey);
        dao.bind("APPR_NO", apprNo);
        dao.bind("USER_ID", userId);

        return dao.executeUpdate();
    }

    /**
     * 업무프로세스 처리가능여부 조회
     *
     * @param apprCode
     * @param apprKey
     * @return
     * @throws NException
     */
    public String retrieveWorkProcessAvail(String apprCode, NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approval/approval", "/retrieveWorkProcessAvail");
        dao.bind("APPR_CODE", apprCode);
        dao.bind("REF_ID", apprKey.getString(apprKey.getKey(0)));

        return dao.executeQueryForString();
    }
}
