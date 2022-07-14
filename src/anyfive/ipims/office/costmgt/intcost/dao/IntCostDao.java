package anyfive.ipims.office.costmgt.intcost.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class IntCostDao extends NAbstractServletDao
{
    public IntCostDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내비용입력 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntCostList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/intcost", "/retrieveIntCostList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchNo");
        }

        // 구분
        if (xReq.getParam("MST_DIV").equals("") != true) {
            dao.addQuery("mstDiv");
        }

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
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
     * 국내비용청구서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createIntCostRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/intcost", "/createIntCostRequest");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 국내비용입력 수정(청구서ID 설정)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateIntCostListReqId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/intcost", "/updateIntCostListReqId");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_intCostList"));
    }

    /**
     * 건별비용현황 상세비용 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntCostListR(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/costmgt/intcost", "/retrieveIntCostListR");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
