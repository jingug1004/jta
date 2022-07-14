package anyfive.ipims.patent.applymgt.intpatent.master.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.intpatent.master.biz.IntPatentMasterBiz;

/**
 * 국내출원 마스터 조회
 */
public class RetrieveIntPatentMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntPatentMasterBiz biz = new IntPatentMasterBiz(nsr);
        NSingleData result = biz.retrieveIntPatentMaster(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
