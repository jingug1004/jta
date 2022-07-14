package anyfive.ipims.patent.schedule.insaif.act;
import any.core.service.common.NServiceResource;
import any.core.service.schedule.act.NAbstractScheduleAct;
import anyfive.ipims.patent.schedule.insaif.biz.ExecuteInsaIFBiz;

/**
 * 사용자 목록 조회
 */
public class ExecuteInsaTempIF implements NAbstractScheduleAct
{
    public void execute(String sid, NServiceResource nsr) throws Exception
    {
        nsr.openConnection(true);
        ExecuteInsaIFBiz biz = new ExecuteInsaIFBiz(nsr);
        biz.retrieveUsrInfo();
        nsr.closeConnection();

    }
}
