package anyfive.ipims.patent.schedule.slipif.act;

import any.core.service.common.NServiceResource;
import any.core.service.schedule.act.NAbstractScheduleAct;
import anyfive.ipims.patent.schedule.slipif.biz.ExecuteSlipIFBiz;

/**
 * 전표 정보 I/F
 */
public class ExecuteSlipIF implements NAbstractScheduleAct
{
    public void execute(String sid, NServiceResource nsr) throws Exception
    {
        nsr.openConnection(true);
        ExecuteSlipIFBiz biz = new ExecuteSlipIFBiz(nsr);
        biz.updateSlipInfo();
        nsr.closeConnection();
    }
}
