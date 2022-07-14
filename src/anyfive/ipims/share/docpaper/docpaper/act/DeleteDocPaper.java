package anyfive.ipims.share.docpaper.docpaper.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.docpaper.docpaper.biz.DocPaperBiz;

/**
 * 진행서류 삭제
 */
public class DeleteDocPaper implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        DocPaperBiz biz = new DocPaperBiz(nsr);
        biz.deleteDocPaper(xReq);
        nsr.closeConnection();
    }
}
