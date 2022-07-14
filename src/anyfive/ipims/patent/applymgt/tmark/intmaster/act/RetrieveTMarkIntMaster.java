package anyfive.ipims.patent.applymgt.tmark.intmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.tmark.intmaster.biz.TMarkIntMasterBiz;

/**
 * 상표국내출원마스터 상세조회
 */
public class RetrieveTMarkIntMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        TMarkIntMasterBiz biz = new TMarkIntMasterBiz(nsr);
        NSingleData result = biz.retrieveTMarkIntMaster(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
