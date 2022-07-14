package anyfive.ipims.patent.systemmgt.datahandle.assetappcancle.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.datahandle.assetappcancle.biz.AssetCancleBiz;

/**
 *  비용결재취소 목록 조회
 */
public class RetrieveAssetCancleList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AssetCancleBiz biz = new AssetCancleBiz(nsr);
        NSingleData result = biz.retrieveAssetCancleList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
