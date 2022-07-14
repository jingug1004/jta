package anyfive.ipims.patent.systemmgt.basecode.countrymgt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CountryCodeMgtDao extends NAbstractServletDao
{
    public CountryCodeMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국가코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCountryCodeMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/countrymgt", "/retrieveCountryCodeMgtList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        if (xReq.getParam("CURRENCY_CODE").equals("") != true) {
            dao.addQuery("currencyCode");
        }

        dao.addQuery("orderBy");

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국가코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCountryCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/countrymgt", "/retrieveCountryCodeMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 국가코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCountryCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/countrymgt", "/createCountryCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 국가코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCountryCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/countrymgt", "/updateCountryCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 국가코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCountryCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/countrymgt", "/deleteCountryCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 국가코드 정렬순서 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateCountryDispOrdList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/countrymgt", "/updateCountryDispOrd");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_countryCodeList"));
    }
}
