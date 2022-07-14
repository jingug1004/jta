package anyfive.ipims.patent.search.keyword.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.search.keyword.biz.SearchKeywordBiz;

/**
 * 검색식 삭제
 */
public class DeleteSearchKeyword implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        SearchKeywordBiz biz = new SearchKeywordBiz(nsr);
        biz.deleteSearchKeyword(xReq);
        nsr.closeConnection();
    }
}
