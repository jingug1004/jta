package anyfive.ipims.patent.applymgt.extpatent.orderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.extpatent.orderletter.biz.ExtPatentOrderLetterBiz;

/**
 * 오더레터 수정
 */
public class UpdateExtPatentOrderLetter implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ExtPatentOrderLetterBiz biz = new ExtPatentOrderLetterBiz(nsr);
        biz.updateExtPatentOrderLetter(xReq);
        nsr.closeConnection();
    }
}
