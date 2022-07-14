package anyfive.framework.file.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.core.session.NSessionKeys;
import any.util.file.uploadmonitor.NUploadInfo;
import anyfive.framework.ajax.AjaxResponse;

/**
 * 파일 업로드 진행상태 조회
 */
public class RetrieveFileUploadInfo implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        NUploadInfo uploadInfo = (NUploadInfo)req.getSession().getAttribute(NSessionKeys.UPLOAD_INFO);

        if (uploadInfo == null) return;

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(uploadInfo.getJSON());
    }
}
