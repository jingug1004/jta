package anyfive.ipims.patent.common.mapping.council.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.council.dao.CouncilMappDao;

public class CouncilMappBiz  extends NAbstractServletBiz
{
    public CouncilMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 심의대상목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     *
     */
    public void updateMgtIdList(String mgtId, NMultiData data) throws NException
    {
        CouncilMappDao dao = new CouncilMappDao(this.nsr);

        dao.deleteMgtIdList(mgtId, data);
        dao.createMgtIdList(mgtId, data);
    }

    /**
     * 심의위원목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     *
     */
    public void updateReviewMemberList(String refId, NMultiData data) throws NException
    {
        CouncilMappDao dao = new CouncilMappDao(this.nsr);

        dao.deleteReviewMemberList(refId, data);
        dao.createReviewMemberList(refId, data);
    }

    /**
     * 심의대상  조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveMgtIdList(String  mgrId) throws NException
    {
        CouncilMappDao dao = new CouncilMappDao(this.nsr);

        return dao.retrieveMgtIdList(mgrId);
    }

    /**
     * 심의위원  조회 (심사요청)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveReviewMemberList(String mgrId) throws NException
    {
        CouncilMappDao dao = new CouncilMappDao(this.nsr);

        return dao.retrieveReviewMemberList(mgrId);
    }

    /**
     * 심의위원  조회 (심사평가)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveReviewMemberListEvl(String mgrId) throws NException
    {
        CouncilMappDao dao = new CouncilMappDao(this.nsr);

        return dao.retrieveReviewMemberListEvl(mgrId);
    }


    /**
     * 심의위원  삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAllMgtIdList(String mgrId, NMultiData data) throws NException
    {
        CouncilMappDao dao = new CouncilMappDao(this.nsr);

        dao.deleteAllMgtIdList(mgrId, data);
    }

    /**
     * 심의위원  삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAllReviewMemberList(String mgrId,  NMultiData data) throws NException
    {
        CouncilMappDao dao = new CouncilMappDao(this.nsr);

        dao.deleteAllReviewMemberList(mgrId, data);
    }

}
