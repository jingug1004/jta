package anyfive.ipims.patent.applymgt.intpatent.bizflow.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.bizflow.dao.IntPatentBizFlowDao;

public class IntPatentBizFlowBiz extends NAbstractServletBiz
{
    public IntPatentBizFlowBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내특허 업무흐름 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveIntPatentBizFlowCount(AjaxRequest xReq) throws NException
    {
        IntPatentBizFlowDao dao = new IntPatentBizFlowDao(this.nsr);

        return dao.retrieveIntPatentBizFlowCount(xReq);
    }

    /**
     * 국내특허 업무흐름 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentBizFlowList(AjaxRequest xReq) throws NException
    {
        IntPatentBizFlowDao dao = new IntPatentBizFlowDao(this.nsr);

        return dao.retrieveIntPatentBizFlowList(xReq);
    }
}
