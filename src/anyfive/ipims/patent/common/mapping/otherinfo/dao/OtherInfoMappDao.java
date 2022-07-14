package anyfive.ipims.patent.common.mapping.otherinfo.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class OtherInfoMappDao extends NAbstractServletDao
{
    public OtherInfoMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상대정보 목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveOtherInfoList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/otherinfo", "/retrieveOtherInfoList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }

    /**
     * 상대정보 목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createOtherInfoList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/otherinfo", "/createOtherInfo");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 상대정보 목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int deleteOtherInfoList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/otherinfo", "/deleteOtherInfo");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

}
