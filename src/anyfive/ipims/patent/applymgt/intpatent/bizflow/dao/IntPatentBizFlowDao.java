package anyfive.ipims.patent.applymgt.intpatent.bizflow.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class IntPatentBizFlowDao extends NAbstractServletDao
{
    public IntPatentBizFlowDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/bizflow", "/retrieveIntPatentBizFlowCount");
        dao.bind(xReq);

        dao.replaceQuery("LIST_QUERY", "/retrieveIntPatentBizFlowList_" + xReq.getParam("WF_ID"));

        return dao.executeQueryForString();
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/bizflow", "/retrieveIntPatentBizFlowList_" + xReq.getParam("WF_ID"));
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
