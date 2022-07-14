package anyfive.ipims.patent.systemmgt.patteam.outinventor.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.patteam.outinventor.biz.OutInventorMgtBiz;

/**
 * 외부발명자 목록 조회
 */
public class RetrieveOutInventorList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        OutInventorMgtBiz biz = new OutInventorMgtBiz(nsr);
        NSingleData result = biz.retrieveOutInventorList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
