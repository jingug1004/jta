package anyfive.ipims.patent.systemmgt.basecode.countrymgt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.countrymgt.biz.CountryCodeMgtBiz;

/**
 * 국가코드 정렬순서 저장
 */
public class UpdateCountryDispOrdList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CountryCodeMgtBiz biz = new CountryCodeMgtBiz(nsr);
        biz.updateCountryDispOrdList(xReq);
        nsr.closeConnection();
    }
}
