package anyfive.framework.file.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.core.session.NSessionKeys;

/**
 * 파일 업로드 진행상태 초기화
 */
public class InitializeFileUploadInfo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        req.getSession().setAttribute(NSessionKeys.UPLOAD_INFO, null);
    }
}
