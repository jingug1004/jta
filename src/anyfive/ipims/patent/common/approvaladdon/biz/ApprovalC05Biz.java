package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.dao.ApprovalC01Dao;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;

public class ApprovalC05Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalC05Biz(NServiceResource nsr)
    {
        super(nsr);
    }
    /**
     * 매각확정 품의서 결재처리
     *
     * @param apprNo
     * @param apprEvent
     * @param apprMgt
     * @throws NException
     */
    public void execute(String apprNo, NSingleData apprKey, short apprEvent, NSingleData apprMgt) throws NException
    {
        // 결재없음 , 최종승인
        if (apprEvent == ApprovalEvents.NONE || apprEvent == ApprovalEvents.AGREEALL) {
            this.updateCostSlipStatus(apprKey, apprEvent);
        }
    }

    /**
     * 결재없음 또는 최종승인 처리
     *
     * @param apprKey
     * @throws NException
     */
    private void updateCostSlipStatus(NSingleData apprKey, short apprEvent) throws NException
    {
        ApprovalC01Dao dao = new ApprovalC01Dao(this.nsr);

        dao.updateCostSlipStatus(apprKey);
    }
}
