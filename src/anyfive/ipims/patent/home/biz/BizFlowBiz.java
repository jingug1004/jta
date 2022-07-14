package anyfive.ipims.patent.home.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.home.dao.BizFlowDao;

public class BizFlowBiz extends NAbstractServletBiz
{
    public BizFlowBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업무현황 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveBizFlowCount(AjaxRequest xReq) throws NException
    {
        BizFlowDao dao = new BizFlowDao(this.nsr);

        return dao.retrieveBizFlowCount(xReq);
    }

    /**
     * 업무현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveBizFlowList(AjaxRequest xReq) throws NException
    {
        BizFlowDao dao = new BizFlowDao(this.nsr);

        return dao.retrieveBizFlowList(xReq);
    }
}
