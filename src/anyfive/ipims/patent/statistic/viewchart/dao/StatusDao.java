package anyfive.ipims.patent.statistic.viewchart.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import any.util.etc.NDateUtil;
import anyfive.framework.ajax.AjaxRequest;

public class StatusDao extends NAbstractServletDao
{
    public StatusDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 부서별 출원현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByDeptChart(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByDeptChart");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 부서별 등록현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByDeptRegChart(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByDeptRegChart");
        dao.bind(xReq);

        return dao.executeQuery();
    }
    /**
     * 부서별 출원현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByDeptChartForGrid(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByDeptChart");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
    /**
     * 부서별 등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByDeptRegChartForGrid(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByDeptRegChart");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }


    /**
     * 부서별 출원 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByDeptPopApp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByDeptPopApp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 부서별 등록 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByDeptPopReg(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByDeptPopReg");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 부서별 부서없음 출원 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNoDeptPopApp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNoDeptPopApp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 부서별 부서없음 등록 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNoDeptPopReg(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNoDeptPopReg");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 전체 출원/등록현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByAllChart(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByAllChart");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 전체 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByAllChartForGrid(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByAllChart");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 전체 진행중 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByAllGoing(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByAllPopGoing");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 전체 출원 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByAllApp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByAllPopApp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 전체 등록 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByAllReg(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByAllPopReg");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 전체 포기 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByAllGiveUp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByAllPopGiveUp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 개인 출원/등록현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByPersonChart(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByPersonChart");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 개인 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByPersonChartForGrid(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByPersonChart");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 개인 진행중 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByPersonGoing(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByPersonPopGoing");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 개인 출원 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByPersonApp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByPersonPopApp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 개인 등록 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByPersonReg(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByPersonPopReg");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 개인 포기 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByPersonGiveUp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByPersonPopGiveUp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연구소별 출원/등록현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByLabChart(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByLabChart");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 연구소별 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByLabChartForGrid(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByLabChart");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연구소별 출원 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByLabPopApp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByLabPopApp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연구소별 등록 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByLabPopReg(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByLabPopReg");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연구소없음 출원 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNoLabPopApp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNoLabPopApp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연구소없음 등록 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNoLabPopReg(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNoLabPopReg");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국가별 출원/등록현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByNationChart(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNationChart");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 국가별 특허보유현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByNationChartAll(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNationChartAll");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 기술별 특허보유현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByTechChartAll(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByTechChartAll");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 국가별 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNationChartForGrid(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNationChart");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 메인 팝업국가별 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMainNationChartList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveMainNationChartList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }


    /**
     * 메인 팝업기술별 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMainTechChartList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveMainTechChartList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국가별 출원/등록현황 상세 리스트(출원)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNationChartDetailApp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNationChartDetailApp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국가별 출원/등록현황 상세 리스트(등록)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNationChartDetailReg(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNationChartDetailReg");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 년도별 출원/등록현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByYearChart(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByYearChart");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 년도별 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByYearChartForGrid(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByYearChart");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 년도별 출원/등록현황 상세 리스트(출원)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByYearChartDetailApp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByYearChartDetailApp");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
    /**
     * 년도별 출원/등록현황 상세 리스트(등록)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByYearChartDetailReg(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByYearChartDetailReg");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 출원목표 대비 실적현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByGoalChart(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByGoalChart");
        dao.bind(xReq);

        dao.bind("PLAN_YEAR", NDateUtil.getFormatDate("yyyy"));

        return dao.executeQuery();
    }

    /**
     * 출원목표 대비 실적현황
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByGoalChartForGrid(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByGoalChartForGrid");
        dao.bind(xReq);

        dao.bind("PLAN_YEAR", NDateUtil.getFormatDate("yyyy"));

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연도별 리스트상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNationYearListDetail(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/viewchart", "/retrieveStatusByNationChartListDetail");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }
}
