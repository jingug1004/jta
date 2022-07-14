package anyfive.ipims.office.home.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.office.home.biz.HomeBiz;

/**
 * 신규 목록 조회
 */
public class RetrieveHomeRecentList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        HomeBiz biz = new HomeBiz(nsr);
        NMultiData result = biz.retrieveHomeRecentList(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);

        xRes.flush(result, "ds_recentList_" + xReq.getParam("RECENT_ID"));


    }
}
