package anyfive.ipims.patent.common.mapping.prod.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ProdCodeMappDao extends NAbstractServletDao
{
    public ProdCodeMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 제품코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveProdCodeList(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prodcode", "/retrieveProdCodeList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }

    /**
     * 제품코드 목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createProdCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prodcode", "/createProdCode");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 제품코드 목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteProdCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prodcode", "/deleteProdCode");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 제품코드 목록 전체 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteProdCodeListAll(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prodcode", "/deleteProdCodeListAll");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeUpdate();
    }

    /**
     * 제품코드 목록 복제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int duplicateProdCodeList(String oldRefId, String oldMappDiv, String newRefId, String newMappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prodcode", "/duplicateProdCodeList");
        dao.bind("OLD_REF_ID", oldRefId);
        dao.bind("OLD_MAPP_DIV", oldMappDiv);
        dao.bind("NEW_REF_ID", newRefId);
        dao.bind("NEW_MAPP_DIV", newMappDiv);

        return dao.executeUpdate();
    }
}
