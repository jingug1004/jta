package anyfive.ipims.patent.applymgt.tmark.extmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.extmaster.biz.TMarkExtMasterBiz;

/**
 * 상표국내출원마스터 수정
 */
public class UpdateTMarkExtMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TMarkExtMasterBiz biz = new TMarkExtMasterBiz(nsr);
        biz.updateTMarkExtMaster(xReq);
        nsr.closeConnection();
    }
}
