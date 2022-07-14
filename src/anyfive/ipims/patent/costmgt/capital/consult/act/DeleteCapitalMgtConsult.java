package anyfive.ipims.patent.costmgt.capital.consult.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.capital.consult.biz.CapitalMgtConsultBiz;
/**
 * 자본적 지출 확정 품의 취소(삭제)
 */
public class DeleteCapitalMgtConsult implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        CapitalMgtConsultBiz biz = new CapitalMgtConsultBiz(nsr);
        biz.deleteCapitalMgtConsult(xReq);
        nsr.closeConnection();
    }
}
