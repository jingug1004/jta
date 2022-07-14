package anyfive.ipims.patent.systemmgt.configure.refresh.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.config.NConfig;
import any.core.exception.NBizException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.ipims.patent.systemmgt.configure.refresh.biz.ConfigureBiz;

/**
 * 스케줄러 재시작
 */
public class RestartScheduler implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        if (NConfig.getBoolean(NConfig.SCHEDULE_CONFIG + "/scheduler-enable") != true) {
            throw new NBizException("스케줄러가 활성화되어 있지 않습니다.");
        }

        ConfigureBiz biz = new ConfigureBiz(nsr);
        biz.restartScheduler();
    }
}
