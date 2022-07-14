package anyfive.ipims.patent.systemmgt.workprocess.workcode.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class WorkCodeMgtDao extends NAbstractServletDao
{
    public WorkCodeMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업무코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkCodeMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workcode", "/retrieveWorkCodeMgtList");
        dao.bind(xReq);

        if (xReq.getParam("CODE_KIND").equals("") != true) {
            dao.addQuery("codeKind");
        }

        if (xReq.getParam("CODE_NAME").equals("") != true) {
            dao.addQuery("codeName");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 업무코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workcode", "/retrieveWorkCodeMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 업무코드 언어별 코드명 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveWorkCodeNameList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workcode", "/retrieveWorkCodeNameList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 업무코드 값 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveWorkCodeValue(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workcode", "/retrieveWorkCodeValue");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 업무코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createWorkCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workcode", "/createWorkCodeMgt");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiDataWithoutDeleteRow("ds_codeNameList"));
    }

    /**
     * 업무코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteWorkCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workcode", "/deleteWorkCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 업무코드 목록 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkCodeSearchList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/workprocess/workcode", "/retrieveWorkCodeSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
