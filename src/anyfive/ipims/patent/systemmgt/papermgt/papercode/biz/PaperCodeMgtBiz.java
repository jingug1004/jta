package anyfive.ipims.patent.systemmgt.papermgt.papercode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.papermgt.papercode.dao.PaperCodeMgtDao;

public class PaperCodeMgtBiz extends NAbstractServletBiz
{
    public PaperCodeMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperCodeList(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        return dao.retrievePaperCodeList(xReq);
    }

    /**
     * 진행서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        return dao.retrievePaperCode(xReq);
    }

    /**
     * 진행서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createPaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        String paperCode = dao.retrieveNewPaperCode(xReq);

        xReq.setUserData("PAPER_CODE", paperCode);

        // 진행서류 생성
        dao.createPaperCode(xReq);

        // 세부서류 생성 - "없음"
        this.createDefaultSubPaperCode(xReq);

        return paperCode;
    }

    /**
     * 진행서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        dao.updatePaperCode(xReq);
    }

    /**
     * 진행서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deletePaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        dao.deleteSubPaperCodeList(xReq);
        dao.deletePaperCode(xReq);
    }

    /**
     * 세부서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSubPaperCodeList(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        return dao.retrieveSubPaperCodeList(xReq);
    }

    /**
     * 세부서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSubPaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        return dao.retrieveSubPaperCode(xReq);
    }

    /**
     * "없음" 세부서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createDefaultSubPaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        String paperSubcode = "000";

        xReq.setUserData("PAPER_SUBCODE", paperSubcode);
        xReq.setUserData("PAPER_SUBNAME", "없음");
        xReq.setUserData("MST_ABD_YN", "0");
        xReq.setUserData("USE_YN", "1");

        if (dao.createSubPaperCode(xReq) == 0) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        return paperSubcode;
    }

    /**
     * 세부서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createSubPaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        String paperSubcode = dao.retrievePaperSubcode(xReq);

        xReq.setUserData("PAPER_SUBCODE", paperSubcode);

        dao.createSubPaperCode(xReq);

        return paperSubcode;
    }

    /**
     * 세부서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSubPaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        dao.updateSubPaperCode(xReq);
    }

    /**
     * 세부서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteSubPaperCode(AjaxRequest xReq) throws NException
    {
        PaperCodeMgtDao dao = new PaperCodeMgtDao(this.nsr);

        dao.deleteSubPaperCode(xReq);
    }
}
