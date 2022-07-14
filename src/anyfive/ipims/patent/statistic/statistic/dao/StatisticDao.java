package anyfive.ipims.patent.statistic.statistic.dao;

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
     * 전체통계현황 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAllStatisticCount(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveAllStatisticCount");
        dao.bind(xReq);

        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("appDateStart");
            dao.addQuery("regDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("appDateEnd");
            dao.addQuery("regDateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 전체통계현황 조회 상세
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveStatusByAllStatisticsDetail(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveStatusByAllStatisticChartDetail");
        dao.bind(xReq);

        //출원
        if (xReq.getParam("COL2").equals("출원")) {
            dao.addQuery("app");
            if (xReq.getParam("COL1").toString().equals("국내특허")) dao.addQuery("intPatent");
            else if(xReq.getParam("COL1").toString().equals("해외특허")) dao.addQuery("extPatent");
            else if(xReq.getParam("COL1").toString().equals("국내실용신안")) dao.addQuery("intUtil");
            else if(xReq.getParam("COL1").toString().equals("해외실용신안")) dao.addQuery("extUtil");
            else if(xReq.getParam("COL1").toString().equals("국내디자인")) dao.addQuery("intDesign");
            else if(xReq.getParam("COL1").toString().equals("해외디자인")) dao.addQuery("extDesign");
            else if(xReq.getParam("COL1").toString().equals("국내상표")) dao.addQuery("intTmark");
            else if(xReq.getParam("COL1").toString().equals("해외상표")) dao.addQuery("extTmark");
        }
        //계류
        if (xReq.getParam("COL2").equals("계류")) {
            dao.addQuery("defer");
            if (xReq.getParam("COL1").toString().equals("국내특허")) dao.addQuery("intPatent");
            else if(xReq.getParam("COL1").toString().equals("해외특허")) dao.addQuery("extPatent");
            else if(xReq.getParam("COL1").toString().equals("국내실용신안")) dao.addQuery("intUtil");
            else if(xReq.getParam("COL1").toString().equals("해외실용신안")) dao.addQuery("extUtil");
            else if(xReq.getParam("COL1").toString().equals("국내디자인")) dao.addQuery("intDesign");
            else if(xReq.getParam("COL1").toString().equals("해외디자인")) dao.addQuery("extDesign");
            else if(xReq.getParam("COL1").toString().equals("국내상표")) dao.addQuery("intTmark");
            else if(xReq.getParam("COL1").toString().equals("해외상표")) dao.addQuery("extTmark");
        }
        //등록
        if (xReq.getParam("COL2").equals("등록")) {
            dao.addQuery("reg");
            if (xReq.getParam("COL1").toString().equals("국내특허")) dao.addQuery("intPatent");
            else if(xReq.getParam("COL1").toString().equals("해외특허")) dao.addQuery("extPatent");
            else if(xReq.getParam("COL1").toString().equals("국내실용신안")) dao.addQuery("intUtil");
            else if(xReq.getParam("COL1").toString().equals("해외실용신안")) dao.addQuery("extUtil");
            else if(xReq.getParam("COL1").toString().equals("국내디자인")) dao.addQuery("intDesign");
            else if(xReq.getParam("COL1").toString().equals("해외디자인")) dao.addQuery("extDesign");
            else if(xReq.getParam("COL1").toString().equals("국내상표")) dao.addQuery("intTmark");
            else if(xReq.getParam("COL1").toString().equals("해외상표")) dao.addQuery("extTmark");
        }

        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("appDateStart");
            dao.addQuery("regDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("appDateEnd");
            dao.addQuery("regDateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveIntApplyConsultList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("NO_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("REG_NO")) {
                dao.addQuery("regNO");
            }
        }

        if (xReq.getParam("SR_NO_ONLY").equals("1") != true) {

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 검색일자
            if (xReq.getParam("DATE_GUBUN").equals("") != true) {
                if (xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("dateStart");
                }
                if (xReq.getParam("DATE_END").equals("") != true) {
                    dao.addQuery("dateEnd");
                }
            }
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveExtApplyConsultList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("NO_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("NO_GUBUN").equals("GRP_NO")) {
                dao.addQuery("grpNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("RefNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("APP_NO")) {
                dao.addQuery("PatNo");
            }
        }

        if (xReq.getParam("SR_NO_ONLY").equals("1") != true) {

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 작성기간
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }

            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveIntMasterList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("NO_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("REG_NO")) {
                dao.addQuery("regNO");
            }
        }
        // 건담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }
        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveIntOAList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SR_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            dao.addQuery("searchNo");
        }
        // 건담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }
        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveExtMasterList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SR_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("SR_GUBUN").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if (xReq.getParam("SR_GUBUN").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if (xReq.getParam("SR_GUBUN").equals("REG_NO")) {
                dao.addQuery("regNO");
            }
        }
        // 건담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }
        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveExtOAList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SR_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            dao.addQuery("searchNo");
        }
        // 건담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }
        // 검색일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveActualByTechList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * IPC 국내실적통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveActualByIpcList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveActualByIpcList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveActualByProjectList");
        dao.bind(xReq);

        // Int_APP_date 검색
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("IntappDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("IntappDateEnd");
        }

        // Int 쿼리
        dao.addQuery("IntRegQuery");

        // Int_REG_DATE 검색
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("IntregDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("IntregDateEnd");
        }

        // Ext 쿼리
        dao.addQuery("ExtAppQuery");

        // Ext_APP_date 검색
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("ExtappDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("ExtappDateEnd");
        }

        dao.addQuery("ExtRegQuery");

        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("ExtregDateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("ExtregDateEnd");
        }

        dao.addQuery("EndQuery");

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveActualByLabList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveActualByLab");
        dao.bind(xReq);

        dao.addQuery("inOutDiv");

        if (xReq.getParam("SEARCH_GUBUN").equals("CRE") == true) {
            dao.addQuery("creDate");
        } else if (xReq.getParam("SEARCH_GUBUN").equals("APP") == true) {
            dao.addQuery("appDate");
        } else if (xReq.getParam("SEARCH_GUBUN").equals("REG") == true) {
            dao.addQuery("regDate");
        }
        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statisticlist", "/retrieveStatisticList_" + xReq.getParam("LIST_TYPE"));
        dao.bind(xReq);

        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        dao.addQuery("bottomQuery");

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * Delivery 현황(출원) 목록 조회
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDeliveryApplyList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveDeliveryApplyList");
        dao.bind(xReq);

        if (xReq.getParam("SR_REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }
        if (xReq.getParam("SR_OFFICE_NAME").equals("") != true) {
            dao.addQuery("officeName");
        }
        if (xReq.getParam("SR_OFFICE_JOB_CONTACT").equals("") != true) {
            dao.addQuery("officeJobContact");
        }
        if (xReq.getParam("SR_JOB_CONTACT").equals("") != true) {
            dao.addQuery("jobContact");
        }
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * Delivery 현황(OA) 목록 조회
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDeliveryOAList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveDeliveryOAList");
        dao.bind(xReq);

        if (xReq.getParam("SR_REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }
        if (xReq.getParam("SR_OFFICE_NAME").equals("") != true) {
            dao.addQuery("officeName");
        }
        if (xReq.getParam("SR_OFFICE_JOB_CONTACT").equals("") != true) {
            dao.addQuery("officeJobContact");
        }
        if (xReq.getParam("SR_JOB_CONTACT").equals("") != true) {
            dao.addQuery("jobContact");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * Delivery 통계현황 목록 조회
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDeliveryStatisticList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/statistic", "/retrieveDeliveryStatisticList");
        dao.bind(xReq);

        if (xReq.getParam("SR_REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }
        if (xReq.getParam("SR_OFFICE_NAME").equals("") != true) {
            dao.addQuery("officeName");
        }
        if (xReq.getParam("SR_OFFICE_JOB_CONTACT").equals("") != true) {
            dao.addQuery("officeJobContact");
        }
        if (xReq.getParam("SR_JOB_CONTACT").equals("") != true) {
            dao.addQuery("jobContact");
        }
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
