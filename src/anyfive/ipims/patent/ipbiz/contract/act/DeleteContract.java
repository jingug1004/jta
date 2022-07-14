package anyfive.ipims.patent.ipbiz.contract.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.ipbiz.contract.biz.ContractBiz;

public class DeleteContract implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        ContractBiz biz = new ContractBiz(nsr);
        biz.deleteContract(xReq);
        nsr.closeConnection();
    }
}
