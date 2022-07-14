package anyfive.ipims.patent.systemmgt.configure.update.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.configure.update.util.SystemUpdateUtil;

/**
 * 업데이트 파일 업로드
 */
public class CheckUpdateKey implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        if (SystemUpdateUtil.checkUpdateKey(xReq.getParam("UPDATE_KEY")) != true) return;

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush("OK");
    }
}
