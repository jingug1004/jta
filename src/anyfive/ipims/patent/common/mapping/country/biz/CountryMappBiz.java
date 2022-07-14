package anyfive.ipims.patent.common.mapping.country.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.country.dao.CountryMappDao;

public class CountryMappBiz extends NAbstractServletBiz
{
    public CountryMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국가 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveCountryList(String refId, String mappDiv) throws NException
    {
        CountryMappDao dao = new CountryMappDao(this.nsr);

        return dao.retrieveCountryList(refId, mappDiv);
    }

    /**
     * 국가 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updateCountryList(String refId, String mappDiv, NMultiData data) throws NException
    {
        CountryMappDao dao = new CountryMappDao(this.nsr);

        dao.deleteCountryList(refId, mappDiv, data);
        dao.createCountryList(refId, mappDiv, data);
    }

    /**
     * 국가 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deleteCountryListAll(String refId, String mappDiv) throws NException
    {
        CountryMappDao dao = new CountryMappDao(this.nsr);

        dao.deleteCountryListAll(refId, mappDiv);
    }
}
