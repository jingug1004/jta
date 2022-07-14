package anyfive.ipims.patent.systemmgt.configure.refresh.act;

import java.net.InetAddress;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.etc.NDateUtil;
import anyfive.framework.ajax.AjaxResponse;

/**
 * 메모리 정보 조회
 */
public class RetrieveMemoryInfo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        NSingleData result = new NSingleData();

        Runtime rt = Runtime.getRuntime();

        result.setString("HOST_NAME", InetAddress.getLocalHost().getHostName());
        result.setString("HOST_ADDR", InetAddress.getLocalHost().getHostAddress());
        result.setString("MEASURE_TIME", NDateUtil.getFormatDate("yyyy-MM-dd HH:mm:ss"));

        long total = rt.totalMemory() / 1024;
        long free = rt.freeMemory() / 1024;

        result.setString("FULL_MEMORY_SIZE", Long.toString(total));
        result.setString("USED_MEMORY_SIZE", Long.toString(total - free));
        result.setString("FREE_MEMORY_SIZE", Long.toString(free));

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, "ds_memoryInfo");
    }
}
