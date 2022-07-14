package anyfive.ipims.patent.statistic.viewchart.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.statistic.viewchart.biz.StatusBiz;

/**
 * 연구소별 출원/등록현황
 */
public class RetrieveStatusByLabChart implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        StatusBiz biz = new StatusBiz(nsr);
        NMultiData result = biz.retrieveStatusByLabChart(xReq);

        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_result");
    }
}
