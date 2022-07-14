package anyfive.ipims.patent.systemmgt.configure.codegroup.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CodeGroupDao extends NAbstractServletDao
{
    public CodeGroupDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 코드그룹 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCodeGroupList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codegroup", "/retrieveCodeGroupList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        if (xReq.getParam("USE_YN").equals("") != true) {
            dao.addQuery("useYn");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 코드그룹 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCodeGroup(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codegroup", "/retrieveCodeGroup");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 코드그룹 중복여부 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public boolean retrieveCodeGroupExists(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codegroup", "/retrieveCodeGroupExists");
        dao.bind(xReq);

        return (dao.executeQueryForString().equals("0") != true);
    }

    /**
     * 코드그룹(MAX) 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveMaxCodeGroup(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codegroup", "/retrieveMaxCodeGroup");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 코드그룹 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCodeGroup(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codegroup", "/createCodeGroup");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 코드그룹 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCodeGroup(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codegroup", "/updateCodeGroup");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 코드그룹 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCodeGroup(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codegroup", "/deleteCodeGroup");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
