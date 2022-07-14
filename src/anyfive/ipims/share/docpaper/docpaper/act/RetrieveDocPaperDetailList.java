package anyfive.ipims.share.docpaper.docpaper.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.share.docpaper.docpaper.biz.DocPaperBiz;

/**
 * 진행서류 상세목록 조회
 */
public class RetrieveDocPaperDetailList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DocPaperBiz biz = new DocPaperBiz(nsr);
        NSingleData result = biz.retrieveDocPaperDetailList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
