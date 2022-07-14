package anyfive.ipims.office.costmgt.statistic.dao;

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
     * 사무소별 비용통계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostByOfficeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/statistic", "/retrieveCostByOfficeList");
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
     * 상세 비용통계 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDetailCostList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/statistic", "/retrieveDetailCostList");
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

        // 연구소
        if (xReq.getParam("LAB_CODE").equals("") != true) {
            dao.addQuery("labCode");
        }

        // 프로젝트
        if (xReq.getParam("PJT_CODE").equals("") != true) {
            dao.addQuery("pjtCode");
        }

        return dao.executeQueryForGrid(xReq);
    }

}
