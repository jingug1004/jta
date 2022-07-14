package anyfive.ipims.patent.common.mapping.prsch.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class PrschMappDao extends NAbstractServletDao
{
    public PrschMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 선행조사 목록 조회
     *
     * @param refId
     * @param mappDiv
     * @return
     * @throws NException
     */
    public NMultiData retrievePrschList(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prsch", "/retrievePrschList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }

    /**
     * 선행조사 목록 생성
     *
     * @param refId
     * @param mappDiv
     * @param data
     * @return
     * @throws NException
     */
    public int[] createPrschList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prsch", "/createPrsch");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 선행조사 목록 삭제
     *
     * @param refId
     * @param mappDiv
     * @param data
     * @return
     * @throws NException
     */
    public int[] deletePrschList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prsch", "/deletePrsch");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 선행조사 목록 전체 삭제
     *
     * @param refId
     * @param mappDiv
     * @return
     * @throws NException
     */
    public int deletePrschListAll(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prsch", "/deletePrschListAll");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeUpdate();
    }

    /**
     * 선행조사 목록 복제
     *
     * @param oldRefId
     * @param oldMappDiv
     * @param newRefId
     * @param newMappDiv
     * @return
     * @throws NException
     */
    public int duplicatePrschList(String oldRefId, String oldMappDiv, String newRefId, String newMappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/prsch", "/duplicatePrschList");
        dao.bind("OLD_REF_ID", oldRefId);
        dao.bind("OLD_MAPP_DIV", oldMappDiv);
        dao.bind("NEW_REF_ID", newRefId);
        dao.bind("NEW_MAPP_DIV", newMappDiv);

        return dao.executeUpdate();
    }
}
