package anyfive.ipims.patent.costmgt.asset.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.costmgt.asset.consult.biz.AssetConsultBiz;

/**
 * 자산/거절 품의 생성
 */
public class CreateAssetConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AssetConsultBiz biz = new AssetConsultBiz(nsr);
        String result = biz.createAssetConsult(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
