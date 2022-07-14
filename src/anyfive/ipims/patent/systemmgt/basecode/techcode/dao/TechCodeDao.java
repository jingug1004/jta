package anyfive.ipims.patent.systemmgt.basecode.techcode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class TechCodeDao extends NAbstractServletDao
{
    public TechCodeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 기술코드관리 트리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTechCodeTree(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/techcode", "/retrieveTechCodeTree");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 기술코드관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTechCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/techcode", "/retrieveTechCodeList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 기술코드관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createTechCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/techcode", "/createTechCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 기술코드관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTechCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/techcode", "/retrieveTechCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 기술코드관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateTechCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/techcode", "/updateTechCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 기술코드관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteTechCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/techcode", "/deleteTechCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
