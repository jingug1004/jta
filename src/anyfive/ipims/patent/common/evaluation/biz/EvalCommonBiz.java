package anyfive.ipims.patent.common.evaluation.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.evaluation.dao.EvalCommonDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class EvalCommonBiz extends NAbstractServletBiz
{
    public EvalCommonBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가서 항목 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveEvalSheetItemList(AjaxRequest xReq) throws NException
    {
        EvalCommonDao dao = new EvalCommonDao(this.nsr);

        return dao.retrieveEvalSheetItemList(xReq);
    }

    /**
     * 평가표 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateEvaluation(AjaxRequest xReq) throws NException
    {
        EvalCommonDao dao = new EvalCommonDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String evalId = xReq.getParam("EVAL_ID");

        if (evalId.equals("")) {
            evalId = seqUtil.getBizId();
            xReq.setUserData("EVAL_ID", evalId);
            dao.createEvaluationMaster(xReq);
            dao.updateEvalOpinionMaster(xReq);
        } else {
            dao.updateEvaluationMaster(xReq);
            dao.updateEvalOpinionMaster(xReq);
        }

        dao.deleteEvaluationItemAll(xReq);
        dao.createEvaluationItem(xReq);
        return evalId;
    }
}
