package anyfive.ipims.patent.systemmgt.datahandle.assetappcancle.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.assetappcancle.biz.AssetCancleBiz;

/**
 *  자산거절결재 취소
 */
public class AssetCancleListU implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AssetCancleBiz biz = new AssetCancleBiz(nsr);
        biz.assetcancleListU(xReq);
        nsr.closeConnection();
    }
}
