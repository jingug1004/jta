package anyfive.ipims.patent.systemmgt.configure.codegroup.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.codegroup.biz.CodeGroupBiz;

/**
 * 코드그룹 삭제
 */
public class DeleteCodeGroup implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CodeGroupBiz biz = new CodeGroupBiz(nsr);
        biz.deleteCodeGroup(xReq);
        nsr.closeConnection();
    }
}
