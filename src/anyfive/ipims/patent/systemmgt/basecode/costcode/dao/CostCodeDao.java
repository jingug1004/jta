package anyfive.ipims.patent.systemmgt.basecode.costcode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CostCodeDao extends NAbstractServletDao
{
    public CostCodeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/retrieveCostCodeList");
        dao.bind(xReq);

        if (xReq.getParam("MST_DIV").equals("") != true) {
            dao.addQuery("mstDiv");
        }

        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        if (xReq.getParam("GRAND_NAME").equals("") != true) {
            dao.addQuery("grandName");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 비용대분류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/retrieveCostCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 비용대분류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCostGrandCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/createCostGrandCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용대분류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/updateCostCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용대분류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCostCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/deleteCostCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 세부서류 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCostDetailCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/deleteCostDetailCodeList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 상세분류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostDetailCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/retrieveCostDetailCodeList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 상세분류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostDetailCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/retrieveCostDetailCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 세부서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCostDetailCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/createCostDetailCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 세부서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostDetailCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/updateCostDetailCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 세부서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCostDetailCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/costcode", "/deleteCostDetailCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
