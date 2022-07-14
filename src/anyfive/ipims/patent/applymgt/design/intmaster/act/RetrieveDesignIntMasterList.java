package anyfive.ipims.patent.applymgt.design.intmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.design.intmaster.biz.DesignIntMasterBiz;

/**
 * 디자인국내출원 마스터 조회
 */
public class RetrieveDesignIntMasterList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DesignIntMasterBiz biz = new DesignIntMasterBiz(nsr);
        NSingleData result = biz.retrieveDesignIntMasterList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
