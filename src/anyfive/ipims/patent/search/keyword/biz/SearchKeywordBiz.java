package anyfive.ipims.patent.search.keyword.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.search.keyword.dao.SearchKeywordDao;

public class SearchKeywordBiz extends NAbstractServletBiz
{
    public SearchKeywordBiz(NServiceResource nsr)
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
        SearchKeywordDao dao = new SearchKeywordDao(this.nsr);

        return dao.retrieveSearchKeywordList(xReq);
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
        SearchKeywordDao dao = new SearchKeywordDao(this.nsr);

        return dao.retrieveSearchKeyword(xReq);
    }

    /**
     * 검색식 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createSearchKeyword(AjaxRequest xReq) throws NException
    {
        SearchKeywordDao dao = new SearchKeywordDao(this.nsr);

        if (dao.createSearchKeyword(xReq) == 0) {
            throw new NBizException("이미 저장된 검색식입니다.");
        }
    }

    /**
     * 검색식 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSearchKeyword(AjaxRequest xReq) throws NException
    {
        SearchKeywordDao dao = new SearchKeywordDao(this.nsr);

        dao.updateSearchKeyword(xReq);
    }

    /**
     * 검색식 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteSearchKeyword(AjaxRequest xReq) throws NException
    {
        SearchKeywordDao dao = new SearchKeywordDao(this.nsr);

        dao.deleteSearchKeyword(xReq);
    }
}
