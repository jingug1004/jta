package anyfive.ipims.patent.costmgt.annual.valuation.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.common.evaluation.biz.EvalCommonBiz;
import anyfive.ipims.patent.costmgt.annual.valuation.dao.AnnualValuationDao;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class AnnualValuationBiz extends NAbstractServletBiz
{
    public AnnualValuationBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 등록유지평가 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualValuationList(AjaxRequest xReq) throws NException
    {
        AnnualValuationDao dao = new AnnualValuationDao(this.nsr);

        return dao.retrieveAnnualValuationList(xReq);
    }

    /**
     * 발명부서 평가자 목록 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualValuationInvUserSearchList(AjaxRequest xReq) throws NException
    {
        AnnualValuationDao dao = new AnnualValuationDao(this.nsr);

        return dao.retrieveAnnualValuationInvUserSearchList(xReq);
    }

    /**
     * 등록유지평가 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualValuation(AjaxRequest xReq) throws NException
    {
        AnnualValuationDao dao = new AnnualValuationDao(this.nsr);

        NSingleData result = new NSingleData();

        NSingleData mainInfo = dao.retrieveValuationMaster(xReq);

        result.set("ds_mainInfo", mainInfo);
        result.set("ds_regInfo", dao.retrieveValuationResult(mainInfo.getString("REF_ID")));

        return result;
    }

    /**
     * 발명부서 평가자 지정
     *
     * @param data
     * @return
     * @throws NException
     */
    public void createAnnualValuationInvUser(NSingleData data) throws NException
    {
        AnnualValuationDao dao = new AnnualValuationDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        String evalId = seqUtil.getBizId();

        dao.createAnnualValuationInvUser(evalId, data);
        NSingleData info = dao.InvUserInfo(data);

        if (dao.updateAnnualReminderEvalID(evalId, data) == 0) {
            throw new NBizException("리마인더 정보를 수정할 수 없습니다.");
        }

        NSingleData mainInfo = dao.retrieveAnnualValuationInfo(evalId);
        NSingleData mailSendInfo = new NSingleData();

        mailSendInfo.setString("INVDEPT_EVAL_USER_NAME", data.getString("INVDEPT_EVAL_USER_NAME"));
        mailSendInfo.setString("KO_APP_TITLE", mainInfo.getString("KO_APP_TITLE"));
        mailSendInfo.setString("INV_NAMES", mainInfo.getString("INV_NAMES"));
        mailSendInfo.setString("APP_NO", mainInfo.getString("APP_NO"));

        MailBiz mail = new MailBiz(this.nsr);
        mail.init();
        mail.setSubject("지식재산권 등록유지평가 요청");
        mail.template.init("/rivalpat/reqExamInv");
        mail.template.setData(mailSendInfo);
        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        mail.addTo(info.getString("MAIL_ADDR"), info.getString("EMP_HNAME"));
        mail.create();

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(evalId, WorkProcessConst.Step.INVDEPT_REG_KEEP_EVAL);
    }

    /**
     * 등록유지평가 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateAnnualValuation(AjaxRequest xReq) throws NException
    {
        AnnualValuationDao dao = new AnnualValuationDao(this.nsr);
        EvalCommonBiz evalBiz = new EvalCommonBiz(this.nsr);

        // 평가표 저장
        String evalId = evalBiz.updateEvaluation(xReq);

        // 등록평가 결과 업데이트
        if (xReq.getParam("EVAL_KIND").equals("PATDEPT") == true) {
            xReq.setUserData("EVAL_ID", evalId);
            if (dao.updateAnnualReminderKeepYn(xReq) == 0) {
                throw new NBizException("리마인더 정보를 수정할 수 없습니다.");
            }
        }

        return evalId;
    }

    /**
     * 지적재산팀 일괄평가 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateAnnualValuationList(AjaxRequest xReq) throws NException
    {
        AnnualValuationDao dao = new AnnualValuationDao(this.nsr);

        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        NMultiData valuationList = xReq.getMultiData("ds_annualValuationList");
        String keepYn = xReq.getParam("KEEP_YN");

        for (int i = 0; i < valuationList.getRowSize(); i++) {
            String evalId = seqUtil.getBizId();

            dao.updateAnnualValuationList(valuationList.getSingleData(i), keepYn, evalId);
            dao.createEvaluationMasterPat(valuationList.getSingleData(i),evalId);
        }
    }
}
