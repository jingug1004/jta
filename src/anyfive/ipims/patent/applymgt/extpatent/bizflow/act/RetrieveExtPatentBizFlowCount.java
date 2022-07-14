package anyfive.ipims.patent.applymgt.extpatent.bizflow.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.extpatent.bizflow.biz.ExtPatentBizFlowBiz;

/**
 * 해외특허 업무흐름 건수 조회
 */
public class RetrieveExtPatentBizFlowCount implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtPatentBizFlowBiz biz = new ExtPatentBizFlowBiz(nsr);
        String result = biz.retrieveExtPatentBizFlowCount(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
