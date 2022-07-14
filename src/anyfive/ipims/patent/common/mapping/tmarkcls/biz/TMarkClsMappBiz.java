package anyfive.ipims.patent.common.mapping.tmarkcls.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.tmarkcls.dao.TMarkClsMappDao;

public class TMarkClsMappBiz extends NAbstractServletBiz
{
    public TMarkClsMappBiz(NServiceResource nsr)
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
        TMarkClsMappDao dao = new TMarkClsMappDao(this.nsr);

        return dao.retrieveTMarkClsList(refId, mappDiv);
    }

    /**
     * 상품류 목록 저장
     *
     * @param refId
     * @param mappDiv
     * @param data
     * @throws NException
     */
    public void updateTMarkClsList(String refId, String mappDiv, NMultiData data) throws NException
    {
        TMarkClsMappDao dao = new TMarkClsMappDao(this.nsr);

        dao.deleteTMarkClsListAll(refId, mappDiv);
        dao.createTMarkClsList(refId, mappDiv, data);
    }

    /**
     * 상품류 목록 전체 삭제
     *
     * @param refId
     * @param mappDiv
     * @throws NException
     */
    public void deleteTMarkClsListAll(String refId, String mappDiv) throws NException
    {
        TMarkClsMappDao dao = new TMarkClsMappDao(this.nsr);

        dao.deleteTMarkClsListAll(refId, mappDiv);
    }

    /**
     * 상품류 목록 복제
     *
     * @param oldRefId
     * @param oldMappDiv
     * @param newRefId
     * @param newMappDiv
     * @throws NException
     */
    public void duplicateTMarkClsList(String oldRefId, String oldMappDiv, String newRefId, String newMappDiv) throws NException
    {
        TMarkClsMappDao dao = new TMarkClsMappDao(this.nsr);

        dao.duplicateTMarkClsList(oldRefId, oldMappDiv, newRefId, newMappDiv);
    }
}
