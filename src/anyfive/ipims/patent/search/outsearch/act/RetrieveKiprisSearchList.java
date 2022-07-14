package anyfive.ipims.patent.search.outsearch.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.search.outsearch.biz.OutSearchBiz;

/**
 * KIPRIS DB 검색
 */
public class RetrieveKiprisSearchList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        OutSearchBiz biz = new OutSearchBiz(nsr);
        NSingleData result = biz.retrieveKiprisSearchList(xReq);

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
