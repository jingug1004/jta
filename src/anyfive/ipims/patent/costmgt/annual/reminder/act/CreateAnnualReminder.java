package anyfive.ipims.patent.costmgt.annual.reminder.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.annual.reminder.biz.AnnualReminderBiz;

/**
 * 연차 Reminder 생성
 */
public class CreateAnnualReminder implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        AnnualReminderBiz biz = new AnnualReminderBiz(nsr);
        biz.createAnnualReminder(xReq);
        nsr.closeConnection();
    }
}
