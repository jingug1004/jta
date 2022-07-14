package anyfive.ipims.patent.common.mapping.tmarkcls.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class TMarkClsMappDao extends NAbstractServletDao
{
    public TMarkClsMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상품류 목록 조회
     *
     * @param refId
     * @param mappDiv
     * @return
     * @throws NException
     */
    public NMultiData retrieveTMarkClsList(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/tmarkcls", "/retrieveTMarkClsList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }

    /**
     * 상품류 목록 생성
     *
     * @param refId
     * @param mappDiv
     * @param data
     * @return
     * @throws NException
     */
    public int[] createTMarkClsList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/tmarkcls", "/createTMarkCls");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data);
    }

    /**
     * 상품류 목록 전체 삭제
     *
     * @param refId
     * @param mappDiv
     * @return
     * @throws NException
     */
    public int deleteTMarkClsListAll(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/tmarkcls", "/deleteTMarkClsListAll");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeUpdate();
    }

    /**
     * 상품류 목록 복제
     *
     * @param oldRefId
     * @param oldMappDiv
     * @param newRefId
     * @param newMappDiv
     * @return
     * @throws NException
     */
    public int duplicateTMarkClsList(String oldRefId, String oldMappDiv, String newRefId, String newMappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/tmarkcls", "/duplicateTMarkClsList");
        dao.bind("OLD_REF_ID", oldRefId);
        dao.bind("OLD_MAPP_DIV", oldMappDiv);
        dao.bind("NEW_REF_ID", newRefId);
        dao.bind("NEW_MAPP_DIV", newMappDiv);

        return dao.executeUpdate();
    }
}
