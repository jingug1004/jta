package anyfive.ipims.patent.applymgt.priorjob.evaluation.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class EvaluationDao extends NAbstractServletDao
{
    public EvaluationDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 특허평가현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvaluationList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/retrieveEvaluationList");
        dao.bind(xReq);

        // 특허팀 사용자가 아닌 경우
        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor1", "1");
            dao.addQuery("inventor2", "2");
        }

        // 검색번호
        if (xReq.getParam("NUM_KIND").equals("") != true && xReq.getParam("NUM_TEXT").equals("") != true) {
            dao.addQuery("searchNum");
        }

        // 번호만 검색이 아닌 경우
        if (xReq.getParam("NUM_ONLY").equals("1") != true) {
            // 국내외구분
            if (xReq.getParam("INOUT_DIV").equals("") != true) {
                dao.addQuery("inoutDiv");
            }

            // 평가종류
            if (xReq.getParam("EVAL_CODE").equals("") != true) {
                dao.addQuery("evalCode");
            }

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 검색일자
            if (xReq.getParam("DATE_KIND").equals("") != true) {
                if (xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("dateStart");
                }
                if (xReq.getParam("DATE_END").equals("") != true) {
                    dao.addQuery("dateEnd");
                }
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 특허평가현황 마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvaluationMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/retrieveEvaluationMaster");
        dao.bind(xReq);

        if (xReq.getParam("EVAL_ID").equals("") == true) {
            dao.addQuery("refId");
        } else {
            dao.addQuery("evalId");
        }

        // 진행서류 목록 시퀀스가 있는 경우
        if (xReq.getParam("PAPER_LIST_SEQ").equals("") != true) {
            dao.addQuery("paperListSeq");
        }

        return dao.executeQueryForSingle();
    }

    /**
     * 심의평가표 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatConsult(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/retrieveIntPatGrade");
        dao.bind("REF_ID", refId);

        return dao.executeQueryForSingle();
    }

    /**
     * 심의평가표 등급 저장
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalComRegResult(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/retrieveEvalComRegResult");
        dao.bind("REF_ID", refId);

        return dao.executeQueryForSingle();
    }

    /**
     * 발명부서 평가자 지정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createEvaluationInvDeptUser(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/createEvaluationInvDeptUser");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가자 메일정보
     *
     * @param evalId
     * @param data
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalMailInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/retrieveEvalMailInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 발명자 메일 정보
     * @param userId
     * @return
     * @throws NException
     */
    public NSingleData retrieveInventorMailInfo(String userId) throws NException{

        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/retrieveInventorMailInfo");
        dao.bind("USER_ID", userId);

        return dao.executeQueryForSingle();

    }

    /**
     * 국내특허출원품의서 업데이트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateIntPatConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/updateIntPatConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 등록평가 결과서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createEvalComRegResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/createEvalComRegResult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 등록평가 결과서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateEvalComRegResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/updateEvalComRegResult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 국내특허출원품의서 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatGrade(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/retrieveIntPatGrade");

        dao.bind("REF_ID", refId);
        return dao.executeQueryForSingle();
    }

    /**
     * 심의대상 등급 업데이트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateIntRgradeConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/evaluation", "/updateIntRgradeConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

}
