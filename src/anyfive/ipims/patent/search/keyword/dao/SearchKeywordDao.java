package anyfive.ipims.patent.search.keyword.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class SearchKeywordDao extends NAbstractServletDao
{
    public SearchKeywordDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 검색식 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSearchKeywordList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/search/keyword", "/retrieveSearchKeywordList");
        dao.bind(xReq);

        if (xReq.getParam("KEYWORD").equals("") != true) {
            dao.addQuery("keyword");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 검색식 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSearchKeyword(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/search/keyword", "/retrieveSearchKeyword");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 검색식 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createSearchKeyword(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/search/keyword", "/createSearchKeyword");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 검색식 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateSearchKeyword(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/search/keyword", "/updateSearchKeyword");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 검색식 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteSearchKeyword(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/search/keyword", "/deleteSearchKeyword");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
