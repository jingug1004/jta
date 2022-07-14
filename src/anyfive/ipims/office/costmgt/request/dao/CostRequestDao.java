package anyfive.ipims.office.costmgt.request.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CostRequestDao extends NAbstractServletDao
{
    public CostRequestDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용청구 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostRequestList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/request", "/retrieveCostRequestList");
        dao.bind(xReq);

        // 국가
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 청구서명
        if (xReq.getParam("REQ_SUBJECT").equals("") != true) {
            dao.addQuery("reqSubject");
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

        return dao.executeQueryForGrid(xReq);
    }
}
