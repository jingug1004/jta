package anyfive.framework.file.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.file.NFileConfig;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;

/**
 * 파일 업로드 진행상태 조회
 */
public class RetrieveFileConfig implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        String policy = xReq.getParam("policy");

        NSingleData result = new NSingleData();

        result.setString("POLICY", policy);
        result.setString("INCLUDE_EXTENSIONS", NFileConfig.getConfig(policy, "include-extensions"));
        result.setString("EXCLUDE_EXTENSIONS", NFileConfig.getConfig(policy, "exclude-extensions"));

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, xReq.getParam("DS"));
    }
}
