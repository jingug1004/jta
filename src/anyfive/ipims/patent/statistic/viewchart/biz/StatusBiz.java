package anyfive.ipims.patent.statistic.viewchart.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.statistic.viewchart.dao.StatusDao;

public class StatusBiz extends NAbstractServletBiz
{
    public StatusBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 부서별 출원현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByDeptChart(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByDeptChart(xReq);
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
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByDeptChartForGrid(xReq);
    }
    /**
     * 부서별 등록현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByDeptRegChart(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByDeptRegChart(xReq);
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
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByDeptRegChartForGrid(xReq);
    }
    /**
     * 부서별 출원/등록현황 리스트 상세
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDeptChartDetail(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        if (xReq.getParam("DEPT_CODE") != "" && xReq.getParam("COL1").toString().equals("출원")) {
            return dao.retrieveStatusByDeptPopApp(xReq);
        }
        else if (xReq.getParam("DEPT_CODE") != "" && xReq.getParam("COL1").toString().equals("등록")) {
            return dao.retrieveStatusByDeptPopReg(xReq);
        }
        else if (xReq.getParam("DEPT_CODE") == "" && xReq.getParam("COL1").toString().equals("출원")) {
            return dao.retrieveStatusByNoDeptPopApp(xReq);
        }
        else {
            return dao.retrieveStatusByNoDeptPopReg(xReq);
        }
    }

    /**
     * 부서별 등록현황 리스트 상세
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDeptRegChartDetail(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        if (xReq.getParam("DEPT_CODE") != "" && xReq.getParam("COL1").toString().equals("출원")) {
            return dao.retrieveStatusByDeptPopApp(xReq);
        }
        else if (xReq.getParam("DEPT_CODE") != "" && xReq.getParam("COL1").toString().equals("등록")) {
            return dao.retrieveStatusByDeptPopReg(xReq);
        }
        else if (xReq.getParam("DEPT_CODE") == "" && xReq.getParam("COL1").toString().equals("출원")) {
            return dao.retrieveStatusByNoDeptPopApp(xReq);
        }
        else {
            return dao.retrieveStatusByNoDeptPopReg(xReq);
        }
    }
    /**
     * 전체 출원/등록현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByAllChart(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByAllChart(xReq);
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
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByAllChartForGrid(xReq);
    }

    /**
     * 전체 출원/등록현황 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAllChartDetail(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);

        if (xReq.getParam("COL1").toString().equals("진행중")) {
            return dao.retrieveStatusByAllGoing(xReq);
        } else if (xReq.getParam("COL1").toString().equals("출원")) {
            return dao.retrieveStatusByAllApp(xReq);
        } else if (xReq.getParam("COL1").toString().equals("등록")) {
            return dao.retrieveStatusByAllReg(xReq);
        } else{
            return dao.retrieveStatusByAllGiveUp(xReq);
        }
    }

    /**
     * 개인 출원/등록현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByPersonChart(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByPersonChart(xReq);
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
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByPersonChartForGrid(xReq);
    }

    /**
     * 개인 출원/등록현황 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePersonChartDetail(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);

        if (xReq.getParam("COL1").toString().equals("진행중")) {
            return dao.retrieveStatusByPersonGoing(xReq);
        } else if (xReq.getParam("COL1").toString().equals("출원")) {
            return dao.retrieveStatusByPersonApp(xReq);
        } else if (xReq.getParam("COL1").toString().equals("등록")) {
            return dao.retrieveStatusByPersonReg(xReq);
        } else{
            return dao.retrieveStatusByPersonGiveUp(xReq);
        }
    }
    /**
     * 연구소별 출원/등록현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByLabChart(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByLabChart(xReq);
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
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByLabChartForGrid(xReq);
    }

    /**
     * 연구소별 출원/등록현황 상세 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLabChartDetail(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        if (xReq.getParam("LAB_CODE") != "" && xReq.getParam("COL1").toString().equals("출원")) {
            return dao.retrieveStatusByLabPopApp(xReq);
        }
        else if (xReq.getParam("LAB_CODE") != "" && xReq.getParam("COL1").toString().equals("등록")) {
            return dao.retrieveStatusByLabPopReg(xReq);
        }
        else if (xReq.getParam("LAB_CODE") == "" && xReq.getParam("COL1").toString().equals("출원")) {
            return dao.retrieveStatusByNoLabPopApp(xReq);
        }
        else {
            return dao.retrieveStatusByNoLabPopReg(xReq);
        }
    }

    /**
     * 년도별 출원/등록현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByYearChart(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByYearChart(xReq);
    }
    /**
     * 년도별 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData  retrieveStatusByYearChartForGrid(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByYearChartForGrid(xReq);
    }

    /**
     * 년도별 출원/등록현황 상세 리스트(출원)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData  retrieveStatusByYearChartDetailApp(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByYearChartDetailApp(xReq);
    }
    /**
     * 년도별 출원/등록현황 상세 리스트(등록)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData  retrieveStatusByYearChartDetailReg(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByYearChartDetailReg(xReq);
    }

    /**
     * 국가별 출원/등록현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByNationChart(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByNationChart(xReq);
    }

    /**
     * 국가별 특허보유현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByNationChartAll(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByNationChartAll(xReq);
    }

    /**
     * 기술별 특허보유현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByTechChartAll(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByTechChartAll(xReq);
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
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByNationChartForGrid(xReq);
    }


    /**
     *  메인 팝업 국가별 출원/등록현황 리스트
     *
     * @param xReq
     * @throws NException
     * @return
     */
    public NSingleData retrieveMainNationChartList(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveMainNationChartList(xReq);
    }

    /**
     *  메인 팝업 기술별 출원/등록현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMainTechChartList(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveMainTechChartList(xReq);
    }

    /**
     * 국가별 출원/등록현황 상세리스트(출원)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNationChartDetailApp(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByNationChartDetailApp(xReq);
    }
    /**
     * 국가별 출원/등록현황 상세리스트(등록)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByNationChartDetailReg(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByNationChartDetailReg(xReq);
    }

    /**
     * 출원목표 대비 실적현황 차트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveStatusByGoalChart(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByGoalChart(xReq);
    }

    /**
     * 출원목표 대비 실적현황 리스트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByGoalChartForGrid(AjaxRequest xReq) throws NException
    {
        StatusDao dao = new StatusDao(this.nsr);
        return dao.retrieveStatusByGoalChartForGrid(xReq);
    }

}
