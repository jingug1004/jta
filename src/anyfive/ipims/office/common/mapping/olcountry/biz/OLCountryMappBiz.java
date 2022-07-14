package anyfive.ipims.office.common.mapping.olcountry.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.office.common.mapping.olcountry.dao.OLCountryMappDao;

public class OLCountryMappBiz extends NAbstractServletBiz
{
    public OLCountryMappBiz(NServiceResource nsr)
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
        OLCountryMappDao dao = new OLCountryMappDao(this.nsr);

        return dao.retrieveOLCountryList(olId);
    }
}
