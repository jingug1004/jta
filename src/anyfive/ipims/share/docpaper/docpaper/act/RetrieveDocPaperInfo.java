package anyfive.ipims.share.docpaper.docpaper.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.share.docpaper.docpaper.biz.DocPaperBiz;

/**
 * 진행서류 정보 조회
 */
public class RetrieveDocPaperInfo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DocPaperBiz biz = new DocPaperBiz(nsr);
        NSingleData result = biz.retrieveDocPaperInfo(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_paperInfo");
    }
}
