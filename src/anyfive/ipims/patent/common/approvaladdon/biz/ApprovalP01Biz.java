package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.dao.ApprovalP01Dao;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;

public class ApprovalP01Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalP01Biz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내특허출원 의뢰 결재처리
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
        ApprovalP01Dao dao = new ApprovalP01Dao(this.nsr);

        if (dao.updateIntPatentConsult(apprKey) == 0) {
            dao.updateIntPatentPatteamReqDate(apprKey);
        }
    }
}
