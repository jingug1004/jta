package anyfive.ipims.patent.applymgt.priorjob.evaluation.biz;

import any.core.config.NConfig;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.applymgt.priorjob.evaluation.dao.EvaluationDao;
import anyfive.ipims.patent.common.evaluation.biz.EvalCommonBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class EvaluationBiz extends NAbstractServletBiz
{
    public EvaluationBiz(NServiceResource nsr)
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
        EvaluationDao dao = new EvaluationDao(this.nsr);

        return dao.retrieveEvaluationList(xReq);
    }

    /**
     * 발명평가표 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvaluationE01(AjaxRequest xReq) throws NException
    {
        EvaluationDao dao = new EvaluationDao(this.nsr);

        NSingleData result = new NSingleData();

        NSingleData mainInfo = dao.retrieveEvaluationMaster(xReq);

        result.set("ds_mainInfo", mainInfo);
        result.set("ds_consultInfo", dao.retrieveIntPatConsult(mainInfo.getString("REF_ID")));

        return result;
    }

    /**
     * 등록평가표 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvaluationE02(AjaxRequest xReq) throws NException
    {
        EvaluationDao dao = new EvaluationDao(this.nsr);

        NSingleData result = new NSingleData();

        NSingleData mainInfo = dao.retrieveEvaluationMaster(xReq);
System.out.println("================= biz "+xReq.getParam("EVAL_ID"));
        result.set("ds_mainInfo", mainInfo);
        result.set("ds_regInfo", dao.retrieveEvalComRegResult(mainInfo.getString("REF_ID")));

        return result;
    }

    /**
     * 발명부서 평가자 지정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createEvaluationInvDeptUser(AjaxRequest xReq) throws NException
    {
        EvaluationDao dao = new EvaluationDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String evalId = seqUtil.getBizId();

        xReq.setUserData("EVAL_ID", evalId);

        dao.createEvaluationInvDeptUser(xReq);

        //발명자 메일발송
        NSingleData mailSendInfo = new NSingleData();

        NSingleData info = dao.retrieveEvalMailInfo(xReq);

        mailSendInfo.setString("INVDEPT_EVAL_USER_NAME", info.getString("INVDEPT_EVAL_USER_NAME"));
        mailSendInfo.setString("SUBJECT_LIST", info.getString("KO_APP_TITLE"));
        mailSendInfo.setString("APP_NO", info.getString("APP_NO"));
        mailSendInfo.setString("REF_ID", info.getString("REF_ID"));
        mailSendInfo.setString("PAPER_LIST_SEQ", info.getString("PAPER_LIST_SEQ"));
        mailSendInfo.setString("SERVER_URL", NConfig.getString("/config/mail-link-url/patent-url"));

        MailBiz mail = new MailBiz(this.nsr);
        mail.init();
        mail.setSubject("지식재산권 등록평가 요청");
        mail.template.init("/rivalpat/reqExamRegInv");
        mail.template.setData(mailSendInfo);
        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        mail.addTo(info.getString("MAIL_ADDR"), info.getString("EMP_HNAME"));
        mail.create();

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(evalId, WorkProcessConst.Step.INVDEPT_REG_EVAL);
    }

    /**
     * 발명평가표 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateEvaluationE01(AjaxRequest xReq) throws NException
    {
        EvaluationDao dao = new EvaluationDao(this.nsr);
        EvalCommonBiz evalBiz = new EvalCommonBiz(this.nsr);

        // 평가표 저장
        String evalId = evalBiz.updateEvaluation(xReq);

        // 국내특허출원품의서 업데이트
        if (xReq.getParam("EVAL_KIND").equals("PATDEPT") == true) {
            dao.updateIntPatConsult(xReq);
        }

        return evalId;
    }

    /**
     * 등록평가표 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateEvaluationE02(AjaxRequest xReq) throws NException
    {
        EvaluationDao dao = new EvaluationDao(this.nsr);
        EvalCommonBiz evalBiz = new EvalCommonBiz(this.nsr);

        // 평가표 저장
        String evalId = evalBiz.updateEvaluation(xReq);

        // 등록평가 결과 업데이트
        if (xReq.getParam("EVAL_KIND").equals("PATDEPT") == true) {
            xReq.setUserData("EVAL_ID", evalId);
            if (dao.updateEvalComRegResult(xReq) == 0) {
                dao.createEvalComRegResult(xReq);
            }
        }

        return evalId;
    }

       /**
     * 심의평가시트 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvaluationE06(AjaxRequest xReq) throws NException
    {
        EvaluationDao dao = new EvaluationDao(this.nsr);

        NSingleData result = new NSingleData();

        NSingleData mainInfo = dao.retrieveEvaluationMaster(xReq);

        result.set("ds_mainInfo", mainInfo);
        result.set("ds_consultInfo", dao.retrieveIntPatConsult(mainInfo.getString("REF_ID"))); // 심의대상 ref 별 등급을 조회한다.

        return result;
    }

    /**
     * 심의평가표 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateEvaluationE06(AjaxRequest xReq) throws NException
    {
        EvaluationDao dao = new EvaluationDao(this.nsr);
        EvalCommonBiz evalBiz = new EvalCommonBiz(this.nsr);

        // 평가표 저장
        String evalId = evalBiz.updateEvaluation(xReq);

        // 심의대상 등급 업데이트
        if (xReq.getParam("EVAL_KIND").equals("PATDEPT") == true) {
            dao.updateIntRgradeConsult(xReq);
        }

        return evalId;
    }

    /**
     * 사무소평가표 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateEvaluationE03(AjaxRequest xReq) throws NException
    {
        EvalCommonBiz evalBiz = new EvalCommonBiz(this.nsr);

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");
        String evalOpinion = mainInfo.getString("EVAL_OPINION");

        xReq.setUserData("EVAL_OPINION", evalOpinion);

        // 평가표 저장
        String evalId = evalBiz.updateEvaluation(xReq);

        // 등록평가 결과 업데이트
        xReq.setUserData("EVAL_ID", evalId);
        return evalId;
    }

}
