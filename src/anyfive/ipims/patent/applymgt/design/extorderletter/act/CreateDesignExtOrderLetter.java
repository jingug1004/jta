package anyfive.ipims.patent.applymgt.design.extorderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.design.extorderletter.biz.DesignExtOrderLetterBiz;

/**
 * 디자인해외출원품의 신규OL작성
 */
public class CreateDesignExtOrderLetter implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignExtOrderLetterBiz biz = new DesignExtOrderLetterBiz(nsr);
        String result = biz.createDesignExtOrderLetter(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
