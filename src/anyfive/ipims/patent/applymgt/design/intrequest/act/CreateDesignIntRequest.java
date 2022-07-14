package anyfive.ipims.patent.applymgt.design.intrequest.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.design.intrequest.biz.DesignIntRequestBiz;

/**
 * 국내디자인출원의뢰 생성
 */
public class CreateDesignIntRequest implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignIntRequestBiz biz = new DesignIntRequestBiz(nsr);
        String result = biz.createDesignIntRequest(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);

        xRes.flush(result);
    }
}
