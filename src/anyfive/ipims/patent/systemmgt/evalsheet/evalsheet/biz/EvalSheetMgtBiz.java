package anyfive.ipims.patent.systemmgt.evalsheet.evalsheet.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.evalsheet.evalsheet.dao.EvalSheetMgtDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class EvalSheetMgtBiz extends NAbstractServletBiz
{
    public EvalSheetMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가서 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalSheetMgtList(AjaxRequest xReq) throws NException
    {
        EvalSheetMgtDao dao = new EvalSheetMgtDao(this.nsr);

        return dao.retrieveEvalSheetMgtList(xReq);
    }

    /**
     * 평가서 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalSheetMgt(AjaxRequest xReq) throws NException
    {
        EvalSheetMgtDao dao = new EvalSheetMgtDao(this.nsr);

        return dao.retrieveEvalSheetMgt(xReq);
    }

    /**
     * 평가서 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createEvalSheetMgt(AjaxRequest xReq) throws NException
    {
        EvalSheetMgtDao dao = new EvalSheetMgtDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String evalSheetId = seqUtil.getEvalSheetId();

        xReq.setUserData("EVAL_SHEET_ID", evalSheetId);

        dao.createEvalSheetMgt(xReq);

        return evalSheetId;
    }

    /**
     * 평가서 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateEvalSheetMgt(AjaxRequest xReq) throws NException
    {
        EvalSheetMgtDao dao = new EvalSheetMgtDao(this.nsr);

        dao.updateEvalSheetMgt(xReq);
    }

    /**
     * 평가서 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteEvalSheetMgt(AjaxRequest xReq) throws NException
    {
        EvalSheetMgtDao dao = new EvalSheetMgtDao(this.nsr);

        dao.deleteEvalSheetMgt(xReq);
    }
}
