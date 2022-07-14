package anyfive.ipims.patent.search.outsearch.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.search.outsearch.dao.OutSearchDao;

public class OutSearchBiz extends NAbstractServletBiz
{
    public OutSearchBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * KIPRIS DB 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveKiprisSearchList(AjaxRequest xReq) throws NException
    {
        OutSearchDao dao = new OutSearchDao(this.nsr);

        return dao.retrieveKiprisSearchList(xReq);
    }

    /**
     * WIPS DB 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWipsSearchList(AjaxRequest xReq) throws NException
    {
        OutSearchDao dao = new OutSearchDao(this.nsr);

//        dao.loginWips(xReq);

        return dao.retrieveWipsSearchList(xReq);
    }
}
