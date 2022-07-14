package anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.biz.AppReqDeleteBiz;

/**
 * 출원의뢰서 삭제 내역 조회
 */
public class RetrieveAppReqDelete implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        AppReqDeleteBiz biz = new AppReqDeleteBiz(nsr);
        NSingleData result = biz.retrieveAppReqDelete(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_mainInfo");
    }
}
