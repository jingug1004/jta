package anyfive.ipims.patent.common.mapping.council.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class CouncilMappDao extends NAbstractServletDao
{
    public CouncilMappDao(NServiceResource nsr)
    {
        super(nsr);
    }


    /**
     * 심의대상  목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteMgtIdList(String mgtId,  NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/deleteMgtIdList");
        dao.bind("MGT_ID", mgtId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }


    /**
     * 심의대상  목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createMgtIdList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/createMgtIdList");
        dao.bind("MGT_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 심의위원  목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteReviewMemberList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/deleteReviewMemberList");
        dao.bind("MGT_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }


    /**
     * 심의위원  목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createReviewMemberList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/createReviewMemberList");
        dao.bind("MGT_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 심의대상 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveMgtIdList(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/retrieveMgtIdList");
        dao.bind("MGT_ID", mgtId);

        return dao.executeQuery();
    }

    /**
     * 심의위원 조회(심사요청)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveReviewMemberList(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/retrieveReviewMemberList");
        dao.bind("MGT_ID", mgtId);

        return dao.executeQuery();
    }

    /**
     * 심의위원 조회(심사평가)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveReviewMemberListEvl(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/retrieveReviewMemberListEvl");
        dao.bind("MGT_ID", mgtId);

        return dao.executeQuery();
    }

    /**
     * 심의대상  전체 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteAllMgtIdList(String mgtId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/deleteAllMgtIdList");
        dao.bind("MGT_ID", mgtId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }



    /**
     * 심의대상  전체 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteAllReviewMemberList(String mgtId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/council", "/deleteAllReviewMemberList");
        dao.bind("MGT_ID", mgtId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }



}
