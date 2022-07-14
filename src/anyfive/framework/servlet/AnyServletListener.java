package anyfive.framework.servlet;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import any.core.config.NConfig;
import any.core.config.NConfigRefresher;
import any.core.service.common.NServiceResource;
import any.core.service.schedule.NScheduleTimer;

public class AnyServletListener implements ServletContextListener
{
    public void contextInitialized(ServletContextEvent sce)
    {
        this.initContext();

        NScheduleTimer.start();
    }

    public void contextDestroyed(ServletContextEvent sce)
    {
        NScheduleTimer.stop();
    }

    private void initContext()
    {
        if (NConfig.getBoolean(NConfig.DEFAULT_CONFIG + "/context-initialize") != true) return;

        NServiceResource.initConnection();
        NConfigRefresher.refresh();
    }
}
