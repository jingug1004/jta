package anyfive.ipims.patent.applymgt.priorjob.officereq.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.priorjob.officereq.dao.PriorJobOfficeReqDao;

public class PriorJobOfficeReqBiz extends NAbstractServletBiz
{
    public PriorJobOfficeReqBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사무소요청사항 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorJobOfficeReqList(AjaxRequest xReq) throws NException
    {
        PriorJobOfficeReqDao dao = new PriorJobOfficeReqDao(this.nsr);

        return dao.retrievePriorJobOfficeReqList(xReq);
    }

    /**
     * 사무소요청사항 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorJobOfficeReq(AjaxRequest xReq) throws NException
    {
        PriorJobOfficeReqDao dao = new PriorJobOfficeReqDao(this.nsr);

        return dao.retrievePriorJobOfficeReq(xReq);
    }

    /**
     * 사무소요청사항 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePriorJobOfficeReq(AjaxRequest xReq) throws NException
    {
        PriorJobOfficeReqDao dao = new PriorJobOfficeReqDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 사무소요청사항 수정
        dao.updatePriorJobOfficeReq(xReq);

        // 답변 첨부화일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_ansFile"));
    }
}
