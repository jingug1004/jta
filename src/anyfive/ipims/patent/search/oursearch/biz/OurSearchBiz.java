package anyfive.ipims.patent.search.oursearch.biz;

import m2.earth.util.EarthException;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.exception.NSysException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.uuid.NUUID;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.search.oursearch.dao.OurSearchDao;
import anyfive.ipims.patent.search.oursearch.util.OurSearchUtil;

public class OurSearchBiz extends NAbstractServletBiz
{
    public OurSearchBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자사특허 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOurSearchList(AjaxRequest xReq) throws NException
    {
        OurSearchDao dao = new OurSearchDao(this.nsr);

        String state = xReq.getParam("STATE");
        String andKeyword = xReq.getParam("AND_KEYWORD");
        String orKeyword = xReq.getParam("OR_KEYWORD");
        String ad = xReq.getParam("AD");
        String opd = xReq.getParam("OPD");
        String gd = xReq.getParam("GD");

        int pageSize = Integer.parseInt(xReq.getParam("PAGE_SIZE"), 10);
        int pageNo = Integer.parseInt(xReq.getParam("PAGE_NO"), 10);

        NSingleData searchResult = null;

        try {
            searchResult = OurSearchUtil.getSearchResult(andKeyword, orKeyword, ad, opd, gd, state, pageSize, pageNo);
        } catch (EarthException e) {
            throw new NSysException(e);
        }

        xReq.setUserData("WORK_ID", NUUID.randomUUID().toString().toUpperCase());

        dao.deleteOurSearchTempList(xReq);
        dao.createOurSearchTempList(xReq, (NMultiData)searchResult.get("RESULT_LIST"));
        NSingleData result = dao.retrieveOurSearchList(xReq);
        result.setInt("TOTAL_SIZE", searchResult.getInt("TOTAL_SIZE"));
        dao.deleteOurSearchTempList(xReq);

        return result;
    }
}
