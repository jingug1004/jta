package anyfive.ipims.patent.schedule.deptif.act;

import any.core.service.common.NServiceResource;
import any.core.service.schedule.act.NAbstractScheduleAct;
import anyfive.ipims.patent.schedule.deptif.biz.ExecuteDeptIFBiz;

/**
 * 부서정보 I/F
 */
public class ExecuteDeptIF implements NAbstractScheduleAct
{
    public void execute(String sid, NServiceResource nsr) throws Exception
    {
        nsr.openConnection(true);
        ExecuteDeptIFBiz biz = new ExecuteDeptIFBiz(nsr);
        biz.updateDeptInfo();
        nsr.closeConnection();
    }
}
