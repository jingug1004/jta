package anyfive.ipims.office.costmgt.costview.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CostViewDao extends NAbstractServletDao
{
    public CostViewDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 건별비용현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostViewList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/costview", "/retrieveCostViewList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchNo");
        }
        // 국내외
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }
        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }
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

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 건별비용현황 상세비용 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData RetrieveCostViewInputList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/costview", "/retrieveCostViewInputList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
