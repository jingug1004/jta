package anyfive.ipims.patent.systemmgt.configure.codegroup.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.codegroup.dao.CodeGroupDao;

public class CodeGroupBiz extends NAbstractServletBiz
{
    public CodeGroupBiz(NServiceResource nsr)
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
        CodeGroupDao dao = new CodeGroupDao(this.nsr);

        return dao.retrieveCodeGroupList(xReq);
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
        CodeGroupDao dao = new CodeGroupDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveCodeGroup(xReq));

        return result;
    }

    /**
     * 코드그룹 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createCodeGroup(AjaxRequest xReq) throws NException
    {
        CodeGroupDao dao = new CodeGroupDao(this.nsr);

        if (dao.retrieveCodeGroupExists(xReq) == true) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        String codeGrp = dao.retrieveMaxCodeGroup(xReq);

        xReq.setUserData("CODE_GRP", codeGrp);

        dao.createCodeGroup(xReq);

        return codeGrp;
    }

    /**
     * 코드그룹 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCodeGroup(AjaxRequest xReq) throws NException
    {
        CodeGroupDao dao = new CodeGroupDao(this.nsr);

        dao.updateCodeGroup(xReq);
    }

    /**
     * 코드그룹 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCodeGroup(AjaxRequest xReq) throws NException
    {
        CodeGroupDao dao = new CodeGroupDao(this.nsr);

        dao.deleteCodeGroup(xReq);
    }
}
