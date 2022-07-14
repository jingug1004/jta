package anyfive.ipims.patent.systemmgt.papermgt.paperwf.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.papermgt.paperwf.dao.PaperWFMgtDao;

public class PaperWFMgtBiz extends NAbstractServletBiz
{
    public PaperWFMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 워크플로우관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperBizList(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        return dao.retrievePaperWFList(xReq);
    }

    /**
     * 진행서류 워크플로우관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperWF(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        return dao.retrievePaperWF(xReq);
    }

    /**
     * 진행서류 워크플로우관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createPaperWF(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        String wfCode = dao.retrievePaperWFCode();

        xReq.setUserData("WF_CODE", wfCode);

        dao.createPaperWF(xReq);

        return wfCode;
    }

    /**
     * 진행서류 워크플로우관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePaperWF(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        dao.updatePaperWF(xReq);
    }

    /**
     * 진행서류 워크플로우관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deletePaperWF(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        if (dao.deletePaperWF(xReq) == 0) {
            throw new NBizException("이미 사용중인 진행서류 워크플로우를 삭제할 수가 없습니다.");
        }
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperWFPaperList(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        return dao.retrievePaperWFPaperList(xReq);
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperWFPaper(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        return dao.retrievePaperWFPaper(xReq);
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createPaperWFPaper(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        dao.createPaperWFPaper(xReq);
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePaperWFPaper(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        dao.updatePaperWFPaper(xReq);
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deletePaperWFPaper(AjaxRequest xReq) throws NException
    {
        PaperWFMgtDao dao = new PaperWFMgtDao(this.nsr);

        dao.deletePaperWFPaper(xReq);
    }
}
