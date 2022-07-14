package anyfive.ipims.office.common.mapping.country.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class CountryMappDao extends NAbstractServletDao
{
    public CountryMappDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/mapping/country", "/retrieveCountryList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }
}
