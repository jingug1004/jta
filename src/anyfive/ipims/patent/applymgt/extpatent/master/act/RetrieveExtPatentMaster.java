package anyfive.ipims.patent.applymgt.extpatent.master.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.extpatent.master.biz.ExtPatentMasterBiz;

/**
 * 해외출원마스터 조회
 */
public class RetrieveExtPatentMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtPatentMasterBiz biz = new ExtPatentMasterBiz(nsr);
        NSingleData result = biz.retrieveExtPatentMaster(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
