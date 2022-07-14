package anyfive.ipims.patent.costmgt.reward.consult.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class RewardConsultDao extends NAbstractServletDao
{
    public RewardConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     *  보상금품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/retrieveRewardConsultList");
        dao.bind(xReq);



        //제목
        if (xReq.getParam("CONSULT_SUBJECT").equals("") != true) {
            dao.addQuery("consultSubject");
        }
        //상태
        if (xReq.getParam("CONSULT_STATUS").equals("") != true) {
            if(xReq.getParam("CONSULT_STATUS").equals("0") == true) {
                dao.addQuery("consultStatusDefault");
            }
            else {
                dao.addQuery("consultStatus");
            }
        }
        //작성자
        if (xReq.getParam("CRE_USER").equals("") != true) {
            dao.addQuery("creUser");
        }
        //작성일
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        //작성일
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 보상금품의 품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createRewardConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/createRewardConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 보상금지급 수정(품의중)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateRewardSupply(AjaxRequest xReq, NMultiData updateList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/updateRewardSupply");
        dao.bind(xReq);
        dao.executeBatch(updateList);
    }

    /**
     * 보상금지급 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateRewardSupplyConsultIdToNull(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/updateRewardSupplyConsultIdToNull");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 보상금품의 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/retrieveRewardConsult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 보상금품의대상(상세-발명자별) 목록조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardConsultByInv(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/retrieveRewardConsultByInv");
        dao.bind(xReq);

        //by CONSULT_ID
        if (xReq.getParam("CONSULT_ID").equals("") != true) {
            dao.addQuery("consultId");
        }

        //by SLIP_ID
        if (xReq.getParam("SLIP_ID").equals("") != true) {
            dao.addQuery("slipId");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 보상금품의대상(상세-부서별) 목록조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardConsultByDept(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/retrieveRewardConsultByDept");
        dao.bind(xReq);

        //by CONSULT_ID
        if (xReq.getParam("CONSULT_ID").equals("") != true) {
            dao.replaceText("SEARCH_TYPE", "B.CONSULT_ID");
            dao.bind("SEARCH_ID", xReq.getParam("CONSULT_ID"));
        }

        //by SLIP_ID
        if (xReq.getParam("SLIP_ID").equals("") != true) {
            dao.replaceText("SEARCH_TYPE", "B.SLIP_ID");
            dao.bind("SEARCH_ID", xReq.getParam("SLIP_ID"));
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 보상금품의 품의서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRewardConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/updateRewardConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 보상금품의 품의서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRewardConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/consult", "/deleteRewardConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
