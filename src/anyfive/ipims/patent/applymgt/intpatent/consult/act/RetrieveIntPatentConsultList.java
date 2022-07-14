package anyfive.ipims.patent.applymgt.intpatent.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.intpatent.consult.biz.IntPatentConsultBiz;

/**
 * 국내출원품의 목록 조회
 */
public class RetrieveIntPatentConsultList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntPatentConsultBiz biz = new IntPatentConsultBiz(nsr);
        NSingleData result = biz.retrieveIntPatentConsultList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
