package anyfive.ipims.patent.costmgt.statistic.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.statistic.dao.StatisticDao;

public class StatisticBiz extends NAbstractServletBiz
{
    public StatisticBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 월별 비용통계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostByMonthList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveCostByMonthList(xReq);
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
     * 연구소별 비용통계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostByLabList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveCostByLabList(xReq);
    }

    /**
     * 프로젝트별 비용통계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostByProjectList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveCostByProjectList(xReq);
    }

    /**
     * 전체비용현황 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostByAllList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveCostByAllList(xReq);
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

    /**
     *
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostByAllListRT(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveCostByAllListRT(xReq);
    }

}
