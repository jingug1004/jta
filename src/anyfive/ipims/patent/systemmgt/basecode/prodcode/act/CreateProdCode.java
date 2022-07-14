package anyfive.ipims.patent.systemmgt.basecode.prodcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.prodcode.biz.ProdCodeBiz;

/**
 * 제품코드 생성
 */
public class CreateProdCode implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ProdCodeBiz biz = new ProdCodeBiz(nsr);
        biz.createProdCode(xReq);
        nsr.closeConnection();
    }
}
