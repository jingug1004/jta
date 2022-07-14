package anyfive.ipims.office.reqreceipt.intapply.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class IntApplyReceiptDao extends NAbstractServletDao
{
    public IntApplyReceiptDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내출원의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntApplyReceiptList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/intapply", "/retrieveIntApplyReceiptList");
        dao.bind(xReq);

        // 접수 여부
        dao.addQuery("receiptYn" + xReq.getParam("RECEIPT_YN"));

        // REF-NO
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
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
     * 국내출원의뢰접수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntApplyReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/intapply", "/retrieveIntApplyReceipt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내출원의뢰접수 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateIntApplyReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/intapply", "/updateIntApplyReceipt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
