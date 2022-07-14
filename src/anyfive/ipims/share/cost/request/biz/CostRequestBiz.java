package anyfive.ipims.share.cost.request.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.cost.request.dao.CostRequestDao;

public class CostRequestBiz extends NAbstractServletBiz
{
    public CostRequestBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용청구 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostRequest(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        return dao.retrieveCostRequest(xReq);
    }

    /**
     * 국내비용 상세목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntCostDetailList(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        return dao.retrieveIntCostDetailList(xReq);
    }

    /**
     * 비용청구 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCostRequest(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 비용청구 수정
        dao.updateCostRequest(xReq);

        // INVOICE 파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_invoiceFile"));
    }

    /**
     * 국내비용청구서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createIntCostRequest(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String reqId = seqUtil.getBizId();

        xReq.setUserData("REQ_ID", reqId);

        // 국내비용청구서 생성
        dao.createIntCostRequest(xReq);

        // 국내비용입력 수정(청구서ID 설정)
        dao.updateIntCostListReqId(xReq);

        return reqId;
    }

    /**
     * 국내비용청구 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteIntCostRequest(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        NSingleData mainInfo = dao.retrieveCostRequest(xReq);

        // 비용마스터 수정 (REQ_ID 삭제)
        dao.updateCostMasterReqId(xReq);

        // 비용청구 삭제
        dao.deleteCostRequest(xReq);

        // 첨부파일 삭제
        FileBiz fileBiz = new FileBiz(this.nsr);
        fileBiz.deleteFileList(mainInfo.getString("INVOICE_FILE"));
    }

    /**
     * 해외비용 INVOICE 상세목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtInvoiceDetailList(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        return dao.retrieveExtInvoiceDetailList(xReq);
    }

    /**
     * 해외비용청구서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createExtInvoiceRequest(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String reqId = seqUtil.getBizId();

        xReq.setUserData("REQ_ID", reqId);

        // 해외비용청구서 생성
        dao.createExtCostRequest(xReq);

        // 해외비용 INVOICE 수정(청구서ID 설정)
        dao.updateExtInvoiceListReqId(xReq);

        // 해외비용입력 수정(청구서ID 설정)
        dao.updateExtCostListReqId(xReq);

        return reqId;
    }

    /**
     * 해외비용청구 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteExtInvoiceRequest(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        NSingleData mainInfo = dao.retrieveCostRequest(xReq);

        // 비용마스터 수정 (REQ_ID 삭제)
        dao.updateCostMasterReqId(xReq);

        // 해외INVOICE 수정 (REQ_ID 삭제)
        dao.updateExtInvoiceReqId(xReq);

        // 비용청구 삭제
        dao.deleteCostRequest(xReq);

        // 첨부파일 삭제
        FileBiz fileBiz = new FileBiz(this.nsr);
        fileBiz.deleteFileList(mainInfo.getString("INVOICE_FILE"));
    }

    /**
     * 청구서 청구
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCostRequestConfirm(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        if (dao.updateCostRequestConfirm(xReq) == 0) {
            throw new NBizException("청구내용을 입력하세요.");
        }
    }

    /**
     * 국내비용 일괄확인
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntCostConfirmYn(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        dao.updateIntCostConfirmYn(xReq);
    }

    /**
     * 청구서 반려
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateReCostRequestConfirm(AjaxRequest xReq) throws NException
    {
        CostRequestDao dao = new CostRequestDao(this.nsr);

        if (dao.updateReCostRequestConfirm(xReq) == 0) {
            throw new NBizException("청구서 반려내역을 다시 확인하시기 바랍니다.");
        }
        /*
        if (dao.updateReCostRequestConfirmEtc(xReq) == 0) {
            throw new NBizException("청구서 반려내역을 다시 확인하시기 바랍니다.");
        }
        */
        NSingleData mailInfo = dao.retrieveCostRequest(xReq);
        this.createInformMail(mailInfo, dao.retrieveInformMailOfficeRecvInfo(xReq));

    }

    /**
     * 청구서 반려 알림메일 생성
     *
     * @param mailInfo
     * @param recvList
     * @throws NException
     */
    private void createInformMail(NSingleData mailInfo, NMultiData recvList) throws NException
    {
        if (recvList.getRowSize() < 1) {
            return;
        }

        MailBiz mail = new MailBiz(this.nsr);
        mail.init();
        mail.setSubject("[알림] 지재권관리시스템으로부터 [" + mailInfo.getString("REQ_SUBJECT") + "]가 반려처리되었습니다.");
        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        for (int i = 0; i < recvList.getRowSize(); i++) {
            mail.addTo(recvList.getString(i, "TO_ADDR"), recvList.getString(i, "TO_NAME"));
        }
        mail.template.init("/cost/inform");
        mail.template.setValue("SUBJECT", mail.getSubject());
        mail.template.setData(mailInfo);
        mail.create();
    }

}
