package anyfive.ipims.patent.applymgt.tmark.extorderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.extorderletter.biz.TMarkExtOrderLetterBiz;

/**
 * 상표해외출원품의 수정
 */
public class UpdateTMarkExtOrderLetter implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TMarkExtOrderLetterBiz biz = new TMarkExtOrderLetterBiz(nsr);
        biz.updateTMarkExtOrderLetter(xReq);
        nsr.closeConnection();
    }
}
