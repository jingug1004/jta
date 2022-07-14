package anyfive.ipims.patent.systemmgt.menugroup.groupmenu.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.menugroup.groupmenu.biz.GroupMenuBiz;

/**
 * 그룹별 메뉴 목록 수정
 */
public class UpdateGroupMenuList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        GroupMenuBiz biz = new GroupMenuBiz(nsr);
        biz.updateGroupMenuList(xReq);
        nsr.closeConnection();
    }
}
