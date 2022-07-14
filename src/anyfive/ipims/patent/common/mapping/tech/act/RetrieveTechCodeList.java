package anyfive.ipims.patent.common.mapping.tech.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.tech.biz.TechCodeMappBiz;

/**
 * 기술분류 목록 조회
 */
public class RetrieveTechCodeList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        TechCodeMappBiz biz = new TechCodeMappBiz(nsr);
        NMultiData result = biz.retrieveTechCodeList(xReq.getParam("REF_ID"), MappingDiv.NONE);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, xReq.getParam("_DS_ID_"));
    }
}
