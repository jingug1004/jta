package anyfive.ipims.patent.costmgt.statistic.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class StatisticDao extends NAbstractServletDao
{
    public StatisticDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/statistic/statistic", "/retrieveCostByMonthList");
        dao.bind(xReq);

        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("ansDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("ansDateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/statistic/statistic", "/retrieveCostByOfficeList");
        dao.bind(xReq);

        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("ansDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("ansDateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/statistic/statistic", "/retrieveCostByLabList");
        dao.bind(xReq);

        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("ansDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("ansDateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/statistic/statistic", "/retrieveCostByProjectList");
        dao.bind(xReq);

        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("ansDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("ansDateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/statistic/statistic", "/retrieveCostByAllList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchNo");
        }

        // 구분
        if (xReq.getParam("COST_DIV").equals("") != true) {
            dao.addQuery("costDiv");
        }

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 검색일자
        if (xReq.getParam("DATE_GUBUN").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("ansDateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("ansDateEnd");
            }
        }

        // 진행상태
        if (xReq.getParam("APPR_STATUS").equals("") != true) {
            dao.addQuery("apprStatus");
        }

        // 사무소
        if (xReq.getParam("OFFICE_CODE").equals("") != true) {
            dao.addQuery("officeCode");
        }

        // 비용구분
        if (xReq.getParam("COST_KIND").equals("") != true) {
            dao.addQuery("costKind");
        }

        // 년월
        if (xReq.getParam("YEAR_MON").equals("") != true) {
            dao.addQuery("yearMon");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 상세 비용통계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDetailCostList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/statistic/statistic", "/retrieveDetailCostList");
        dao.bind(xReq);

        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("ansDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("ansDateEnd");
        }

        // 비용구분(장기선급, 수수료)
        if (xReq.getParam("COST_KIND").equals("") != true) {
            dao.addQuery("costKind");
        }

        // 국내외구분
        if (xReq.getParam("NATION_DIV").equals("") != true) {
            dao.addQuery("nationDiv");
        }

        // 관납료/수수료 구분
        if (xReq.getParam("COST_DIV").equals("") != true) {
            dao.addQuery("costDiv");
        }

        // 사무소
        if (xReq.getParam("OFFICE_CODE").equals("") != true) {
            dao.addQuery("officeCode");
        }

        // 연구소
        if (xReq.getParam("LAB_CODE").equals("") != true) {
            dao.addQuery("labCode");
        }

        // 프로젝트
        if (xReq.getParam("PJT_CODE").equals("") != true) {
            dao.addQuery("pjtCode");
        }

        // 비용구분
        if (xReq.getParam("COST_PROC_DIV").equals("") != true) {
            dao.addQuery("procDiv");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/statistic/statistic", "/retrieveCostByAllListRT");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

}
