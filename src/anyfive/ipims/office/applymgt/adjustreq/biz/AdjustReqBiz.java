package anyfive.ipims.office.applymgt.adjustreq.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.office.applymgt.adjustreq.dao.AdjustReqDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class AdjustReqBiz extends NAbstractServletBiz
{
    public AdjustReqBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 수정요청 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAdjustReqList(AjaxRequest xReq) throws NException
    {
        AdjustReqDao dao = new AdjustReqDao(this.nsr);

        return dao.retrieveAdjustReqList(xReq);
    }

    /**
     * 수정요청 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAdjustReq(AjaxRequest xReq) throws NException
    {
        AdjustReqDao dao = new AdjustReqDao(this.nsr);

        // 수정요청 조회
        return dao.retrieveAdjustReq(xReq);
    }

    /**
     * 수정요청 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createAdjustReq(AjaxRequest xReq) throws NException
    {
        AdjustReqDao dao = new AdjustReqDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // REQ_ID 시퀀스 생성
        String reqId = seqUtil.getBizId();

        // 데이터준비
        xReq.setUserData("REQ_ID", reqId);

        // 수정요청 생성
        dao.createAdjustReq(xReq);

        // 첨부화일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_reqFile"));

        return reqId;
    }

    /**
     * 수정요청 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateAdjustReq(AjaxRequest xReq) throws NException
    {
        AdjustReqDao dao = new AdjustReqDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 수정요청 수정
        dao.updateAdjustReq(xReq);

        // 첨부화일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_reqFile"));
    }

    /**
     * 수정요청 처리결과 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAdjustReqResult(AjaxRequest xReq) throws NException
    {
        AdjustReqDao dao = new AdjustReqDao(this.nsr);

        return dao.retrieveAdjustReqResult(xReq);
    }
}
