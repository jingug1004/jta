package anyfive.ipims.patent.costmgt.asset.confirm.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.asset.confirm.biz.AssetConfirmBiz;

/**
 * 자산/거절 확정 취소(삭제)
 */
public class CancelAssetConfirm implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AssetConfirmBiz biz = new AssetConfirmBiz(nsr);
        biz.cancelAssetConfirm(xReq);
        nsr.closeConnection();
    }
}
