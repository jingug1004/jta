package anyfive.ipims.patent.applymgt.priorjob.officereq.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PriorJobOfficeReqDao extends NAbstractServletDao
{
    public PriorJobOfficeReqDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     *  사무소요청사항 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorJobOfficeReqList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/officereq", "/retrievePriorJobOfficeReqList");
        dao.bind(xReq);

        // 국가구분
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 요청자
        if (xReq.getParam("USER_SEARCH_GUBUN").equals("") != true && xReq.getParam("REQ_USER_NAME_NO").equals("") != true) {
            if (xReq.getParam("USER_SEARCH_GUBUN").equals("EMP_NAME")) {
                dao.addQuery("empName");
            } else {
                dao.addQuery("empNo");
            }
        }

        // 처리상태
        if (xReq.getParam("STATUS").equals("") != true) {
            dao.addQuery("status");
        }

        // 의뢰번호
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }

        // 특허담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }

        // 사무소선택
        if (xReq.getParam("OFFICE_CODE").equals("") != true) {
            dao.addQuery("officeCode");
        }

        // 요청일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     *  사무소요청사항 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorJobOfficeReq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/officereq", "/retrievePriorJobOfficeReq");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 사무소요청사항 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePriorJobOfficeReq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/officereq", "/updatePriorJobOfficeReq");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
