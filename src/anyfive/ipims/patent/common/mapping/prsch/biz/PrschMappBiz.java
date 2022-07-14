package anyfive.ipims.patent.common.mapping.prsch.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.prsch.dao.PrschMappDao;

public class PrschMappBiz extends NAbstractServletBiz
{
    public PrschMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 선행조사 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrievePrschList(String refId, String mappDiv) throws NException
    {
        PrschMappDao dao = new PrschMappDao(this.nsr);

        return dao.retrievePrschList(refId, mappDiv);
    }

    /**
     * 선행조사 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updatePrschList(String refId, String mappDiv, NMultiData data) throws NException
    {
        PrschMappDao dao = new PrschMappDao(this.nsr);

        dao.deletePrschList(refId, mappDiv, data);
        dao.createPrschList(refId, mappDiv, data);
    }

    /**
     * 선행조사 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deletePrschListAll(String refId, String mappDiv) throws NException
    {
        PrschMappDao dao = new PrschMappDao(this.nsr);

        dao.deletePrschListAll(refId, mappDiv);
    }

    /**
     * 선행조사 목록 복제
     *
     * @param oldRefId
     * @param oldMappDiv
     * @param newRefId
     * @param newMappDiv
     * @throws NException
     */
    public void duplicatePrschList(String oldRefId, String oldMappDiv, String newRefId, String newMappDiv) throws NException
    {
        PrschMappDao dao = new PrschMappDao(this.nsr);

        dao.duplicatePrschList(oldRefId, oldMappDiv, newRefId, newMappDiv);
    }
}
