package anyfive.ipims.patent.common.evaluation.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class EvalCommonDao extends NAbstractServletDao
{
    public EvalCommonDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/evaluation/evaluation", "/retrieveEvalSheetItemList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 평가 마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createEvaluationMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/evaluation/evaluation", "/createEvaluationMaster_" + xReq.getParam("EVAL_KIND"));
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가 마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateEvaluationMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/evaluation/evaluation", "/updateEvaluationMaster_" + xReq.getParam("EVAL_KIND"));
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가 항목 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createEvaluationItem(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/evaluation/evaluation", "/createEvaluationItem");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_evalList"));
    }

    /**
     * 평가 항목 전체 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteEvaluationItemAll(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/evaluation/evaluation", "/deleteEvaluationItemAll");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 종합적 평가의견 등록
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateEvalOpinionMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/evaluation/evaluation", "/updateEvalOpinionMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
