package anyfive.ipims.patent.common.mapping.ipbanaly.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.ipbanaly.dao.IpbAnalyMappDao;

public class IpbAnalyMappBiz extends NAbstractServletBiz
{
    public IpbAnalyMappBiz(NServiceResource nsr)
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
        IpbAnalyMappDao dao = new IpbAnalyMappDao(this.nsr);

        return dao.retrieveIpbAnalyList(refId);
    }

    /**
     * IP Biz. 분석자료 맵핑 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updateIpbAnalyList(String refId, NMultiData data) throws NException
    {
        IpbAnalyMappDao dao = new IpbAnalyMappDao(this.nsr);

        dao.deleteIpbAnalyList(refId, data);
        dao.createIpbAnalyList(refId, data);
    }

    /**
     * IP Biz. 분석자료 맵핑 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deleteIpbAnalyListAll(String refId) throws NException
    {
        IpbAnalyMappDao dao = new IpbAnalyMappDao(this.nsr);

        dao.deleteIpbAnalyListAll(refId);
    }
}
