package anyfive.ipims.patent.systemmgt.officemgt.main.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class OfficeMgtMainDao extends NAbstractServletDao
{
    public OfficeMgtMainDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사무소 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeMgtMainList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/main", "/retrieveOfficeMgtMainList");
        dao.bind(xReq);

        if (xReq.getParam("COUNTRY_CODE").equals("") != true) {
            dao.addQuery("countryCode");
        }

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 사무소 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeMgtMain(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/main", "/retrieveOfficeMgtMain");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 사무소 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createOfficeMgtMain(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/main", "/createOfficeMgtMain");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 사무소 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateOfficeMgtMain(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/main", "/updateOfficeMgtMain");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 사무소 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteOfficeMgtMain(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/officemgt/main", "/deleteOfficeMgtMain");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
