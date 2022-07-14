package anyfive.ipims.patent.systemmgt.evalsheet.evalelem.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.evalsheet.evalelem.dao.EvalElemMgtDao;

public class EvalElemMgtBiz extends NAbstractServletBiz
{
    public EvalElemMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가요소 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalElemMgtList(AjaxRequest xReq) throws NException
    {
        EvalElemMgtDao dao = new EvalElemMgtDao(this.nsr);

        return dao.retrieveEvalElemMgtList(xReq);
    }

    /**
     * 평가요소 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalElemMgt(AjaxRequest xReq) throws NException
    {
        EvalElemMgtDao dao = new EvalElemMgtDao(this.nsr);

        return dao.retrieveEvalElemMgt(xReq);
    }

    /**
     * 평가요소 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createEvalElemMgt(AjaxRequest xReq) throws NException
    {
        EvalElemMgtDao dao = new EvalElemMgtDao(this.nsr);

        dao.createEvalElemMgt(xReq);
    }

    /**
     * 평가요소 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateEvalElemMgt(AjaxRequest xReq) throws NException
    {
        EvalElemMgtDao dao = new EvalElemMgtDao(this.nsr);

        dao.updateEvalElemMgt(xReq);
    }

    /**
     * 평가요소 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteEvalElemMgt(AjaxRequest xReq) throws NException
    {
        EvalElemMgtDao dao = new EvalElemMgtDao(this.nsr);

        dao.deleteEvalElemMgt(xReq);
    }

    /**
     * 평가요소 표시순서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateEvalElemMgtDispOrdList(AjaxRequest xReq) throws NException
    {
        EvalElemMgtDao dao = new EvalElemMgtDao(this.nsr);

        dao.updateEvalElemMgtDispOrdList(xReq);
    }
}
