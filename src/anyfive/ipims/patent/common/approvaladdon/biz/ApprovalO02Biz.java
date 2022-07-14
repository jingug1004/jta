package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.dao.ApprovalO01Dao;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class ApprovalO02Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalO02Biz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내 거절결정 검토서 결재처리
     *
     * @param apprNo
     * @param apprEvent
     * @param apprMgt
     * @throws NException
     */
    public void execute(String apprNo, NSingleData apprKey, short apprEvent, NSingleData apprMgt) throws NException
    {
        // 결재없음 또는 최종승인시
        if (apprEvent == ApprovalEvents.NONE || apprEvent == ApprovalEvents.AGREEALL) {
            this.executeAgreeAll(apprKey);
        }
    }

    /**
     * 결재없음 또는 최종승인 처리
     *
     * @param apprKey
     * @throws NException
     */
    private void executeAgreeAll(NSingleData apprKey) throws NException
    {
        ApprovalO01Dao dao = new ApprovalO01Dao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // 검토서 내용 조회
        NSingleData mainInfo = dao.retrieveIntRejectExam(apprKey);

        // 검토서 발송일 업데이트
        dao.updateIntRejectExamSendDate(apprKey);

        // 진행서류 생성
        docBiz.init(apprKey.getString("REF_ID"));
        if (mainInfo.getString("EXAM_RESULT").equals("1")) {
            docBiz.setEvent("REJECT_DECISION_EXAM_SEND"); // 거절결정 검토 후 의견서제출
            docBiz.setValue("REMARK", mainInfo.getString("COPE_PLAN"));
        } else {
            docBiz.setEvent("REJECT_DECISION_EXAM_ABANDON"); // 거절결정 검토 후 포기
            docBiz.setValue("REMARK", "OA 포기처리");
        }
        docBiz.setValue("OA_SEQ", apprKey.getString("OA_SEQ"));
        docBiz.create();
    }
}
