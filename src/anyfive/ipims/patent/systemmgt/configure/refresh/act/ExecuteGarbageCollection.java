package anyfive.ipims.patent.systemmgt.configure.refresh.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;

/**
 * Garbage Collection 실행
 */
public class ExecuteGarbageCollection implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        System.gc();
        System.runFinalization();
    }
}
