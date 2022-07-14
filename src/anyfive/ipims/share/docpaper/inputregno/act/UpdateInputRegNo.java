package anyfive.ipims.share.docpaper.inputregno.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.docpaper.inputregno.biz.InputRegNoBiz;

/**
 * 등록정보 입력사항 저장
 */
public class UpdateInputRegNo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        InputRegNoBiz biz = new InputRegNoBiz(nsr);
        biz.updateInputRegNo(xReq);
        nsr.closeConnection();
    }
}
