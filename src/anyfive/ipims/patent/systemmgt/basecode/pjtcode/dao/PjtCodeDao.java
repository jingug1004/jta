package anyfive.ipims.patent.systemmgt.basecode.pjtcode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PjtCodeDao extends NAbstractServletDao
{
    public PjtCodeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로젝트코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePjtCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/pjtcode", "/retrievePjtCodeList");
        dao.bind(xReq);

        if (xReq.getParam("PJT_CODE").equals("") != true) {
            dao.addQuery("pjtCode");
        }

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 프로젝트코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPjtCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/pjtcode", "/createPjtCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 프로젝트코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePjtCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/pjtcode", "/retrievePjtCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 프로젝트코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePjtCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/pjtcode", "/updatePjtCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 프로젝트코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deletePjtCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/pjtcode", "/deletePjtCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
