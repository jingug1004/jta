package anyfive.ipims.patent.systemmgt.patteam.labmgt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.labmgt.biz.LabMgtBiz;

/**
 * 연구소정보관리 수정
 */
public class UpdateLabMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        LabMgtBiz biz = new LabMgtBiz(nsr);
        biz.updateLabMgt(xReq);
        nsr.closeConnection();
    }
}
