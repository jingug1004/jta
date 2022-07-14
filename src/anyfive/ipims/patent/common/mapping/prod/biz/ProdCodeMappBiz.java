package anyfive.ipims.patent.common.mapping.prod.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.prod.dao.ProdCodeMappDao;

public class ProdCodeMappBiz extends NAbstractServletBiz
{
    public ProdCodeMappBiz(NServiceResource nsr)
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
        ProdCodeMappDao dao = new ProdCodeMappDao(this.nsr);

        return dao.retrieveProdCodeList(refId, mappDiv);
    }

    /**
     * 제품코드 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updateProdCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {
        ProdCodeMappDao dao = new ProdCodeMappDao(this.nsr);

        dao.deleteProdCodeList(refId, mappDiv, data);
        dao.createProdCodeList(refId, mappDiv, data);
    }

    /**
     * 제품코드 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deleteProdCodeListAll(String refId, String mappDiv) throws NException
    {
        ProdCodeMappDao dao = new ProdCodeMappDao(this.nsr);

        dao.deleteProdCodeListAll(refId, mappDiv);
    }

    /**
     * 제품코드 목록 복제
     *
     * @param oldRefId
     * @param oldMappDiv
     * @param newRefId
     * @param newMappDiv
     * @throws NException
     */
    public void duplicateProdCodeList(String oldRefId, String oldMappDiv, String newRefId, String newMappDiv) throws NException
    {
        ProdCodeMappDao dao = new ProdCodeMappDao(this.nsr);

        dao.duplicateProdCodeList(oldRefId, oldMappDiv, newRefId, newMappDiv);
    }
}
