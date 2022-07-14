package anyfive.ipims.patent.applymgt.extpatent.bizflow.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.extpatent.bizflow.dao.ExtPatentBizFlowDao;

public class ExtPatentBizFlowBiz extends NAbstractServletBiz
{
    public ExtPatentBizFlowBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외특허 업무흐름 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveExtPatentBizFlowCount(AjaxRequest xReq) throws NException
    {
        ExtPatentBizFlowDao dao = new ExtPatentBizFlowDao(this.nsr);

        return dao.retrieveExtPatentBizFlowCount(xReq);
    }

    /**
     * 해외특허 업무흐름 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentBizFlowList(AjaxRequest xReq) throws NException
    {
        ExtPatentBizFlowDao dao = new ExtPatentBizFlowDao(this.nsr);

        return dao.retrieveExtPatentBizFlowList(xReq);
    }
}
