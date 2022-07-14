package anyfive.framework.file.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.config.NConfig;
import any.core.dataset.NSingleData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.envmap.NEnvMapUtil;
import any.util.etc.NTextUtil;
import any.util.file.NFileConfig;
import any.util.file.NFileDownload;
import any.util.file.NFileUtil;
import any.util.uuid.NUUID;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.file.util.DRMUtil;
import anyfive.framework.file.util.FTPUtil;
import anyfive.framework.file.util.FileUtil;

/**
 * 파일 다운로드
 */
public class DownloadFile implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        NFileDownload fileDown = new NFileDownload(req, res);

        String error = null;

        if (xReq.getParam("TEMPLATE_PATH").equals("") != true) {
            if (xReq.getParam("TEMPLATE_PATH").indexOf("..") != -1) {
                error = "다운로드할 수 없는 파일입니다.";
            } else {
                fileDown.download(NEnvMapUtil.getEnvPath("filetemplate") + xReq.getParam("TEMPLATE_PATH"));
            }
        } else {
            nsr.openConnection();
            FileBiz biz = new FileBiz(nsr);
            NSingleData fileInfo = biz.retrieveFileDownload(xReq);
            nsr.closeConnection();

            String policy = fileInfo.getString("FILE_POLICY");
            String subPath = NFileConfig.getConfig(policy, "sub-path");
            String filePath = fileInfo.getString("FILE_PATH");
            String fileName = fileInfo.getString("FILE_NAME");
            String originalFileName = fileInfo.getString("FILE_NAME_ORG");

            boolean ftpEnable = NConfig.getBoolean("/config/ftp/enable");
            System.out.println("****ftpEnable*****==>:"+ftpEnable);
            String saveFilePath;

            if (ftpEnable) {
                saveFilePath = FileUtil.getSaveFilePath(fileInfo, NUUID.randomUUID().toString() + "_");
                FTPUtil ftp = new FTPUtil();
                try {
                    ftp.open();
                    ftp.get(subPath + filePath + "/" + fileName, saveFilePath);
                } catch (Exception e) {
                    throw e;
                } finally {
                    ftp.close();
                }
            } else {
                saveFilePath = FileUtil.getSaveFilePath(fileInfo);
            }

            fileDown.download(DRMUtil.extract(saveFilePath), originalFileName);

            if (ftpEnable) {
                NFileUtil.deleteFile(saveFilePath);
            }
        }

        if (error == null) {
            switch (fileDown.getResult()) {
            case NFileDownload.RESULT_SUCCESS:
                return;
            case NFileDownload.RESULT_FILE_NOT_EXISTS:
                error = nsr.message.get("msg.com.file.notexists").toString();
                break;
            case NFileDownload.RESULT_UNDEFINED_NAME:
                error = nsr.message.get("msg.com.file.undefinedname").toString();
                break;
            default:
                error = fileDown.getMessage();
                break;
            }
        }

        res.reset();
        res.setContentType("text/html; charset=utf-8");
        res.getWriter().println("<SCRIPT language=\"JScript\">");
        res.getWriter().println("alert(\"[ERROR] " + NTextUtil.toJS(error) + "\");");
        res.getWriter().println("window.location.replace(\"about:blank\");");
        res.getWriter().println("</SCRIPT>");
    }
}
