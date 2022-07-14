package anyfive.ipims.patent.costmgt.slip.reject.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.slip.proc.biz.SlipProcBiz;
import anyfive.ipims.patent.costmgt.slip.reject.dao.RejectSlipDao;

public class RejectSlipBiz extends NAbstractServletBiz
{
    public RejectSlipBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 거절 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRejectSlipList(AjaxRequest xReq) throws NException
    {
        RejectSlipDao dao = new RejectSlipDao(this.nsr);

        return dao.retrieveRejectSlipList(xReq);
    }

    /**
     * 거절 전표 비용목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRejectSlipCostList(AjaxRequest xReq) throws NException
    {
        RejectSlipDao dao = new RejectSlipDao(this.nsr);

        return dao.retrieveRejectSlipCostList(xReq);
    }

    /**
     * 거절 전표 완료처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSlipProcConfirm(AjaxRequest xReq) throws NException
    {
        SlipProcBiz procBiz = new SlipProcBiz(this.nsr);

        procBiz.updateSlipProcConfirm(xReq);
    }
}
