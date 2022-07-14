package anyfive.ipims.patent.ipbiz.history.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class IpBizHistoryDao extends NAbstractServletDao
{
    public IpBizHistoryDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * History 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpBizHistoryList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/history", "/retrieveIpBizHistoryList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * History 상세조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpBizHistory(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/history", "/retrieveIpBizHistory");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * History 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createIpBizHistory(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/history", "/createIpBizHistory");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * History 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateIpBizHistory(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/history", "/updateIpBizHistory");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * History 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteIpBizHistory(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/history", "/deleteIpBizHistory");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * History 전체삭제 목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveIpBizHistoryListAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/history", "/retrieveIpBizHistoryList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }

    /**
     * History 전체삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteIpBizHistoryAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/history", "/deleteIpBizHistoryAll");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

}
