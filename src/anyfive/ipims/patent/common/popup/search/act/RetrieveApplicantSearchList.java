package anyfive.ipims.patent.common.popup.search.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NDataProtocol;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.popup.search.biz.PopupSearchBiz;
import anyfive.ipims.patent.common.popup.search.util.PopupSearchUtil;

/**
 * 출원인 검색
 */
public class RetrieveApplicantSearchList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        PopupSearchBiz biz = new PopupSearchBiz(nsr);
        NDataProtocol result = biz.retrieveApplicantSearchList(xReq);
        nsr.closeConnection();

        PopupSearchUtil.flush(req, res, xReq, result);
    }
}
