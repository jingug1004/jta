package anyfive.ipims.patent.common.mapping.appmc.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.appmc.dao.AppManCodeMappDao;
import anyfive.ipims.patent.common.mapping.inventor.dao.InventorMappDao;
import anyfive.ipims.patent.common.mapping.prsch.dao.PrschMappDao;

public class AppManCodeMappBiz extends NAbstractServletBiz
{
    public AppManCodeMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원인 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveAppManCodeList(String refId, String mappDiv) throws NException
    {
        AppManCodeMappDao dao = new AppManCodeMappDao(this.nsr);

        return dao.retrieveAppManCodeList(refId, mappDiv);
    }

    /**
     * 출원인 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updateAppManCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {
        AppManCodeMappDao dao = new AppManCodeMappDao(this.nsr);

        dao.deleteAppManCodeList(refId, mappDiv, data);
        dao.createAppManCodeList(refId, mappDiv, data);
    }


    public void updateInventorList(String refId, NMultiData data) throws NException
    {
        InventorMappDao dao = new InventorMappDao(this.nsr);

        dao.deleteInventorList(refId, data);
        dao.createInventorList(refId, data);
        dao.updateInventorList(refId, data);
    }

    /**
     * 출원인 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deletePrschListAll(String refId, String mappDiv) throws NException
    {
        PrschMappDao dao = new PrschMappDao(this.nsr);

        dao.deletePrschListAll(refId, mappDiv);
    }
}
