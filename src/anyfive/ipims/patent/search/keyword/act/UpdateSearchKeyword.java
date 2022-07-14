package anyfive.ipims.patent.search.keyword.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.search.keyword.biz.SearchKeywordBiz;

/**
 * 검색식 수정
 */
public class UpdateSearchKeyword implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        SearchKeywordBiz biz = new SearchKeywordBiz(nsr);
        biz.updateSearchKeyword(xReq);
        nsr.closeConnection();
    }
}
