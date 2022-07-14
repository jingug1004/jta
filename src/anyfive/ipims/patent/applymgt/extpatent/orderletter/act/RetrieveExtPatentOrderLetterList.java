package anyfive.ipims.patent.applymgt.extpatent.orderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.extpatent.orderletter.biz.ExtPatentOrderLetterBiz;

/**
 * 오더레터 목록 조회
 */
public class RetrieveExtPatentOrderLetterList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtPatentOrderLetterBiz biz = new ExtPatentOrderLetterBiz(nsr);
        NSingleData result = biz.retrieveExtPatentOrderLetterList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
