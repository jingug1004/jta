package anyfive.ipims.share.cost.input.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CostInputDao extends NAbstractServletDao
{
    public CostInputDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCost(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/input", "/createCost");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCost(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/input", "/retrieveCost");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 비용 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCost(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/input", "/updateCost");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCost(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/input", "/deleteCost");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
