package anyfive.ipims.patent.applymgt.extpatent.bizflow.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtPatentBizFlowDao extends NAbstractServletDao
{
    public ExtPatentBizFlowDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/bizflow", "/retrieveExtPatentBizFlowCount");
        dao.bind(xReq);

        dao.replaceQuery("LIST_QUERY", "/retrieveExtPatentBizFlowList_" + xReq.getParam("WF_ID"));

        return dao.executeQueryForString();
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/bizflow", "/retrieveExtPatentBizFlowList_" + xReq.getParam("WF_ID"));
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
