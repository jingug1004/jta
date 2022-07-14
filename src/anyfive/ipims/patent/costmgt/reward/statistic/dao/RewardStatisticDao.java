package anyfive.ipims.patent.costmgt.reward.statistic.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class RewardStatisticDao extends NAbstractServletDao
{
    public RewardStatisticDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 보상금통계 목록 조회
     * (지급대상)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardStatisticList1(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/statistic", "/retrieveRewardStatisticList1");
        dao.bind(xReq);

        // 검색일자
        if (xReq.getParam("DATE_KIND").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        dao.addQuery("groupBy");

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 보상금통계 목록 조회1
     * (품의중, 처리완료)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRewardStatisticList2(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/reward/statistic", "/retrieveRewardStatisticList2");
        dao.bind(xReq);

        // 검색일자
        if (xReq.getParam("DATE_KIND").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        //상태구분
        if( xReq.getParam("STATUS").equals("0") == true) {
            dao.addQuery("status0");
        }

        dao.addQuery("groupBy");

        return dao.executeQueryForGrid(xReq);
    }
}
