package anyfive.ipims.patent.systemmgt.menugroup.groupuser.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.menugroup.groupuser.biz.GroupUserBiz;

/**
 * 그룹별 사용자 목록 삭제
 */
public class DeleteGroupUserList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        GroupUserBiz biz = new GroupUserBiz(nsr);
        biz.deleteGroupUserList(xReq);
        nsr.closeConnection();
    }
}
