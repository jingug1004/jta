package anyfive.ipims.patent.statistic.office.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.statistic.office.biz.OfficeEvalMasterBiz;

/**
 * 세부평가항목조회
 */
public class RetrieveEvalItem implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        OfficeEvalMasterBiz biz = new OfficeEvalMasterBiz(nsr);
        NMultiData result = biz.retrieveEvalItem(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_officeEvalList");
    }
}
