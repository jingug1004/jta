package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.dao.ApprovalR02Dao;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class ApprovalR02Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalR02Biz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 특허부서 등록유지평가 결재처리
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
        ApprovalR02Dao dao = new ApprovalR02Dao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // 연차료 리마인더 유지여부 조회
        NSingleData data = dao.retrieveCostReminderKeepYn(apprKey);

        String refId = data.getString("REF_ID");

        if (data.getString("KEEP_YN").equals("1") != true) {
            // 진행서류 생성
            docBiz.init(refId);
            docBiz.setEvent("COST_REMINDER_KEEP_ABANDON");
            docBiz.create();
        }

        dao.updateEvalComMstPatdeptEndYn(apprKey);
        dao.updateAnnualReminderEvalEndYn(apprKey);
    }
}
