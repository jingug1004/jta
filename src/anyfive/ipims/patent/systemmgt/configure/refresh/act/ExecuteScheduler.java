package anyfive.ipims.patent.systemmgt.configure.refresh.act;

import java.lang.reflect.Constructor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.config.NConfig;
import any.core.exception.NBizException;
import any.core.service.common.NServiceResource;
import any.core.service.schedule.act.NAbstractScheduleAct;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.etc.NDateUtil;
import anyfive.framework.ajax.AjaxRequest;

/**
 * 스케줄러 실행
 */
public class ExecuteScheduler implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        String scheduleName = xReq.getParam("SCHEDULE_NAME");
        String configPath = NConfig.SCHEDULE_CONFIG + "/schedule[@name=\"" + scheduleName + "\"]/path";

        if (NConfig.getExists(configPath) != true) {
            throw new NBizException("존재하지 않는 스케줄 [" + scheduleName + "] 입니다.");
        }

        Class<?> bizClass = Class.forName(NConfig.getString(configPath));
        Constructor<?> constructor = bizClass.getConstructor(new Class[] {});
        NAbstractScheduleAct instance = (NAbstractScheduleAct)constructor.newInstance(new Object[] {});
        instance.execute(NDateUtil.getTimestampWithoutSymbol() + "000", nsr);
    }
}
