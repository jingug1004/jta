package anyfive.ipims.patent.applymgt.design.intmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.intmaster.biz.DesignIntMasterBiz;

/**
 * 디자인국내출원마스터 수정
 */
public class UpdateDesignIntMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignIntMasterBiz biz = new DesignIntMasterBiz(nsr);
        biz.updateDesignIntMaster(xReq);
        nsr.closeConnection();
    }
}
