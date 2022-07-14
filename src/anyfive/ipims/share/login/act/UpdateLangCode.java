package anyfive.ipims.share.login.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

/**
 * 언어 변경
 */
public class UpdateLangCode implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        SessionUtil.setLangCode(req, xReq.getParam("LANG_CODE"));
    }
}
