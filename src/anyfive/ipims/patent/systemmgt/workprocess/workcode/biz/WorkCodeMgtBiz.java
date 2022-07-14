package anyfive.ipims.patent.systemmgt.workprocess.workcode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.workprocess.workcode.dao.WorkCodeMgtDao;

public class WorkCodeMgtBiz extends NAbstractServletBiz
{
    public WorkCodeMgtBiz(NServiceResource nsr)
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
        WorkCodeMgtDao dao = new WorkCodeMgtDao(this.nsr);

        return dao.retrieveWorkCodeMgtList(xReq);
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
        WorkCodeMgtDao dao = new WorkCodeMgtDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveWorkCodeMgt(xReq));
        result.set("ds_codeNameList", dao.retrieveWorkCodeNameList(xReq));

        return result;
    }

    /**
     * 업무코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createWorkCodeMgt(AjaxRequest xReq) throws NException
    {
        WorkCodeMgtDao dao = new WorkCodeMgtDao(this.nsr);

        xReq.setUserData("CODE_VALUE", dao.retrieveWorkCodeValue(xReq));

        dao.createWorkCodeMgt(xReq);
    }

    /**
     * 업무코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateWorkCodeMgt(AjaxRequest xReq) throws NException
    {
        WorkCodeMgtDao dao = new WorkCodeMgtDao(this.nsr);

        dao.deleteWorkCodeMgt(xReq);
        dao.createWorkCodeMgt(xReq);
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
        WorkCodeMgtDao dao = new WorkCodeMgtDao(this.nsr);

        return dao.retrieveWorkCodeSearchList(xReq);
    }
}
