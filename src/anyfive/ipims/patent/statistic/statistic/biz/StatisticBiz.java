package anyfive.ipims.patent.statistic.statistic.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.statistic.statistic.dao.StatisticDao;

public class StatisticBiz extends NAbstractServletBiz
{
    public StatisticBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 전체통계현황 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAllStatisticCount(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveAllStatisticCount(xReq);
    }

     /**
     * 전체통계현황 리스트 상세
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAllStatisticsChartDetail(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveStatusByAllStatisticsDetail(xReq);
    }

    /**
     * 국내출원품의대장 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntApplyConsultList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveIntApplyConsultList(xReq);
    }

    /**
     * 해외출원품의대장 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtApplyConsultList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveExtApplyConsultList(xReq);
    }

    /**
     * 국내출원관리대장 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntMasterList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveIntMasterList(xReq);
    }

    /**
     * 국내중간관리대장 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntOAList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveIntOAList(xReq);
    }

    /**
     * 해외출원관리대장 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtMasterList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveExtMasterList(xReq);
    }

    /**
     * 해외중간관리대장 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtOAList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveExtOAList(xReq);
    }

    /**
     * 기술별 국내실적통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveActualByTechList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveActualByTechList(xReq);
    }

    /**
     * Ipc별 국내실적통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveActualByIpcList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveActualByIpcList(xReq);
    }

    /**
     * 프로젝트별 실적통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveActualByProjectList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveActualByProjectList(xReq);
    }

    /**
     * 연구소별 실적통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveActualByLabList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveActualByLabList(xReq);
    }

    /**
     * 연구소별 실적통계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveActualByLab(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveActualByLab(xReq);
    }

    /**
     * 통계정보조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatisticList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveStatisticList(xReq);
    }

      /**
     * Delivery 현황(출원) 목록 조회
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDeliveryApplyList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveDeliveryApplyList(xReq);
    }

    /**
     * Delivery 현황(OA) 목록 조회
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDeliveryOAList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveDeliveryOAList(xReq);
    }

    /**
     * Delivery 통계현황 목록 조회
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDeliveryStatisticList(AjaxRequest xReq) throws NException
    {
        StatisticDao dao = new StatisticDao(this.nsr);

        return dao.retrieveDeliveryStatisticList(xReq);
    }
}
