package anyfive.ipims.patent.applymgt.tmark.extmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.tmark.extmaster.biz.TMarkExtMasterBiz;

/**
 * 상표 국내출원마스터 조회
 */
public class RetrieveTMarkExtMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        TMarkExtMasterBiz biz = new TMarkExtMasterBiz(nsr);
        NSingleData result = biz.retrieveTMarkExtMaster(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flushAll(result);
    }
}
