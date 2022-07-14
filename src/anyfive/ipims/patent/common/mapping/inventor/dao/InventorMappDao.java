package anyfive.ipims.patent.common.mapping.inventor.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class InventorMappDao extends NAbstractServletDao
{
    public InventorMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 발명자 조회
     *
     * @param userId
     * @return
     * @throws NException
     */
    public NSingleData retrieveInventorByUserId(String userId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/inventor", "/retrieveInventorByUserId");
        dao.bind("USER_ID", userId);

        return dao.executeQueryForSingle();
    }

    /**
     * 발명자 목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveInventorList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/inventor", "/retrieveInventorList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }

    /**
     * 발명자 목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createInventorList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/inventor", "/createInventor");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 발명자 목록 수정
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] updateInventorList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/inventor", "/updateInventor");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.UPDATE);
    }

    /**
     * 발명자 목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteInventorList(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/inventor", "/deleteInventor");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 발명자 목록 전체 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteInventorListAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/inventor", "/deleteInventorListAll");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 발명자 목록 복제
     *
     * @param oldRefId
     * @param newRefId
     * @return
     * @throws NException
     */
    public int duplicateInventorList(String oldRefId, String newRefId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/inventor", "/duplicateInventorList");
        dao.bind("OLD_REF_ID", oldRefId);
        dao.bind("NEW_REF_ID", newRefId);

        return dao.executeUpdate();
    }
}
