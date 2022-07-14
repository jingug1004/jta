package anyfive.ipims.office.applymgt.adjustreq.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AdjustReqDao extends NAbstractServletDao
{
    public AdjustReqDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     *  수정요청 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAdjustReqList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/applymgt/adjustreq", "/retrieveAdjustReqList");
        dao.bind(xReq);

        // 구분
        if (xReq.getParam("REQ_GUBUN").equals("") != true) {
            dao.addQuery("reqGubun");
        }

        // 의뢰번호
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }

        // 처리상태
        if (xReq.getParam("STATUS").equals("") != true) {
            dao.addQuery("status");
        }

        // 특허담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
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
     *  수정요청 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAdjustReq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/applymgt/adjustreq", "/retrieveAdjustReq");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     *  수정요청 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createAdjustReq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/applymgt/adjustreq", "/createAdjustReq");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 수정요청 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAdjustReq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/applymgt/adjustreq", "/updateAdjustReq");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     *  수정요청 처리결과 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAdjustReqResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/applymgt/adjustreq", "/retrieveAdjustReqResult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }
}
