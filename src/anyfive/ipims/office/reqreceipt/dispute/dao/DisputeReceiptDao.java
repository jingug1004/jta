package anyfive.ipims.office.reqreceipt.dispute.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DisputeReceiptDao extends NAbstractServletDao
{
    public DisputeReceiptDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 분쟁/소송의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDisputeReceiptList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/dispute", "/retrieveDisputeReceiptList");
        dao.bind(xReq);

        // 검색번호
        if (xReq.getParam("NUM_KIND").equals("") != true && xReq.getParam("NUM_TEXT").equals("") != true) {
            dao.addQuery("numText");
        }

        // 분쟁제목
        if (xReq.getParam("DISPUTE_SUBJECT").equals("") != true) {
            dao.addQuery("disputeSubject");
        }

        // 분쟁구분
        if (xReq.getParam("DISPUTE_DIV").equals("") != true) {
            dao.addQuery("disputeDiv");
        }

        // 검색일자
        if (xReq.getParam("DATE_KIND").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        // 분쟁종류
        if (xReq.getParam("DISPUTE_KIND").equals("") != true) {
            dao.addQuery("disputeKind");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 분쟁/소송의뢰접수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retreiveDisputeReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/dispute", "/retreiveDisputeReceipt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 분쟁/소송의뢰접수 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateDisputeReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/dispute", "/updateDisputeReceipt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
