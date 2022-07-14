package anyfive.ipims.patent.systemmgt.basecode.ipccode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.ipccode.dao.IpcCodeDao;


public class IpcCodeBiz extends NAbstractServletBiz
{
    public IpcCodeBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * IPC코드관리 트리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpcCodeTree(AjaxRequest xReq) throws NException
    {
        IpcCodeDao dao = new IpcCodeDao(this.nsr);

        return dao.retrieveIpcCodeTree(xReq);
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
        IpcCodeDao dao = new IpcCodeDao(this.nsr);

        return dao.retrieveIpcCodeList(xReq);
    }

    /**
     * IPC분류코드관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createIpcCode(AjaxRequest xReq) throws NException
    {
        IpcCodeDao dao = new IpcCodeDao(this.nsr);

        if (dao.retrieveIpcCode(xReq).isEmpty() != true) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        dao.createIpcCode(xReq);
    }

    /**
     * 기술코드관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpcCode(AjaxRequest xReq) throws NException
    {
        IpcCodeDao dao = new IpcCodeDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveIpcCode(xReq));

        return result;
    }

    /**
     * IPC분류코드관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIpcCode(AjaxRequest xReq) throws NException
    {
        IpcCodeDao dao = new IpcCodeDao(this.nsr);

        dao.updateIpcCode(xReq);
    }

    /**
     * IPC분류코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteIpcCode(AjaxRequest xReq) throws NException
    {
        IpcCodeDao dao = new IpcCodeDao(this.nsr);

        if (dao.deleteIpcCode(xReq) == 0) {
            throw new NBizException("[삭제 실패]\n\n하위메뉴가 있는 항목은 삭제할 수 없습니다.");
        }

    }
}
