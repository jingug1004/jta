package anyfive.ipims.office.reqreceipt.dispute.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.common.mapping.otherinfo.biz.OtherInfoMappBiz;
import anyfive.ipims.office.reqreceipt.dispute.dao.DisputeReceiptDao;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class DisputeReceiptBiz extends NAbstractServletBiz
{
    public DisputeReceiptBiz(NServiceResource nsr)
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
        DisputeReceiptDao dao = new DisputeReceiptDao(this.nsr);

        return dao.retrieveDisputeReceiptList(xReq);
    }

    /**
     * 분쟁/소송의뢰접수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDisputeReceipt(AjaxRequest xReq) throws NException
    {
        DisputeReceiptDao dao = new DisputeReceiptDao(this.nsr);
        NSingleData result = new NSingleData();

        // 분쟁(소송) 정보
        result.set("ds_mainInfo", dao.retreiveDisputeReceipt(xReq));

        // 상대정보
        OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
        result.set("ds_otherInfo", otherBiz.retrieveOtherInfoList(xReq.getParam("DISPUTE_ID")));

        return result;
    }

    /**
     * 분쟁/소송의뢰접수 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDisputeReceipt(AjaxRequest xReq) throws NException
    {
        DisputeReceiptDao dao = new DisputeReceiptDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // 분쟁/소송의뢰접수 저장
        dao.updateDisputeReceipt(xReq);

        // 진행서류 생성
        docBiz.init(xReq.getParam("DISPUTE_ID"));
        docBiz.setEvent("OFFICE_RECEIPT");
        docBiz.create();
    }
}
