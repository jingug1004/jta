package anyfive.ipims.patent.systemmgt.basecode.rewardcode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class RewardCodeMgtDao extends NAbstractServletDao
{
    public RewardCodeMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금종류코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardCodeMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/rewardcodemgt", "/retrieveRewardCodeMgtList");
        dao.bind(xReq);

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 국내외구분
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 보상금구분
        if (xReq.getParam("REWARD_DIV").equals("") != true) {
            dao.addQuery("rewardDiv");
        }

        // 발명등급
        if (xReq.getParam("INV_GRADE").equals("") != true) {
            dao.addQuery("invGrade");
        }

        dao.addQuery("orderBy");

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 보상금종류코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/rewardcodemgt", "/retrieveRewardCodeMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 보상금종류코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createRewardCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/rewardcodemgt", "/createRewardCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 보상금종류코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRewardCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/rewardcodemgt", "/updateRewardCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 보상금종류코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRewardCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/rewardcodemgt", "/deleteRewardCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
