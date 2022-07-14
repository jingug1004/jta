package anyfive.ipims.patent.common.mapping.tech.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class TechCodeMappDao extends NAbstractServletDao
{
    public TechCodeMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 기술분류코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveTechCodeList(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/techcode", "/retrieveTechCodeList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }

    /**
     * 기술분류코드 목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createTechCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/techcode", "/createTechCode");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 기술분류코드 목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteTechCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/techcode", "/deleteTechCode");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 기술분류코드 목록 전체 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteTechCodeListAll(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/techcode", "/deleteTechCodeListAll");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeUpdate();
    }

    /**
     * 기술분류코드 목록 복제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int duplicateTechCodeList(String oldRefId, String oldMappDiv, String newRefId, String newMappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/techcode", "/duplicateTechCodeList");
        dao.bind("OLD_REF_ID", oldRefId);
        dao.bind("OLD_MAPP_DIV", oldMappDiv);
        dao.bind("NEW_REF_ID", newRefId);
        dao.bind("NEW_MAPP_DIV", newMappDiv);

        return dao.executeUpdate();
    }
}
