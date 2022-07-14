package anyfive.ipims.patent.systemmgt.menugroup.menucode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.menugroup.menucode.biz.MenuCodeBiz;

/**
 * 메뉴관리 삭제
 */
public class DeleteMenuCode implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        MenuCodeBiz biz = new MenuCodeBiz(nsr);
        biz.deleteMenuCode(xReq);
        nsr.closeConnection();
    }
}
