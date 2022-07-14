package anyfive.ipims.patent.systemmgt.basecode.ipccode.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.ipccode.biz.IpcCodeBiz;

/**
 * IPC 코드관리 생성
 */
public class CreateIpcCode implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        IpcCodeBiz biz = new IpcCodeBiz(nsr);
        biz.createIpcCode(xReq);
        nsr.closeConnection();
    }
}
