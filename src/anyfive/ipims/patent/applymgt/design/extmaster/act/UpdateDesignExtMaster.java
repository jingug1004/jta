package anyfive.ipims.patent.applymgt.design.extmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.extmaster.biz.DesignExtMasterBiz;

/**
 * 디자인 해외출원 수정
 */
public class UpdateDesignExtMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignExtMasterBiz biz = new DesignExtMasterBiz(nsr);
        biz.updateDesignExtMaster(xReq);
        nsr.closeConnection();
    }
}
