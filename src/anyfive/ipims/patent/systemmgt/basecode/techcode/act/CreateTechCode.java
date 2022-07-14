package anyfive.ipims.patent.systemmgt.basecode.techcode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.techcode.biz.TechCodeBiz;

/**
 * 기술코드관리 생성
 */
public class CreateTechCode implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TechCodeBiz biz = new TechCodeBiz(nsr);
        biz.createTechCode(xReq);
        nsr.closeConnection();
    }
}
