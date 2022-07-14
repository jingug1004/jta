package anyfive.ipims.patent.common.mapping.country.dao;

import any.core.dataset.NJobTypeEnum;
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

        dao.setQuery("/ipims/patent/common/mapping/country", "/retrieveCountryList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }

    /**
     * 국가 목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createCountryList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/country", "/createCountry");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 국가 목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteCountryList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/country", "/deleteCountry");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 국가 목록 전체 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteCountryListAll(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/country", "/deleteCountryListAll");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeUpdate();
    }
}
