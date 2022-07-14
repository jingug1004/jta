package anyfive.ipims.patent.common.mapping.ipbanaly.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class IpbAnalyMappDao extends NAbstractServletDao
{
    public IpbAnalyMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * IP Biz. 분석자료 맵핑 목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveIpbAnalyList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/ipbanaly", "/retrieveIpbAnalyList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }

    /**
     * IP Biz. 분석자료 맵핑 목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createIpbAnalyList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/ipbanaly", "/createIpbAnaly");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * IP Biz. 분석자료 맵핑 목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteIpbAnalyList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/ipbanaly", "/deleteIpbAnaly");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * IP Biz. 분석자료 맵핑 목록 전체 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteIpbAnalyListAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/ipbanaly", "/deleteIpbAnalyListAll");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }
}
