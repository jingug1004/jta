package anyfive.ipims.patent.applymgt.design.intrequest.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.intrequest.biz.DesignIntRequestBiz;

/**
 * 디자인국내출원의뢰 재작성
 */
public class RewriteDesignIntRequest implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignIntRequestBiz biz = new DesignIntRequestBiz(nsr);
        biz.rewriteDesignIntRequest(xReq);
        nsr.closeConnection();
    }
}
