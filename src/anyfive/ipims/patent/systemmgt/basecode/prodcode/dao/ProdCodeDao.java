package anyfive.ipims.patent.systemmgt.basecode.prodcode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ProdCodeDao extends NAbstractServletDao
{
    public ProdCodeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 제품코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProdCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/prodcode", "/retrieveProdCodeList");
        dao.bind(xReq);

        if (xReq.getParam("PROD_CODE").equals("") != true) {
            dao.addQuery("prodCode");
        }

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 제품코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createProdCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/prodcode", "/createProdCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 제품코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProdCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/prodcode", "/retrieveProdCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 제품코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateProdCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/prodcode", "/updateProdCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 제품코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteProdCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/prodcode", "/deleteProdCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
