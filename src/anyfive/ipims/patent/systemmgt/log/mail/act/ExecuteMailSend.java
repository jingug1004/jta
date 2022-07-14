package anyfive.ipims.patent.systemmgt.log.mail.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.etc.NDateUtil;
import anyfive.ipims.patent.schedule.sendmail.act.ExecuteSendMail;

/**
 * 메일발송 처리
 */
public class ExecuteMailSend implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        new ExecuteSendMail().execute(NDateUtil.getTimestampWithoutSymbol() + "000", nsr);
    }
}
