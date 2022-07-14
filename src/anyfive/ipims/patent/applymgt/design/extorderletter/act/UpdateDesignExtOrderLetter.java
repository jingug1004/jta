package anyfive.ipims.patent.applymgt.design.extorderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.extorderletter.biz.DesignExtOrderLetterBiz;

/**
 * 디자인해외출원품의 수정
 */
public class UpdateDesignExtOrderLetter implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DesignExtOrderLetterBiz biz = new DesignExtOrderLetterBiz(nsr);
        biz.updateDesignExtOrderLetter(xReq);
        nsr.closeConnection();
    }
}
