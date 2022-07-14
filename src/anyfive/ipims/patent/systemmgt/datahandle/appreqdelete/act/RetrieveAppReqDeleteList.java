package anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.biz.AppReqDeleteBiz;

/**
 * 출원의뢰서 삭제 목록 조회
 */
public class RetrieveAppReqDeleteList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AppReqDeleteBiz biz = new AppReqDeleteBiz(nsr);
        NSingleData result = biz.retrieveAppReqDeleteList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
