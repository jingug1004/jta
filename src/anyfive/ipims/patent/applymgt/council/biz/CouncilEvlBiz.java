package anyfive.ipims.patent.applymgt.council.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.applymgt.council.dao.CouncilEvlDao;

public class CouncilEvlBiz extends NAbstractServletBiz
{
    public CouncilEvlBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 심의평가현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCouncilEvlListR(AjaxRequest xReq) throws NException
    {
        CouncilEvlDao dao = new CouncilEvlDao(this.nsr);

        return dao.retrieveCouncilEvlListR(xReq);
    }

    /**
     * 심의평가 임시저장시 req 테이블   상태수정(평가완료)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateCouncilEvlRreq(AjaxRequest xReq) throws NException
    {
        CouncilEvlDao dao = new CouncilEvlDao(this.nsr);
        String mgtId = xReq.getParam("MGT_ID");
        dao.updateCouncilEvlRreq(xReq);

        NMultiData reqList = dao.retrieveCouncilEvlStsRreq(xReq);;
        String reqId = null;
        String reviewGrade = null;

        for (int i = 0; i < reqList.getRowSize(); i++) {
            reqId = reqList.getString(i, "REF_ID");
            reviewGrade = reqList.getString(i, "REVIEW_GRADE");

            //
            dao.updateCouncilEvlAmst(reqId, reviewGrade);

        }


        return mgtId;
    }

    /**
     * 심의평가 임시저장시 mamber 테이블   상태수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateCouncilEvlMber(AjaxRequest xReq) throws NException
    {
        CouncilEvlDao dao = new CouncilEvlDao(this.nsr);
        String mgtId = xReq.getParam("MGT_ID");

        dao.updateCouncilEvlMber(xReq);

        return mgtId;
    }

    /**
     * 심의 평가 재요청  (평가중인 심의위원에게만 메일 발송)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCouncilRequestReEmail(AjaxRequest xReq) throws NException
    {
        CouncilEvlDao dao = new CouncilEvlDao(this.nsr);

        MailBiz mail = new MailBiz(this.nsr);
        mail.init();
        NSingleData courseInfo = dao.retrieveCouncilRequest(xReq);
        NSingleData mailInfo = new NSingleData();
        StringBuffer strB = new StringBuffer();
        NMultiData stuList = dao.retrieveCouncilRequestReList(xReq);

        mail = new MailBiz(this.nsr);
        mail.init();
        mail.setSubject("\"" + courseInfo.getString("REQ_SUBJECT") + "\" 심의요청드립니다.");
        mailInfo.setString("EMP_HNAME", SessionUtil.getUserInfo(this.nsr).getEmpHname());
        mailInfo.setString("REQ_SUBJECT", courseInfo.getString("REQ_SUBJECT"));
        mailInfo.setString("START_DATE", courseInfo.getString("START_DATE"));
        mailInfo.setString("END_DATE", courseInfo.getString("END_DATE"));

        mailInfo.setString("stuList", strB.toString());
        mail.template.init("/council/review");
        mail.template.setData(mailInfo);

        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        for (int i = 0; i < stuList.getRowSize(); i++) {
            mail.addTo(stuList.getString(i, "MAIL_ADDR"), stuList.getString(i, "EMP_HNAME"));
        }
        mail.create();

        return;
    }



}
