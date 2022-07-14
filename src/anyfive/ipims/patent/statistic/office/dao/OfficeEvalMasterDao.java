package anyfive.ipims.patent.statistic.office.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class OfficeEvalMasterDao extends NAbstractServletDao
{
    public OfficeEvalMasterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사무소평가현황 목록조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeEvalMasterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/officeEval", "/retrieveOfficeEvalMasterList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_TYPE").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if (xReq.getParam("SEARCH_TYPE").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if (xReq.getParam("SEARCH_TYPE").equals("REG_NO")) {
                dao.addQuery("regNO");
            }
        }


        if (xReq.getParam("SEARCH_NO_ONLY").equals("1") != true) {
            // 출원국가
            if (xReq.getParam("COUNTRY_CODE").equals("") != true) {
                dao.addQuery("countryCd");
            }

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 사무소
            if (xReq.getParam("OFFICE_CODE").equals("") != true) {
                dao.addQuery("officeCode");
            }

            // 검색일자
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
     * 사무소평가현황 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeEvalMasterDetail(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/officeEval", "/retrieveOfficeEvalMasterDetail");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 종합평가의견조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalOpinionView(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/officeEval", "/retrieveEvalOpinionView");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 세부평가항목조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveEvalItem(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/statistic/officeEval", "/retrieveEvalItem");
        dao.bind(xReq);

        return dao.executeQuery();
    }

}
