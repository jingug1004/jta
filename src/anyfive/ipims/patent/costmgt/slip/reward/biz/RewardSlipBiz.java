package anyfive.ipims.patent.costmgt.slip.reward.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.costmgt.slip.proc.biz.SlipProcBiz;
import anyfive.ipims.patent.costmgt.slip.reward.dao.RewardSlipDao;

public class RewardSlipBiz extends NAbstractServletBiz
{
    public RewardSlipBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금비용 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardSlipList(AjaxRequest xReq) throws NException
    {
        RewardSlipDao dao = new RewardSlipDao(this.nsr);

        return dao.retrieveRewardSlipList(xReq);
    }

    /**
     * 보상금 알림메일 발송목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardInformMailList(AjaxRequest xReq) throws NException
    {
        RewardSlipDao dao = new RewardSlipDao(this.nsr);

        return dao.retrieveRewardInformMailList(xReq);
    }

    /**
     * 보상금 알림메일 발송목록 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createRewardInformMailList(AjaxRequest xReq) throws NException
    {
        RewardSlipDao dao = new RewardSlipDao(this.nsr);
        MailBiz mail = new MailBiz(this.nsr);

        NMultiData mailList = xReq.getMultiData("ds_mailList");

        for (int i = 0; i < mailList.getRowSize(); i++) {
            dao.updateRewardInformMailSendYn(mailList.getString(i, "COST_SEQ"));

            mail.init();
            mail.setSubject(mailList.getString(i, "SUBJECT"));
            mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
            mail.addTo(mailList.getString(i, "TO_ADDR"), mailList.getString(i, "TO_HNAME"));
            mail.addBody(mailList.getString(i, "BODY").replaceAll("\n", "<BR>\n"));
            mail.create();

            this.nsr.commitTrans();
        }
    }

    /**
     * 보상금 전표 다운로드
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardSlipDownloadList(AjaxRequest xReq) throws NException
    {
        RewardSlipDao dao = new RewardSlipDao(this.nsr);

        return dao.retrieveRewardSlipDownloadList(xReq);
    }

    /**
     * 보상금 전표 완료처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSlipProcConfirm(AjaxRequest xReq) throws NException
    {
        RewardSlipDao dao = new RewardSlipDao(this.nsr);
        SlipProcBiz procBiz = new SlipProcBiz(this.nsr);

        // 전표 완료처리
        procBiz.updateSlipProcConfirm(xReq);

        int updateCnt = 0;

        // 보상금 지급내역 Update
        updateCnt += dao.updateIntAppForSlipProc("APP", xReq);
        updateCnt += dao.updateIntAppForSlipProc("REG", xReq);
        updateCnt += dao.updateExtAppForSlipProc("APP", xReq);
        updateCnt += dao.updateExtAppForSlipProc("REG", xReq);

        if (updateCnt == 0) {
            throw new NBizException("[ERROR] 보상금 지급내역을 변경할 수가 없습니다.");
        }
    }
}
