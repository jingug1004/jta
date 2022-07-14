package anyfive.ipims.patent.common.mapping.tech.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.tech.dao.TechCodeMappDao;

public class TechCodeMappBiz extends NAbstractServletBiz
{
    public TechCodeMappBiz(NServiceResource nsr)
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
        TechCodeMappDao dao = new TechCodeMappDao(this.nsr);

        return dao.retrieveTechCodeList(refId, mappDiv);
    }

    /**
     * 기술분류코드 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updateTechCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {
        TechCodeMappDao dao = new TechCodeMappDao(this.nsr);

        dao.deleteTechCodeList(refId, mappDiv, data);
        dao.createTechCodeList(refId, mappDiv, data);
    }

    /**
     * 기술분류코드 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deleteTechCodeListAll(String refId, String mappDiv) throws NException
    {
        TechCodeMappDao dao = new TechCodeMappDao(this.nsr);

        dao.deleteTechCodeListAll(refId, mappDiv);
    }

    /**
     * 기술분류코드 목록 복제
     *
     * @param oldRefId
     * @param oldMappDiv
     * @param newRefId
     * @param newMappDiv
     * @throws NException
     */
    public void duplicateTechCodeList(String oldRefId, String oldMappDiv, String newRefId, String newMappDiv) throws NException
    {
        TechCodeMappDao dao = new TechCodeMappDao(this.nsr);

        dao.duplicateTechCodeList(oldRefId, oldMappDiv, newRefId, newMappDiv);
    }
}
