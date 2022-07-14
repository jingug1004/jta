package anyfive.ipims.patent.systemmgt.menugroup.groupmenu.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.menugroup.groupmenu.biz.GroupMenuBiz;

/**
 * 그룹별 메뉴 목록 조회
 */
public class RetrieveGroupMenuList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        GroupMenuBiz biz = new GroupMenuBiz(nsr);
        NSingleData result = biz.retrieveGroupMenuList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
