package anyfive.ipims.patent.systemmgt.configure.update.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.update.biz.SystemUpdateBiz;

/**
 * 업데이트 파일 삭제
 */
public class DeleteUpdateFile implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        SystemUpdateBiz biz = new SystemUpdateBiz(nsr);
        biz.deleteUpdateFile(xReq);
    }
}
