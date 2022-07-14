package anyfive.ipims.patent.applymgt.tmark.intmaster.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.intmaster.biz.TMarkIntMasterBiz;

/**
 * 상표국내출원마스터 수정
 */
public class UpdateTMarkIntMaster implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TMarkIntMasterBiz biz = new TMarkIntMasterBiz(nsr);
        biz.updateTMarkIntMaster(xReq);
        nsr.closeConnection();
    }
}
