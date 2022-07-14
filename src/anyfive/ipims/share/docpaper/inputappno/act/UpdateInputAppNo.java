package anyfive.ipims.share.docpaper.inputappno.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.docpaper.inputappno.biz.InputAppNoBiz;

/**
 * 출원정보 입력사항 저장
 */
public class UpdateInputAppNo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        InputAppNoBiz biz = new InputAppNoBiz(nsr);
        biz.updateInputAppNo(xReq);
        nsr.closeConnection();
    }
}
