package anyfive.ipims.patent.applymgt.intpatent.bizflow.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.intpatent.bizflow.biz.IntPatentBizFlowBiz;

/**
 * 국내특허 업무흐름 목록 조회
 */
public class RetrieveIntPatentBizFlowList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntPatentBizFlowBiz biz = new IntPatentBizFlowBiz(nsr);
        NSingleData result = biz.retrieveIntPatentBizFlowList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
