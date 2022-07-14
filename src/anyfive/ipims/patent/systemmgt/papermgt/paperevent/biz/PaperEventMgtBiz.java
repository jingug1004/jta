package anyfive.ipims.patent.systemmgt.papermgt.paperevent.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.papermgt.paperevent.dao.PaperEventMgtDao;

public class PaperEventMgtBiz extends NAbstractServletBiz
{
    public PaperEventMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 이벤트 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperEventList(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        return dao.retrievePaperEventList(xReq);
    }

    /**
     * 진행서류 이벤트 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperEvent(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        return dao.retrievePaperEvent(xReq);
    }

    /**
     * 진행서류 이벤트 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createPaperEvent(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        String eventSeq = dao.retrievePaperEventSeq();

        xReq.setUserData("EVENT_SEQ", eventSeq);

        dao.createPaperEvent(xReq);

        return eventSeq;
    }

    /**
     * 진행서류 이벤트 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePaperEvent(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        dao.updatePaperEvent(xReq);
    }

    /**
     * 진행서류 이벤트 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deletePaperEvent(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        if (dao.deletePaperEvent(xReq) == 0) {
            throw new NBizException("이미 사용중인 이벤트를 삭제할 수가 없습니다.");
        }
    }

    /**
     * 진행서류 이벤트별 진행서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperEventPaperList(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        return dao.retrievePaperEventPaperList(xReq);
    }

    /**
     * 진행서류 이벤트별 진행서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperEventPaper(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        return dao.retrievePaperEventPaper(xReq);
    }

    /**
     * 진행서류 이벤트별 진행서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePaperEventPaper(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        if (dao.updatePaperEventPaper(xReq) == 0) {
            dao.createPaperEventPaper(xReq);
        }
    }

    /**
     * 진행서류 이벤트별 진행서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deletePaperEventPaper(AjaxRequest xReq) throws NException
    {
        PaperEventMgtDao dao = new PaperEventMgtDao(this.nsr);

        dao.deletePaperEventPaper(xReq);
    }
}
