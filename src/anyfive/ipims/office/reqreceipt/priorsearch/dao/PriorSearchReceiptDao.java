package anyfive.ipims.office.reqreceipt.priorsearch.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PriorSearchReceiptDao extends NAbstractServletDao
{
    public PriorSearchReceiptDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 조사의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchReceiptList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/priorsearch", "/retrievePriorSearchReceiptList");
        dao.bind(xReq);

        // 의뢰번호
        if (xReq.getParam("PRSCH_NO").equals("") != true) {
            dao.addQuery("prschNo");
        }

        // 의뢰인
        if (xReq.getParam("REQ_USER").equals("") != true) {
            dao.addQuery("reqUser");
        }

        // 의뢰제목
        if (xReq.getParam("PRSCH_SUBJECT").equals("") != true) {
            dao.addQuery("prschSubject");
        }

        // 의뢰일
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        // 진행상태
        if (xReq.getParam("RECEIPT_STATUS").equals("") != true) {
            if (xReq.getParam("RECEIPT_STATUS").equals("0")) {
                dao.addQuery("receiptNo");
            }
            if (xReq.getParam("RECEIPT_STATUS").equals("1")) {
                dao.addQuery("receiptYes");
            }
            if (xReq.getParam("RECEIPT_STATUS").equals("2")) {
                dao.addQuery("receiptResult");
            }
        }

        // 조사구분
        if (xReq.getParam("PRSCH_DIV").equals("") != true) {
            dao.addQuery("prschDiv");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 조사의뢰접수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/priorsearch", "/retrievePriorSearchReceipt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 조사의뢰접수 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePriorSearchReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/priorsearch", "/updatePriorSearchReceipt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 조사의뢰결과 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/priorsearch", "/retrievePriorSearchResult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 조사의뢰결과 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPriorSearchResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/priorsearch", "/createPriorSearchResult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 조사의뢰결과 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePriorSearchResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/priorsearch", "/updatePriorSearchResult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 조사결과 완료
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePriorSearchComplete(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/priorsearch", "/updatePriorSearchComplete");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 조사결과 통보메일 발송정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchInformMailInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/reqreceipt/priorsearch", "/retrievePriorSearchInformMailInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }
}
