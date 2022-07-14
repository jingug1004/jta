package anyfive.ipims.patent.applymgt.design.extgroup.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.extgroup.biz.DesignExtGroupBiz;

/**
 * 디자인해외출원품의 수정
 */
public class UpdateDesignExtGroup implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignExtGroupBiz biz = new DesignExtGroupBiz(nsr);
        biz.updateDesignExtGroup(xReq);
        nsr.closeConnection();
    }
}
