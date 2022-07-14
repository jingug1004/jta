package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;

public class ApprovalP04Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalP04Biz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외특허출원 계속분할OL 결재처리
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
            new ApprovalP03Biz(this.nsr).execute(apprNo, apprKey, apprEvent, apprMgt);
        }
    }
}
