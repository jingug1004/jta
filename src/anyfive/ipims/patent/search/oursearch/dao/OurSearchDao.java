package anyfive.ipims.patent.search.oursearch.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class OurSearchDao extends NAbstractServletDao
{
    public OurSearchDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자사특허 검색 임시데이터 생성
     *
     * @param xReq
     * @param refIdList
     * @return
     * @throws NException
     */
    public int[] createOurSearchTempList(AjaxRequest xReq, NMultiData refIdList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/search/oursearch", "/createOurSearchTempList");
        dao.bind(xReq);

        return dao.executeBatch(refIdList);
    }

    /**
     * 자사특허 검색 임시데이터 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteOurSearchTempList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/search/oursearch", "/deleteOurSearchTempList");
        dao.bind(xReq);

        return dao.executeUpdate();
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/search/oursearch", "/retrieveOurSearchList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
