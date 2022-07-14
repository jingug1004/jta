package anyfive.ipims.patent.applymgt.intpatent.master.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.master.biz.IntPatentMasterBiz;

/**
 * 국내출원마스터 수정
 */
public class UpdateIntPatentMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        IntPatentMasterBiz biz = new IntPatentMasterBiz(nsr);
        biz.updateIntPatentMaster(xReq);
        nsr.closeConnection();
    }
}
