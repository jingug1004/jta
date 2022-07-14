package anyfive.ipims.patent.systemmgt.configure.refresh.biz;

import any.core.config.NConfigRefresher;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.schedule.NScheduleTimer;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;

public class ConfigureBiz extends NAbstractServletBiz
{
    public ConfigureBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 환경정보 Refresh
     *
     * @param xReq
     * @throws NException
     */
    public void refreshConfigure(AjaxRequest xReq) throws NException
    {
        NConfigRefresher.refresh(Short.parseShort(xReq.getParam("TYPE"), 10));
    }

    /**
     * 스케줄러 재시작
     *
     * @throws NException
     */
    public void restartScheduler() throws NException
    {
        NScheduleTimer.stop();
        NScheduleTimer.start();
    }
}
