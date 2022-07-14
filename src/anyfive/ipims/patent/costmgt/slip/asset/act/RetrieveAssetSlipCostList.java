package anyfive.ipims.patent.costmgt.slip.asset.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.costmgt.slip.asset.biz.AssetSlipBiz;

/**
 * 자산/거절 전표 비용목록 조회
 */
public class RetrieveAssetSlipCostList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AssetSlipBiz biz = new AssetSlipBiz(nsr);
        NSingleData result = biz.retrieveAssetSlipCostList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
