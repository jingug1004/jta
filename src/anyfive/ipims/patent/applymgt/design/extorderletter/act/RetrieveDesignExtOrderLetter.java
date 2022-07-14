package anyfive.ipims.patent.applymgt.design.extorderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.design.extorderletter.biz.DesignExtOrderLetterBiz;

/**
 * 디자인해외출원품의 OL상세 조회
 */
public class RetrieveDesignExtOrderLetter implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DesignExtOrderLetterBiz biz = new DesignExtOrderLetterBiz(nsr);
        NSingleData result = biz.retrieveDesignExtOrderLetter(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
