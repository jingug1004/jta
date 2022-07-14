package anyfive.ipims.patent.common.mapping.prsch.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.common.mapping.prsch.biz.PrschMappBiz;

/**
 * 선행조사 맵핑목록 조회
 */
public class RetrievePrschMappingList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PrschMappBiz biz = new PrschMappBiz(nsr);
        NMultiData result = biz.retrievePrschList(xReq.getParam("REF_ID"), xReq.getParam("MAPP_DIV"));
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, xReq.getParam("_DS_ID_"));
    }
}
