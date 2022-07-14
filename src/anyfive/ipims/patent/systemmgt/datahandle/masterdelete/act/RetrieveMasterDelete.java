package anyfive.ipims.patent.systemmgt.datahandle.masterdelete.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.datahandle.masterdelete.biz.MasterDeleteBiz;

/**
 * 출원마스터 삭제 내역 조회
 */
public class RetrieveMasterDelete implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        MasterDeleteBiz biz = new MasterDeleteBiz(nsr);
        NSingleData result = biz.retrieveMasterDelete(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_mainInfo");
    }
}
