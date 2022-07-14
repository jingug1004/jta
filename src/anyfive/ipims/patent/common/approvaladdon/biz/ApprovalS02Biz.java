package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.dao.ApprovalS02Dao;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;

public class ApprovalS02Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalS02Biz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 선행기술조사 품의 결재처리
     *
     * @param apprNo
     * @param apprEvent
     * @param apprMgt
     * @throws NException
     */
    public void execute(String apprNo, NSingleData apprKey, short apprEvent, NSingleData apprMgt) throws NException
    {
        // 결재없음 또는 최종승인시
        if (apprEvent == ApprovalEvents.NONE || apprEvent == ApprovalEvents.AGREEALL) {
            this.executeAgreeAll(apprKey);
        }
    }

    /**
     * 결재없음 또는 최종승인 처리
     *
     * @param apprKey
     * @throws NException
     */
    private void executeAgreeAll(NSingleData apprKey) throws NException
    {
        ApprovalS02Dao dao = new ApprovalS02Dao(this.nsr);

        String prschType = dao.retrievePriorSearchConsultPrschType(apprKey);

        if (prschType.equals("2") == true){
            dao.updatePriorSearchConsultOfficeSendDate(apprKey);

            //사무소로 의뢰메일 발송
            NSingleData mainInfo = dao.retrievePriorSearchOffice(apprKey);
            NSingleData mailInfo = new NSingleData();

            mailInfo.setString("PRSCH_NO", mainInfo.getString("PRSCH_NO"));

            mailInfo.setString("PRSCH_SUBJECT", mainInfo.getString("PRSCH_SUBJECT"));
            mailInfo.setString("PRSCH_GOAL", mainInfo.getString("PRSCH_GOAL"));
            mailInfo.setString("PRSCH_DIV_NAME", mainInfo.getString("PRSCH_DIV_NAME"));
            mailInfo.setString("OFFICE_NAME", mainInfo.getString("OFFICE_NAME"));


            // 안내메일발송
            MailBiz mail = new MailBiz(this.nsr);
            mail.init();
            mail.setSubject("[선행기술조사의뢰] \"" + mainInfo.getString("PRSCH_SUBJECT") + "건을 선행기술조사 의뢰합니다 \"");
            mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
            mail.addTo(mainInfo.getString("MAIL_ADDR"), mainInfo.getString("OFFICE_NAME"));
            mail.template.init("/applymgt/searchreport");
            mail.template.setData(mailInfo);
            mail.create();
        }
    }
}
