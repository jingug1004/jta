package anyfive.ipims.patent.systemmgt.basecode.ipccode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class IpcCodeDao extends NAbstractServletDao
{
    public IpcCodeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * IPC분류코드관리 트리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpcCodeTree(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/ipccode", "/retrieveIpcCodeTree");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * IPC분류코드관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpcCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/ipccode", "/retrieveIpcCodeList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * IPC분류코드관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createIpcCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/ipccode", "/createIpcCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpcCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/ipccode", "/retrieveIpcCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * IPC분류코드관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateIpcCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/ipccode", "/updateIpcCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteIpcCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/basecode/ipccode", "/deleteIpcCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
