package anyfive.ipims.patent.applymgt.extpatent.orderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.extpatent.orderletter.biz.ExtPatentOrderLetterBiz;

/**
 * 오더레터 그룹정보 조회
 */
public class RetrieveExtPatentOrderLetterGroup implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtPatentOrderLetterBiz biz = new ExtPatentOrderLetterBiz(nsr);
        NSingleData result = biz.retrieveExtPatentOrderLetterGroup(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
