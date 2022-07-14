package anyfive.ipims.office.common.popup.viewer.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.office.common.popup.viewer.biz.PopupViewerBiz;

/**
 * 출원정보조회 By REF_ID
 */
public class RetrieveAbstractInfo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PopupViewerBiz biz = new PopupViewerBiz(nsr);
        NSingleData result = biz.retrieveAbstractInfo(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, xReq.getParam("_DS_ID_"));
    }
}
