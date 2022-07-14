package anyfive.ipims.patent.systemmgt.datahandle.masterdelete.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.masterdelete.biz.MasterDeleteBiz;

/**
 * 출원마스터 삭제 처리
 */
public class DeleteMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        MasterDeleteBiz biz = new MasterDeleteBiz(nsr);
        biz.deleteMaster(xReq);
        nsr.closeConnection();
    }
}
