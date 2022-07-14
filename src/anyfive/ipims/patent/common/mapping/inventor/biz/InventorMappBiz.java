package anyfive.ipims.patent.common.mapping.inventor.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.mapping.inventor.dao.InventorMappDao;

public class InventorMappBiz extends NAbstractServletBiz
{
    public InventorMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 발명자 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInventorByUserId(AjaxRequest xReq) throws NException
    {
        InventorMappDao dao = new InventorMappDao(this.nsr);

        String userId = xReq.getParam("USER_ID");

        if (userId.equals("_LOGIN_USER_")) {
            userId = this.nsr.userInfo.getUserId();
        }

        return dao.retrieveInventorByUserId(userId);
    }

    /**
     * 발명자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveInventorList(String refId) throws NException
    {
        InventorMappDao dao = new InventorMappDao(this.nsr);

        return dao.retrieveInventorList(refId);
    }

    /**
     * 발명자 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updateInventorList(String refId, NMultiData data) throws NException
    {
        InventorMappDao dao = new InventorMappDao(this.nsr);

        dao.deleteInventorList(refId, data);
        dao.createInventorList(refId, data);
        dao.updateInventorList(refId, data);
    }

    /**
     * 발명자 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deleteInventorListAll(String refId) throws NException
    {
        InventorMappDao dao = new InventorMappDao(this.nsr);

        dao.deleteInventorListAll(refId);
    }

    /**
     * 발명자 목록 복제
     *
     * @param oldRefId
     * @param newRefId
     * @throws NException
     */
    public void duplicateInventorList(String oldRefId, String newRefId) throws NException
    {
        InventorMappDao dao = new InventorMappDao(this.nsr);

        dao.duplicateInventorList(oldRefId, newRefId);
    }
}
