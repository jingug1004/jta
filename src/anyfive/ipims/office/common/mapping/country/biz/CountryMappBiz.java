package anyfive.ipims.office.common.mapping.country.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.office.common.mapping.country.dao.CountryMappDao;

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
}
