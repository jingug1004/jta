package anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.biz.AppReqDeleteBiz;

/**
 * 출원의뢰서 삭제 처리
 */
public class DeleteAppReq implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AppReqDeleteBiz biz = new AppReqDeleteBiz(nsr);
        biz.deleteAppReq(xReq);
        nsr.closeConnection();
    }
}
