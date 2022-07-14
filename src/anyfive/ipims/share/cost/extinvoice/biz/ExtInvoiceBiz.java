package anyfive.ipims.share.cost.extinvoice.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.cost.extinvoice.dao.ExtInvoiceDao;

public class ExtInvoiceBiz extends NAbstractServletBiz
{
    public ExtInvoiceBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외비용 INVOICE 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createCostLetter(AjaxRequest xReq) throws NException
    {
        ExtInvoiceDao dao = new ExtInvoiceDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        if (xReq.getParam("REF_ID").equals("") || xReq.getParam("REF_ID") == null) {
            throw new NBizException("다음 필수항목을 입력하세요.\n[REF_NO]");
        }

        String letterSeq = seqUtil.getLetterSeq();

        xReq.setUserData("LETTER_SEQ", letterSeq);

        // 해외비용 INVOICE 생성
        dao.createCostLetter(xReq);

        // 해외 INVOICE 파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_extInvoiceFile"));

        return letterSeq;
    }

    /**
     * 해외비용 INVOICE 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtInvoice(AjaxRequest xReq) throws NException
    {
        ExtInvoiceDao dao = new ExtInvoiceDao(this.nsr);

        return dao.retrieveExtInvoice(xReq);
    }

    /**
     * 해외비용 INVOICE 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtInvoice(AjaxRequest xReq) throws NException
    {
        ExtInvoiceDao dao = new ExtInvoiceDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 해외비용 INVOICE 수정
        dao.updateExtInvoice(xReq);

        // 해외 INVOICE 파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_extInvoiceFile"));
    }

    /**
     * 해외비용 INVOICE 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteExtInvoice(AjaxRequest xReq) throws NException
    {
        ExtInvoiceDao dao = new ExtInvoiceDao(this.nsr);

        NSingleData mainInfo = dao.retrieveExtInvoice(xReq);

        // INVOICE별 해외비용입력목록 삭제
        dao.deleteExtCostByLetterSeq(xReq);

        // 해외비용 INVOICE 삭제
        dao.deleteExtInvoice(xReq);

        // 첨부파일 삭제
        FileBiz fileBiz = new FileBiz(this.nsr);
        fileBiz.deleteFileList(mainInfo.getString("EXT_INVOICE_FILE"));
    }

    /**
     * 해외비용 상세목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtCostDetailList(AjaxRequest xReq) throws NException
    {
        ExtInvoiceDao dao = new ExtInvoiceDao(this.nsr);

        return dao.retrieveExtCostDetailList(xReq);
    }

    /**
     * 해외비용 일괄확인
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtCostConfirmYn(AjaxRequest xReq) throws NException
    {
        ExtInvoiceDao dao = new ExtInvoiceDao(this.nsr);

        dao.updateExtCostConfirmYn(xReq);
    }
}
