package anyfive.ipims.patent.applymgt.intpatent.receipt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.receipt.dao.IntPatentReceiptDao;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class IntPatentReceiptBiz extends NAbstractServletBiz
{
    public IntPatentReceiptBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 건담당자지정 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentReceiptList(AjaxRequest xReq) throws NException
    {
        IntPatentReceiptDao dao = new IntPatentReceiptDao(this.nsr);

        return dao.retrieveIntPatentReceiptList(xReq);
    }

    /**
     * 건담당자지정 담당자지정
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void updateIntPatentReceiptJobMan(String refId, String jobMan) throws NException
    {
        IntPatentReceiptDao dao = new IntPatentReceiptDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);

        // 국내특허품의서 생성
        dao.createIntPatentConsult(refId, jobMan);

        // 국내특허마스터 생성
        dao.createIntPatentMaster(refId, jobMan);

        // 보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", "1");
        rewardBiz.update("APP");
        rewardBiz.update("REG");

        // 진행서류 생성
        docBiz.init(refId);
        docBiz.setEvent("PATTEAM_RECEIPT");
        docBiz.create();

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(refId, WorkProcessConst.Action.JOB_MAN_ASSIGN);
    }
}
