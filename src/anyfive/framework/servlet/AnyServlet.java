package anyfive.framework.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.config.NConfig;
import any.core.message.NMessage;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.NServletService;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.etc.NCommonUtil;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.util.FileUtil;
import anyfive.framework.session.SessionUtil;
import anyfive.framework.userlog.act.CreateUserLog;

public class AnyServlet extends NServletService
{
    private static final long serialVersionUID = -9161451843141770483L;

    protected void execAction(NAbstractServletAct act, HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        if (SessionUtil.getLangCode(req) == null) {
            SessionUtil.setLangCode(req, NConfig.getString(NConfig.DEFAULT_CONFIG + "/default-lang-code"));
        }

        nsr.debugMode = SessionUtil.isDebugMode(req);
        nsr.langCode = SessionUtil.getLangCode(req);
        nsr.userInfo = SessionUtil.getUserInfo(req);
        nsr.message = new NMessage(nsr.langCode);

        try {
            FileUtil.initAttachFileList(nsr);
            act.execute(req, res, nsr);
            CreateUserLog.execute(req, res, null);
            FileUtil.deleteLocalFileList(nsr);
        } catch (Exception e) {
            CreateUserLog.execute(req, res, NCommonUtil.getExceptionMessage(e));
            FileUtil.deleteLocalFileList(new AjaxRequest(req));
            throw e;
        }
    }
}
