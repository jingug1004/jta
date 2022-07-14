package anyfive.ipims.patent.applymgt.extpatent.group.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.extpatent.group.biz.ExtPatentGroupBiz;

/**
 * 해외출원품의 수정
 */
public class UpdateExtPatentGroup implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ExtPatentGroupBiz biz = new ExtPatentGroupBiz(nsr);
        biz.updateExtPatentGroup(xReq);
        nsr.closeConnection();
    }
}
