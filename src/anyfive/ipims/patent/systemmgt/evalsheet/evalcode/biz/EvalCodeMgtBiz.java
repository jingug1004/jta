package anyfive.ipims.patent.systemmgt.evalsheet.evalcode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.evalsheet.evalcode.dao.EvalCodeMgtDao;

public class EvalCodeMgtBiz extends NAbstractServletBiz
{
    public EvalCodeMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가코드 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalCodeMgtList(AjaxRequest xReq) throws NException
    {
        EvalCodeMgtDao dao = new EvalCodeMgtDao(this.nsr);

        return dao.retrieveEvalCodeMgtList(xReq);
    }

    /**
     * 평가코드 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalCodeMgt(AjaxRequest xReq) throws NException
    {
        EvalCodeMgtDao dao = new EvalCodeMgtDao(this.nsr);

        return dao.retrieveEvalCodeMgt(xReq);
    }

    /**
     * 평가코드 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createEvalCodeMgt(AjaxRequest xReq) throws NException
    {
        EvalCodeMgtDao dao = new EvalCodeMgtDao(this.nsr);

        if (dao.createEvalCodeMgt(xReq) == 0) {
            throw new NBizException(1, this.nsr.message.get("msg.com.error.dup"));
        }
    }

    /**
     * 평가코드 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateEvalCodeMgt(AjaxRequest xReq) throws NException
    {
        EvalCodeMgtDao dao = new EvalCodeMgtDao(this.nsr);

        dao.updateEvalCodeMgt(xReq);
    }

    /**
     * 평가코드 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteEvalCodeMgt(AjaxRequest xReq) throws NException
    {
        EvalCodeMgtDao dao = new EvalCodeMgtDao(this.nsr);

        dao.deleteEvalCodeMgt(xReq);
    }
}
