package anyfive.ipims.patent.applymgt.common.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.common.biz.ApplyMgtCommonBiz;

/**
 * 국내출원 의뢰서 수정가능 여부 조회
 */
public class RetrieveIntRequestEditAvail implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ApplyMgtCommonBiz biz = new ApplyMgtCommonBiz(nsr);
        String result = biz.retrieveIntRequestEditAvail(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result);
    }
}
