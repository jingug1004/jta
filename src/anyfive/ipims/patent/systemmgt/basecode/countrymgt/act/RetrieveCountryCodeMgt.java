package anyfive.ipims.patent.systemmgt.basecode.countrymgt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.systemmgt.basecode.countrymgt.biz.CountryCodeMgtBiz;

/**
 * 국가코드 조회
 */
public class RetrieveCountryCodeMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        CountryCodeMgtBiz biz = new CountryCodeMgtBiz(nsr);
        NSingleData result = biz.retrieveCountryCodeMgt(xReq);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_mainInfo");
    }
}
