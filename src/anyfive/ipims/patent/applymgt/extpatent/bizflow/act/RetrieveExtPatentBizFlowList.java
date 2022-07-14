package anyfive.ipims.patent.applymgt.extpatent.bizflow.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.extpatent.bizflow.biz.ExtPatentBizFlowBiz;

/**
 * 해외특허 업무흐름 목록 조회
 */
public class RetrieveExtPatentBizFlowList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtPatentBizFlowBiz biz = new ExtPatentBizFlowBiz(nsr);
        NSingleData result = biz.retrieveExtPatentBizFlowList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
