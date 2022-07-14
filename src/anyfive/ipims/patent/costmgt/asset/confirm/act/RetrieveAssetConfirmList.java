package anyfive.ipims.patent.costmgt.asset.confirm.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.asset.confirm.biz.AssetConfirmBiz;

/**
 * 자산/거절 처리 목록 조회
 */
public class RetrieveAssetConfirmList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AssetConfirmBiz biz = new AssetConfirmBiz(nsr);
        NSingleData result = biz.retrieveAssetConfirmList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
