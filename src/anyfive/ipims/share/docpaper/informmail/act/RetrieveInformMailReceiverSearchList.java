package anyfive.ipims.share.docpaper.informmail.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.share.docpaper.informmail.biz.DocInformMailBiz;

/**
 * 진행서류 알림메일 수신자 목록 검색
 */
public class RetrieveInformMailReceiverSearchList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DocInformMailBiz biz = new DocInformMailBiz(nsr);
        NSingleData result = biz.retrieveInformMailReceiverSearchList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
