package anyfive.ipims.patent.statistic.viewchart.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.statistic.viewchart.biz.StatusBiz;

/**
 * 국가별 현황 상세 리스트(등록)
 */
public class RetrieveStatusByNationChartDetailReg implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        StatusBiz biz = new StatusBiz(nsr);
        NSingleData result = biz.retrieveStatusByNationChartDetailReg(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
