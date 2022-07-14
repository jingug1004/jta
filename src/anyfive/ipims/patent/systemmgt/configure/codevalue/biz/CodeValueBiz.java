package anyfive.ipims.patent.systemmgt.configure.codevalue.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.codevalue.dao.CodeValueDao;

public class CodeValueBiz extends NAbstractServletBiz
{
    public CodeValueBiz(NServiceResource nsr)
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
        CodeValueDao dao = new CodeValueDao(this.nsr);

        return dao.retrieveCodeValueList(xReq);
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
        CodeValueDao dao = new CodeValueDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveCodeValue(xReq));
        result.set("ds_codeNameList", dao.retrieveCodeNameList(xReq));

        return result;
    }

    /**
     * 공통코드 값 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createCodeValue(AjaxRequest xReq) throws NException
    {
        CodeValueDao dao = new CodeValueDao(this.nsr);

        if (dao.retrieveCodeValueExists(xReq) == true) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        xReq.setUserData("CODE_VALUE", dao.retrieveMaxCodeValue(xReq));

        dao.createCodeValue(xReq);
        dao.createCodeNameList(xReq);
    }

    /**
     * 공통코드 값 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCodeValue(AjaxRequest xReq) throws NException
    {
        CodeValueDao dao = new CodeValueDao(this.nsr);

        dao.updateCodeValue(xReq);
        dao.deleteCodeNameList(xReq);
        dao.createCodeNameList(xReq);
    }

    /**
     * 공통코드 값 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCodeValue(AjaxRequest xReq) throws NException
    {
        CodeValueDao dao = new CodeValueDao(this.nsr);

        dao.deleteCodeNameList(xReq);
        dao.deleteCodeValue(xReq);
    }

    /**
     * 공통코드 값 표시순서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCodeValueDispOrdList(AjaxRequest xReq) throws NException
    {
        CodeValueDao dao = new CodeValueDao(this.nsr);

        dao.updateCodeValueDispOrdList(xReq);
    }
}
