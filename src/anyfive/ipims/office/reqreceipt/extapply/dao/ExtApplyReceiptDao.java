package anyfive.ipims.office.reqreceipt.extapply.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtApplyReceiptDao extends NAbstractServletDao
{
    public ExtApplyReceiptDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtApplyReceiptList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/extapply", "/retrieveExtApplyReceiptList");
        dao.bind(xReq);

        // 접수 여부
        dao.addQuery("receiptYn" + xReq.getParam("RECEIPT_YN"));

        // 그룹번호
        if (xReq.getParam("GRP_NO").equals("") != true) {
            dao.addQuery("grpNo");
        }

        // 구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 의뢰일
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 해외출원의뢰접수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtApplyReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/extapply", "/retrieveExtApplyReceipt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 해외출원의뢰접수 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtApplyReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/extapply", "/updateExtApplyReceipt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외출원마스터 사무소 정보 저장
     *
     * @param refId
     * @param olInfo
     * @return
     * @throws NException
     */
    public int updateExtMasterOfficeInfo(String refId, NSingleData olInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/extapply", "/updateExtMasterOfficeInfo");
        dao.bind("REF_ID", refId);
        dao.bind(olInfo);

        return dao.executeUpdate();
    }

    /**
     * 해외사무소 저장
     *
     * @param refId
     * @param olInfo
     * @return
     * @throws NException
     */
    public int updateExtOffice(String refId, NSingleData olInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/extapply", "/updateExtOffice");
        dao.bind("REF_ID", refId);
        dao.bind(olInfo);

        return dao.executeUpdate();
    }
}
