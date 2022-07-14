package anyfive.ipims.office.common.mapping.olcountry.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class OLCountryMappDao extends NAbstractServletDao
{
    public OLCountryMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * OL국가 목록 조회
     *
     * @param olId
     * @return
     * @throws NException
     */
    public NMultiData retrieveOLCountryList(String olId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/mapping/olcountry", "/retrieveOLCountryList");
        dao.bind("OL_ID", olId);

        return dao.executeQuery();
    }
}
