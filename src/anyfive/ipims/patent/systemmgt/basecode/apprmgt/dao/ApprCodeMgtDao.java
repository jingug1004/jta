package anyfive.ipims.patent.systemmgt.basecode.apprmgt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ApprCodeMgtDao extends NAbstractServletDao
{
    public ApprCodeMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 결재관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprCodeMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/apprmgt", "/retrieveApprCodeMgtList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 결재관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/apprmgt", "/retrieveApprCodeMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 결재관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createApprCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/apprmgt", "/createApprCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 결재관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateApprCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/apprmgt", "/updateApprCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 결재관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteApprCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/apprmgt", "/deleteApprCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
