package anyfive.ipims.patent.applymgt.docpaper.docpaperlist.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.applymgt.docpaper.docpaperlist.biz.DocPaperListBiz;

/**
 * 진행서류현황 목록 조회
 */
public class RetrieveDocPaperList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DocPaperListBiz biz = new DocPaperListBiz(nsr);
        NSingleData result = biz.retrieveDocPaperList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
