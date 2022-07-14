package anyfive.ipims.patent.applymgt.design.intconsult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.intconsult.biz.DesignIntConsultBiz;

/**
 * 디자인국내출원품의 특허검토 작성
 */
public class UpdateDesignIntConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignIntConsultBiz biz = new DesignIntConsultBiz(nsr);
        biz.updateDesignIntConsult(xReq);
        nsr.closeConnection();
    }
}
