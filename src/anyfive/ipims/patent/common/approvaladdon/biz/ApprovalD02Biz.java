package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NDateUtil;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.dao.ApprovalD02Dao;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class ApprovalD02Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalD02Biz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내디자인출원 품의 결재처리
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
        ApprovalD02Dao dao = new ApprovalD02Dao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);

        String refId = apprKey.getString("REF_ID");

        NSingleData consultInfo = dao.retrieveDesignIntConsult(apprKey);
        String examResult = consultInfo.getString("EXAM_RESULT");
        String officeCode = consultInfo.getString("OFFICE_CODE");

        // 검토결과가 출원의뢰인 경우
        if (examResult.equals("1") == true) {
            // 사무소코드가 있는 경우 사무소송부일 업데이트
            if (officeCode.equals("") != true) {
                dao.updateDesignIntConsult(apprKey);
            }
        }

        NSingleData masterInfo = dao.retrieveDesignIntMaster(apprKey);

        // 포기인 경우
        if (examResult.equals("2")) {
            masterInfo.setString("ABD_YN", "1");
            masterInfo.setString("ABD_USER", masterInfo.getString("JOB_MAN"));
            masterInfo.setString("ABD_MEMO", "국내디자인출원품의 포기");
            masterInfo.setString("ABD_DATE", NDateUtil.getSysDate());
        }

        // 국내디자인출원 마스터 수정
        dao.updateDesignIntMaster(apprKey, masterInfo);

        // 포기인 경우 보상금 지급대상 아님 처리
        if (examResult.equals("2")) {
            rewardBiz.init(refId);
            rewardBiz.setValue("REWARD_GIVETARGET_YN", "0");
            rewardBiz.update("APP");
            rewardBiz.update("REG");
        }

        // 디자인 진행서류 생성
        docBiz.init(refId);
        if (examResult.equals("1")) { // 출원의뢰
            docBiz.setEvent("OFFICE_REQUEST");
        } else if (examResult.equals("0")) { // 보완요청
            docBiz.setEvent("INVENTOR_RETURN");
        } else if (examResult.equals("2")) { // 포기
            docBiz.setEvent("APPLY_CONSULT_ABANDON");
        }
        docBiz.create(true);
    }
}
