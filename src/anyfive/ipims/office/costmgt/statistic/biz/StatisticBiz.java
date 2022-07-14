package anyfive.ipims.office.costmgt.statistic.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.costmgt.statistic.dao.StatisticDao;

public class StatisticBiz extends NAbstractServletBiz
{
    public StatisticBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사무소별 비용통계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostByOfficeList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveCostByOfficeList(xReq);
    }

    /**
     * 상세비용현황 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDetailCostList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveDetailCostList(xReq);
    }


}
