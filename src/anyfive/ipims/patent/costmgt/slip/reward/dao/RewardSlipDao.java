package anyfive.ipims.patent.costmgt.slip.reward.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class RewardSlipDao extends NAbstractServletDao
{
    public RewardSlipDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/reward", "/retrieveRewardSlipList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/reward", "/retrieveRewardInformMailList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 보상금 알림메일 발송여부 업데이트
     *
     * @param costSeq
     * @throws NException
     */
    public void updateRewardInformMailSendYn(String costSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/reward", "/updateRewardInformMailSendYn");
        dao.bind("COST_SEQ", costSeq);

        dao.executeUpdate();
    }

    /**
     * 보상금전표 다운로드
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardSlipDownloadList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/reward", "/retrieveRewardSlipDownloadList");
        dao.bind(xReq);

        dao.bind("DEPT_CODE", SessionUtil.getUserInfo(this.nsr).getDeptCode());

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국내 보상금 지급내역 Update
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateIntAppForSlipProc(String rewardDiv, AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/reward", "/updateIntAppForSlipProc");
        dao.bind("REWARD_DIV", rewardDiv);
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외 보상금 지급내역 Update
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtAppForSlipProc(String rewardDiv, AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/reward", "/updateExtAppForSlipProc");
        dao.bind("REWARD_DIV", rewardDiv);
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
