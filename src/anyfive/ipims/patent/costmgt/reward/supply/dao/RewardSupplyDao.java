package anyfive.ipims.patent.costmgt.reward.supply.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class RewardSupplyDao extends NAbstractServletDao
{
    public RewardSupplyDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금지급 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardSupplyList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        if (xReq.getParam("REWARD_STATUS_DIV").equals("GIVE_TARGET")) {// 지급대상
            dao.setQuery("/ipims/patent/costmgt/reward/supply", "/retrieveRewardSupplyGiveList");
        }
        if (xReq.getParam("REWARD_STATUS_DIV").equals("CONSULT_TARGET")) {// 품의대상
            dao.setQuery("/ipims/patent/costmgt/reward/supply", "/retrieveRewardSupplyConsultList");
        }

        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchNo");
        }

        // 보상금 구분
        if (xReq.getParam("REWARD_DIV").equals("") != true) {
            dao.addQuery("rewardDiv");
        }

        // 번호검색
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 발명자
        if (xReq.getParam("EMP_GUBUN").equals("") != true && xReq.getParam("SR_INV").equals("") != true) {
            dao.addQuery("empGubun");
        }

        // 검색일자
        if (xReq.getParam("DATE_GUBUN").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        // 휴퇴구분
        if (xReq.getParam("HT_CODE").equals("") != true) {
            dao.addQuery("htCode");
            dao.bind("HT_CODE", xReq.getParam("HT_CODE").split("\\|"));
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 보상금지급 지급확정 생성 마스터
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createRewardSupplyConfirmMst(AjaxRequest xReq, NMultiData createList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/supply", "/createRewardSupplyConfirmMst");
        dao.bind(xReq);

        return dao.executeBatch(createList);
    }

    /**
     * 보상금지급 지급확정 생성 디테일(Reward)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createRewardSupplyConfirmDtl(AjaxRequest xReq, NMultiData createList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/supply", "/createRewardSupplyConfirmDtl");
        dao.bind(xReq);

        return dao.executeBatch(createList);
    }

    /**
     * 보상금지급 지급확정취소(삭제) 마스터
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteRewardSupplyConfirmMst(AjaxRequest xReq, NMultiData deleteList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/supply", "/deleteRewardSupplyConfirmMst");
        dao.bind(xReq);

        dao.executeBatch(deleteList);
    }

    /**
     * 보상금지급 지급확정취소(삭제) 디테일(Reward)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteRewardSupplyConfirmDtl(AjaxRequest xReq, NMultiData deleteList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/supply", "/deleteRewardSupplyConfirmDtl");
        dao.bind(xReq);
        dao.executeBatch(deleteList);
    }
}
