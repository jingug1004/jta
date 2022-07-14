package anyfive.ipims.patent.systemmgt.evalsheet.evalitem.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.evalsheet.evalitem.dao.EvalItemMgtDao;

public class EvalItemMgtBiz extends NAbstractServletBiz
{
    public EvalItemMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가항목 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalItemMgtList(AjaxRequest xReq) throws NException
    {
        EvalItemMgtDao dao = new EvalItemMgtDao(this.nsr);

        return dao.retrieveEvalItemMgtList(xReq);
    }

    /**
     * 평가항목 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalItemMgt(AjaxRequest xReq) throws NException
    {
        EvalItemMgtDao dao = new EvalItemMgtDao(this.nsr);

        return dao.retrieveEvalItemMgt(xReq);
    }

    /**
     * 평가항목 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createEvalItemMgt(AjaxRequest xReq) throws NException
    {
        EvalItemMgtDao dao = new EvalItemMgtDao(this.nsr);

        dao.createEvalItemMgt(xReq);
    }

    /**
     * 평가항목 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateEvalItemMgt(AjaxRequest xReq) throws NException
    {
        EvalItemMgtDao dao = new EvalItemMgtDao(this.nsr);

        dao.updateEvalItemMgt(xReq);
    }

    /**
     * 평가항목 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteEvalItemMgt(AjaxRequest xReq) throws NException
    {
        EvalItemMgtDao dao = new EvalItemMgtDao(this.nsr);

        dao.deleteEvalItemMgt(xReq);
    }

    /**
     * 평가항목 표시순서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateEvalItemMgtDispOrdList(AjaxRequest xReq) throws NException
    {
        EvalItemMgtDao dao = new EvalItemMgtDao(this.nsr);

        dao.updateEvalItemMgtDispOrdList(xReq);
    }
}
