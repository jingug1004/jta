package anyfive.ipims.patent.schedule.assetif.act;

import any.core.service.common.NServiceResource;
import any.core.service.schedule.act.NAbstractScheduleAct;
import anyfive.ipims.patent.schedule.assetif.biz.ExecuteAssetIFBiz;

/**
 * 전표 정보 I/F
 */
public class ExecuteAssetIF implements NAbstractScheduleAct
{
    public void execute(String sid, NServiceResource nsr) throws Exception
    {
        nsr.openConnection(true);
        ExecuteAssetIFBiz biz = new ExecuteAssetIFBiz(nsr);
        biz.updateAssetInfo();
        nsr.closeConnection();
    }
}
