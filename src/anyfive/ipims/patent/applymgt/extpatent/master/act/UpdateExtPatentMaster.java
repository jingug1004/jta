package anyfive.ipims.patent.applymgt.extpatent.master.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.extpatent.master.biz.ExtPatentMasterBiz;

/**
 * 해외출원마스터 수정
 */
public class UpdateExtPatentMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ExtPatentMasterBiz biz = new ExtPatentMasterBiz(nsr);
        biz.updateExtPatentMaster(xReq);
        nsr.closeConnection();
    }
}
