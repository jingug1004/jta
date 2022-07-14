package anyfive.ipims.patent.applymgt.intpatent.extabd.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.intpatent.extabd.biz.ExtApplyAbdBiz;

/**
 * 해외출원 포기내역 조회
 */
public class RetrieveExtApplyAbd implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ExtApplyAbdBiz biz = new ExtApplyAbdBiz(nsr);
        NSingleData result = biz.retrieveExtApplyAbd(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_mainInfo");
    }
}
