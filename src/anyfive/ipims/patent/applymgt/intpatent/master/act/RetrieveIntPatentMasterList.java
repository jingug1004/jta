package anyfive.ipims.patent.applymgt.intpatent.master.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.intpatent.master.biz.IntPatentMasterBiz;

/**
 * 국내출원 마스터 목록 조회
 */
public class RetrieveIntPatentMasterList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        IntPatentMasterBiz biz = new IntPatentMasterBiz(nsr);
        NSingleData result = biz.retrieveIntPatentMasterList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
