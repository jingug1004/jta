package anyfive.ipims.patent.applymgt.common.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.applymgt.common.biz.ApplyMgtCommonBiz;

/**
 * 해외출원 마스터 탭 정보 조회
 */
public class RetrieveExtMasterTabInfo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ApplyMgtCommonBiz biz = new ApplyMgtCommonBiz(nsr);
        NSingleData result = biz.retrieveExtMasterTabInfo(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_tabInfo");
    }
}
