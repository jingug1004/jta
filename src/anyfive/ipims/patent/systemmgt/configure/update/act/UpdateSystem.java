package anyfive.ipims.patent.systemmgt.configure.update.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.exception.NBizException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.update.biz.SystemUpdateBiz;
import anyfive.ipims.patent.systemmgt.configure.update.util.SystemUpdateUtil;

/**
 * 업데이트 시스템
 */
public class UpdateSystem implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        String pathname = SystemUpdateUtil.getUpdateSourceRoot() + "/" + xReq.getParam("FILE_NAME");
        boolean deleteFile = xReq.getParam("DELETE_FILE").equals("1");

        SystemUpdateBiz biz = new SystemUpdateBiz(nsr);

        if (pathname.toUpperCase().endsWith(".DDL")) {
            nsr.openConnection();
            biz.updateSystemDBSchema(pathname, deleteFile);
            nsr.closeConnection();
            return;
        }

        if (pathname.toUpperCase().endsWith(".SQL")) {
            nsr.openConnection();
            biz.updateSystemDBData(pathname, deleteFile);
            nsr.closeConnection();
            return;
        }

        if (pathname.toUpperCase().endsWith(".ZIP")) {
            biz.updateSystemProgram(pathname, deleteFile);
            return;
        }

        throw new NBizException("업데이트 파일 형식이 아닙니다.");
    }
}
