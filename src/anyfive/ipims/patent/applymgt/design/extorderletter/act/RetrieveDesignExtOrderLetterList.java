package anyfive.ipims.patent.applymgt.design.extorderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.design.extorderletter.biz.DesignExtOrderLetterBiz;

/**
 * 디자인해외출원 OL현황 목록 조회
 */
public class RetrieveDesignExtOrderLetterList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DesignExtOrderLetterBiz biz = new DesignExtOrderLetterBiz(nsr);
        NSingleData result = biz.retrieveDesignExtOrderLetterList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
