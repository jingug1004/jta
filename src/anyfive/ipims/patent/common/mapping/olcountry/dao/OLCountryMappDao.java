package anyfive.ipims.patent.common.mapping.olcountry.dao;

import any.core.dataset.NJobTypeEnum;
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

        dao.setQuery("/ipims/patent/common/mapping/olcountry", "/retrieveOLCountryList");
        dao.bind("OL_ID", olId);

        return dao.executeQuery();
    }

    /**
     * OL국가 목록 생성
     *
     * @param olId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createOLCountryList(String olId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/olcountry", "/createOLCountry");
        dao.bind("OL_ID", olId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * OL국가 목록 수정
     *
     * @param olId
     * @param data
     * @return
     * @throws NException
     */
    public int[] updateOLCountryList(String olId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/olcountry", "/updateOLCountry");
        dao.bind("OL_ID", olId);

        return dao.executeBatch(data, NJobTypeEnum.UPDATE);
    }

    /**
     * OL국가 목록 삭제
     *
     * @param olId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteOLCountryList(String olId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/olcountry", "/deleteOLCountry");
        dao.bind("OL_ID", olId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * OL국가 목록 전체 삭제
     *
     * @param olId
     * @return
     * @throws NException
     */
    public int deleteOLCountryListAll(String olId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/olcountry", "/deleteOLCountryListAll");
        dao.bind("OL_ID", olId);

        return dao.executeUpdate();
    }
}
