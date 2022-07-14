package anyfive.framework.grid.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.biz.GridConfigBiz;

/**
 * 그리드 컬럼 목록 저장
 */
public class UpdateGridColumnList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        GridConfigBiz biz = new GridConfigBiz(nsr);
        biz.updateGridColumnList(xReq);
        nsr.closeConnection();
    }
}
