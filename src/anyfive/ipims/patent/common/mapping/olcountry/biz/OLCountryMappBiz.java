package anyfive.ipims.patent.common.mapping.olcountry.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.olcountry.dao.OLCountryMappDao;

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

    /**
     * OL국가 목록 저장
     *
     * @param olId
     * @param data
     * @throws NException
     */
    public void updateOLCountryList(String olId, NMultiData data) throws NException
    {
        OLCountryMappDao dao = new OLCountryMappDao(this.nsr);

        dao.deleteOLCountryList(olId, data);
        dao.updateOLCountryList(olId, data);
        dao.createOLCountryList(olId, data);
    }

    /**
     * OL국가 목록 전체 삭제
     *
     * @param olId
     * @throws NException
     */
    public void deleteOLCountryListAll(String olId) throws NException
    {
        OLCountryMappDao dao = new OLCountryMappDao(this.nsr);

        dao.deleteOLCountryListAll(olId);
    }
}
