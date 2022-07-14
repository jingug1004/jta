package anyfive.ipims.patent.systemmgt.configure.codevalue.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.codevalue.biz.CodeValueBiz;

/**
 * 공통코드 값 삭제
 */
public class DeleteCodeValue implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CodeValueBiz biz = new CodeValueBiz(nsr);
        biz.deleteCodeValue(xReq);
        nsr.closeConnection();
    }
}
