package anyfive.ipims.patent.systemmgt.configure.codevalue.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CodeValueDao extends NAbstractServletDao
{
    public CodeValueDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 공통코드 값 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCodeValueList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/retrieveCodeValueList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 공통코드 값 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCodeValue(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/retrieveCodeValue");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 공통코드 이름 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveCodeNameList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/retrieveCodeNameList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 공통코드 값 중복여부 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public boolean retrieveCodeValueExists(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/retrieveCodeValueExists");
        dao.bind(xReq);

        return (dao.executeQueryForString().equals("0") != true);
    }

    /**
     * 공통코드 값(MAX) 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveMaxCodeValue(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/retrieveMaxCodeValue");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 공통코드 값 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCodeValue(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/createCodeValue");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 공통코드 값 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCodeValue(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/updateCodeValue");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 공통코드 값 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCodeValue(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/deleteCodeValue");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 공통코드 이름 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCodeNameList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/deleteCodeNameList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 공통코드명 목록 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createCodeNameList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/createCodeNameList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiDataWithoutDeleteRow("ds_codeNameList"));
    }

    /**
     * 공통코드 값 표시순서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateCodeValueDispOrdList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/codevalue", "/updateCodeValueDispOrdList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_codeValueList"));
    }
}
