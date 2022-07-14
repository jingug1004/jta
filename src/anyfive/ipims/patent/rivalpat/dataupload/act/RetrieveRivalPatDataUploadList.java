package anyfive.ipims.patent.rivalpat.dataupload.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.util.GridResponse;
import anyfive.ipims.patent.rivalpat.dataupload.biz.DataUploadBiz;

/**
 * Data업로드 목록 조회
 */
public class RetrieveRivalPatDataUploadList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        DataUploadBiz biz = new DataUploadBiz(nsr);
        NSingleData result = biz.retrieveRivalPatDataUploadList(xReq);
        nsr.closeConnection();

        GridResponse xRes = new GridResponse(req, res);
        xRes.flush(result);
    }
}
