package anyfive.ipims.patent.common.mapping.otherinfo.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.otherinfo.dao.OtherInfoMappDao;

public class OtherInfoMappBiz extends NAbstractServletBiz
{
    public OtherInfoMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상대정보 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveOtherInfoList(String refId) throws NException
    {
        OtherInfoMappDao dao = new OtherInfoMappDao(this.nsr);

        return dao.retrieveOtherInfoList(refId);
    }

    /**
     * 상대정보 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updateOtherInfoList(String refId, NMultiData data) throws NException
    {
        OtherInfoMappDao dao = new OtherInfoMappDao(this.nsr);

        dao.deleteOtherInfoList(refId);
        dao.createOtherInfoList(refId, data);
    }

    /**
     * 상대정보 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deleteOtherInfoListAll(String refId) throws NException
    {
        OtherInfoMappDao dao = new OtherInfoMappDao(this.nsr);

        dao.deleteOtherInfoList(refId);
    }
}
