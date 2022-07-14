package anyfive.ipims.patent.applymgt.tmark.extorderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.tmark.extorderletter.biz.TMarkExtOrderLetterBiz;

/**
 * 상표해외출원품의 OL상세 조회
 */
public class RetrieveTMarkExtOrderLetter implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        TMarkExtOrderLetterBiz biz = new TMarkExtOrderLetterBiz(nsr);
        NSingleData result = biz.retrieveTMarkExtOrderLetter(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
