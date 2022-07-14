package anyfive.ipims.patent.common.popup.viewer.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.common.popup.viewer.biz.PopupViewerBiz;

/**
 * 국내건의 해외출원 현황 목록 조회
 */
public class RetrieveExtApplyByIntList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PopupViewerBiz biz = new PopupViewerBiz(nsr);
        NSingleData result = biz.retrieveExtApplyByIntList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
