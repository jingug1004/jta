package anyfive.ipims.patent.rivalpat.statistic.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.rivalpat.statistic.dao.StatisticDao;

public class StatisticBiz extends NAbstractServletBiz
{
    public StatisticBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 등급별 통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatGradeStatisticList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);
        return dao.retrieveRivalPatGradeStatisticList(xReq);
    }

    /**
     * 기술분류별 통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatTechStatisticList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);
        return dao.retrieveRivalPatTechStatisticList(xReq);
    }

    /**
     * 기술분류별 총건수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatTechStatisticListPop(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);
        return dao.retrieveRivalPatTechStatisticListPop(xReq);
    }

    /**
     * IPC분류별 통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatIpcStatisticList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);
        return dao.retrieveRivalPatIpcStatisticList(xReq);
    }

    /**
     * 정량맵
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveRivalPatQuantityMap(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);
        return dao.retrieveRivalPatQuantityMap(xReq);
    }

    /**
     * 정량맵
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData quantityExcelDownload(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);
        return dao.quantityExcelDownload(xReq);
    }
}
