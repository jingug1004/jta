package anyfive.ipims.patent.schedule.sendmail.act;

import any.core.config.NConfig;
import any.core.service.common.NServiceResource;
import any.core.service.schedule.act.NAbstractScheduleAct;
import anyfive.ipims.patent.schedule.sendmail.biz.SendMailBiz;

/**
 * 메일 발송
 */
public class ExecuteSendMail implements NAbstractScheduleAct
{
    public void execute(String sid, NServiceResource nsr) throws Exception
    {
        int maxCount = NConfig.getInt("/config/e-mail/max-count");
        int exeCount = 0;

        nsr.openConnection(true);
        SendMailBiz biz = new SendMailBiz(nsr);
        while (exeCount < maxCount) {
            if (biz.executeSendMail() != true) break;
            exeCount++;
        }
        nsr.closeConnection();
    }
}
