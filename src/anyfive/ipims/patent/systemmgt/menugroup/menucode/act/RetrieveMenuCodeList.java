package anyfive.ipims.patent.systemmgt.menugroup.menucode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.systemmgt.menugroup.menucode.biz.MenuCodeBiz;

/**
 * 메뉴관리 목록 조회
 */
public class RetrieveMenuCodeList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        MenuCodeBiz biz = new MenuCodeBiz(nsr);
        NSingleData result = biz.retrieveMenuCodeList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
