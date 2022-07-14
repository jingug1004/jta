package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NDateUtil;
import any.util.etc.NTextUtil;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.dao.ApprovalP02Dao;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class ApprovalP02Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalP02Biz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내특허출원 품의 결재처리
     *
     * @param apprNo
     * @param apprEvent
     * @param apprMgt
     * @throws NException
     */
    public void execute(String apprNo, NSingleData apprKey, short apprEvent, NSingleData apprMgt) throws NException
    {
        // 결재요청시
        if (apprEvent == ApprovalEvents.REQUEST) {
            this.executeRequest(apprKey);
        }

        // 결재없음 또는 최종승인시
        if (apprEvent == ApprovalEvents.NONE || apprEvent == ApprovalEvents.AGREEALL) {
            this.executeAgreeAll(apprKey);
        }
    }

    /**
     * 결재요청 처리
     *
     * @param apprKey
     * @throws NException
     */
    private void executeRequest(NSingleData apprKey) throws NException
    {
        ApprovalP02Dao dao = new ApprovalP02Dao(this.nsr);

        NSingleData consultInfo = dao.retrieveIntPatentConsult(apprKey);
        NSingleData masterInfo = dao.retrieveIntPatentMaster(apprKey);

        String refId = apprKey.getString("REF_ID");
        String refNo = masterInfo.getString("REF_NO");
        String examResult = consultInfo.getString("EXAM_RESULT");

        // 포기인 경우
        if (examResult.equals("2")) {
            this.createInvInformMail(refId, refNo, "/applymgt/abandon", consultInfo, masterInfo);
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
        ApprovalP02Dao dao = new ApprovalP02Dao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);

        String refId = apprKey.getString("REF_ID");

        NSingleData consultInfo = dao.retrieveIntPatentConsult(apprKey);
        String examResult = consultInfo.getString("EXAM_RESULT");
        String officeCode = consultInfo.getString("OFFICE_CODE");

        // 검토결과가 출원의뢰인 경우
        if (examResult.equals("1") == true) {
            // 양도일 업데이트
            dao.updateIntPatentRequest(apprKey);

            // 사무소코드가 있는 경우 사무소송부일 업데이트
            if (officeCode.equals("") != true) {
                dao.updateIntPatentConsult(apprKey);
            }
        }

        NSingleData masterInfo = dao.retrieveIntPatentMaster(apprKey);

        // 포기인 경우
        if (examResult.equals("2")) {
            masterInfo.setString("ABD_YN", "1");
            masterInfo.setString("ABD_USER", masterInfo.getString("JOB_MAN"));
            masterInfo.setString("ABD_MEMO", "국내출원품의 포기");
            masterInfo.setString("ABD_DATE", NDateUtil.getSysDate());
        }

        // 국내특허출원 마스터 수정
        dao.updateIntPatentMaster(apprKey, masterInfo);

        // 포기인 경우 보상금 지급대상 아님 처리
        if (examResult.equals("2")) {
            rewardBiz.init(refId);
            rewardBiz.setValue("REWARD_GIVETARGET_YN", "0");
            rewardBiz.update("APP");
            rewardBiz.update("REG");
        }

        // 진행서류 생성
        docBiz.init(refId);
        if (examResult.equals("1")) { // 출원의뢰
            docBiz.setEvent("OFFICE_REQUEST");
        }
        if (examResult.equals("0")) { // 보완요청
            docBiz.setEvent("INVENTOR_RETURN");
        }
        if (examResult.equals("2")) { // 포기
            docBiz.setEvent("APPLY_CONSULT_ABANDON");
        }
        docBiz.setValue("REMARK", consultInfo.getString("EXAM_RESULT_OPINION"));
        docBiz.create(true);

        String refNo = masterInfo.getString("REF_NO");
        StringBuffer paperRefNos = new StringBuffer();

        NMultiData refList = null;

        // 국내우선권 지정된 목록 조회
        refList = refBiz.retrieveRefNoList(refId, MappingKind.PRIOR, MappingDiv.NONE);

        // 국내우선권 지정목록 처리
        if (refList.getRowSize() > 0) {
            paperRefNos.setLength(0);

            for (int i = 0; i < refList.getRowSize(); i++) {
                docBiz.init(refList.getString(i, "REF_ID"));
                docBiz.setEvent("PRIOR_CHILD_DROP");
                docBiz.setValue("PAPER_REF_NO", refNo);
                docBiz.setValue("COMMENTS", "국내우선권취하");
                docBiz.create();

                paperRefNos.append(paperRefNos.length() == 0 ? "" : "/");
                paperRefNos.append(refList.getString(i, "APP_NO"));

                dao.updateIntPatentMasterForPriorChild(refList.getString(i, "REF_ID"), refId);

                rewardBiz.init(refList.getString(i, "REF_ID"));
                rewardBiz.setValue("REWARD_GIVETARGET_YN", "0");
                rewardBiz.update("APP");
                rewardBiz.update("REG");
            }

            docBiz.init(refId);
            docBiz.setEvent("PRIOR_PARENT_PROGRESS");
            docBiz.setValue("PAPER_REF_NO", paperRefNos.toString());
            docBiz.create();
        }

        // 병합출원 목록 조회
        refList = refBiz.retrieveRefNoList(refId, MappingKind.UNION, MappingDiv.NONE);

        // 병합출원 목록 처리
        if (refList.getRowSize() > 0) {
            paperRefNos.setLength(0);

            for (int i = 0; i < refList.getRowSize(); i++) {
                docBiz.init(refList.getString(i, "REF_ID"));
                docBiz.setEvent("UNION_CHILD_ABANDON");
                docBiz.setValue("PAPER_REF_NO", refNo);
                docBiz.setValue("COMMENTS", "병합종료");
                docBiz.create();

                paperRefNos.append(paperRefNos.length() == 0 ? "" : "/");
                paperRefNos.append(refList.getString(i, "REF_NO"));

                dao.updateIntPatentMasterForUnionChild(refList.getString(i, "REF_ID"), refId);

                rewardBiz.init(refList.getString(i, "REF_ID"));
                rewardBiz.setValue("REWARD_GIVETARGET_YN", "0");
                rewardBiz.update("APP");
                rewardBiz.update("REG");
            }

            docBiz.init(refId);
            docBiz.setEvent("UNION_PARENT_PROGRESS");
            docBiz.setValue("PAPER_REF_NO", paperRefNos.toString());
            docBiz.create();
        }

        // 검토결과 출원의뢰인 경우 승계알림메일 생성
        if (examResult.equals("1")) {
            this.createInvInformMail(refId, refNo, "/applymgt/succession", consultInfo, masterInfo);
        }

        // 검토결과 포기인 경우 포기알림메일 생성
        if (examResult.equals("2")) {
            this.createInvInformMail(refId, refNo, "/applymgt/nosuccession", consultInfo, masterInfo);
        }
    }

    /**
     * 발명자 알림메일 발송(포기/승계/불승계)
     *
     * @param apprKey
     * @throws NException
     */
    private void createInvInformMail(String refId, String refNo, String templateName, NSingleData consultInfo, NSingleData masterInfo) throws NException
    {
        ApprovalP02Dao dao = new ApprovalP02Dao(this.nsr);
        MailBiz mail = new MailBiz(this.nsr);

        NMultiData recvList = dao.retrieveNoticeMailRecvList(refId);

        mail.init();
        mail.template.init(templateName);
        mail.template.setValue("REF_NO", refNo);
        mail.template.setValue("KO_APP_TITLE", masterInfo.getString("KO_APP_TITLE"));
        mail.template.setValue("INVENTOR_NAMES", masterInfo.getString("INVENTOR_NAMES"));
        mail.template.setValue("EXAM_RESULT_OPINION", consultInfo.getString("EXAM_RESULT_OPINION").equals("") ? "(없음)" : consultInfo.getString("EXAM_RESULT_OPINION"));
        mail.template.setValue("YEAR", NDateUtil.getFormatDate("yyyy"));
        mail.template.setValue("MONTH", NDateUtil.getFormatDate("MM"));
        mail.template.setValue("DAY", NDateUtil.getFormatDate("dd"));
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        for (int i = 0; i < recvList.getRowSize(); i++) {
            mail.addTo(recvList.getString(i, "TO_ADDR"), recvList.getString(i, "TO_NAME"));
        }
        mail.create();
    }
}
