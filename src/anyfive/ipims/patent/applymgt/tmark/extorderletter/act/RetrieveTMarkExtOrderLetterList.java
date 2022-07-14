package anyfive.ipims.patent.applymgt.tmark.extorderletter.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.tmark.extorderletter.biz.TMarkExtOrderLetterBiz;

/**
 * 상표해외출원 OL현황 목록 조회
 */
public class RetrieveTMarkExtOrderLetterList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        TMarkExtOrderLetterBiz biz = new TMarkExtOrderLetterBiz(nsr);
        NSingleData result = biz.retrieveTMarkExtOrderLetterList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
