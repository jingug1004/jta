package anyfive.ipims.patent.costmgt.asset.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.asset.consult.biz.AssetConsultBiz;

/**
 * 자산/거절 품의 수정
 */
public class UpdateAssetConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AssetConsultBiz biz = new AssetConsultBiz(nsr);
        biz.updateAssetConsult(xReq);
        nsr.closeConnection();
    }
}
