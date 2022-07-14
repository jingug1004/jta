package anyfive.framework.file.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.config.NConfig;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.etc.NTextUtil;
import any.util.file.NFileConfig;
import any.util.file.NFileUpload;
import any.util.file.NFileUploadInfo;
import any.util.file.NFileUtil;
import any.util.uuid.NUUID;
import anyfive.framework.file.util.DRMUtil;
import anyfive.framework.file.util.FTPUtil;
import anyfive.framework.sequence.biz.SequenceBiz;

/**
 * 파일 목록 업로드
 */
public class UploadFileList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        String fileId = req.getParameter("fileId");

        NFileUpload upFile = new NFileUpload(req, req.getParameter("policy"));
        FTPUtil ftp = new FTPUtil();

        res.getWriter().println("<SCRIPT language=\"JScript\">");

        boolean ftpEnable = NConfig.getBoolean("/config/ftp/enable");

        try {

            if (fileId == null || fileId.equals("")) {
                nsr.openConnection(true);
                SequenceBiz seq = new SequenceBiz(nsr);
                fileId = seq.getFileId();
            }

            res.getWriter().println("var fileList = [];");
            res.getWriter().println("var fileInfo;");

            if (ftpEnable) {
                ftp.open();
            }

            for (int i = 0; i < upFile.getFileList().size(); i++) {
                NFileUploadInfo fileInfo = (NFileUploadInfo)upFile.getFileList().get(i);

                String saveFilePath = DRMUtil.packaging(fileInfo.getUploadedFullPath(), fileInfo.getOriginalName());

                if (ftpEnable) {
                    ftp.put(saveFilePath, fileInfo.getUploadedSubPath() + fileInfo.getUploadedMonthFolder(), fileInfo.getUploadedName());
                    NFileUtil.deleteFile(saveFilePath);
                }

                res.getWriter().println("var fileInfo = {};");
                res.getWriter().println("fileInfo.FILE_POLICY = \"" + upFile.policy + "\";");
                res.getWriter().println("fileInfo.FILE_REPOSITORY = \"" + NFileConfig.getConfig(upFile.policy, "repository") + "\";");
                res.getWriter().println("fileInfo.FILE_PATH = \"" + fileInfo.getUploadedMonthFolder() + "\";");
                res.getWriter().println("fileInfo.FILE_NAME_ORG = \"" + fileInfo.getOriginalName() + "\";");
                res.getWriter().println("fileInfo.FILE_NAME = \"" + fileInfo.getUploadedName() + "\";");
                res.getWriter().println("fileInfo.DOWNLOAD_KEY = \"" + NUUID.randomUUID().toString().toUpperCase() + "\";");
                res.getWriter().println("fileInfo.FILE_EXT = \"" + fileInfo.getExtension() + "\";");
                res.getWriter().println("fileInfo.FILE_SIZE = \"" + fileInfo.getSize() + "\";");
                res.getWriter().println("fileList.push(fileInfo);");
            }

            res.getWriter().println("window.frameElement.uploadSuccess(\"" + fileId + "\", fileList);");

            nsr.closeConnection();

        } catch (Exception e) {
            for (int i = 0; i < upFile.getFileList().size(); i++) {
                NFileUtil.deleteFile(((NFileUploadInfo)upFile.getFileList().get(i)).getUploadedFullPath());
            }
            res.getWriter().println("window.frameElement.uploadFail(\"" + NTextUtil.toJS(e.getMessage()) + "\");");
            e.printStackTrace();
        } finally {
            nsr.closeConnection(true);
            if (ftpEnable) {
               ftp.close();
            }
        }

        res.getWriter().println("</SCRIPT>");
    }
}
