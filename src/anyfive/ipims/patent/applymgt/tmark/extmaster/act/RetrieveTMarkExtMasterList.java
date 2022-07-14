package anyfive.ipims.patent.applymgt.tmark.extmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.tmark.extmaster.biz.TMarkExtMasterBiz;

/**
 * 상표해외출원 마스터 조회
 */
public class RetrieveTMarkExtMasterList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        TMarkExtMasterBiz biz = new TMarkExtMasterBiz(nsr);
        NSingleData result = biz.retrieveTMarkExtMasterList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
