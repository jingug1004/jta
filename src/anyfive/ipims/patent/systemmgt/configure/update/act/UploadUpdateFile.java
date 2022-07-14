package anyfive.ipims.patent.systemmgt.configure.update.act;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.etc.NCommonUtil;
import any.util.etc.NTextUtil;
import any.util.file.NFileUpload;
import any.util.file.NFileUploadInfo;
import any.util.file.NFileUtil;
import anyfive.ipims.patent.systemmgt.configure.update.util.SystemUpdateUtil;

/**
 * 업데이트 파일 업로드
 */
public class UploadUpdateFile implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        PrintWriter out = res.getWriter();

        try {

            NFileUpload upFile = new NFileUpload(req);

            if (SystemUpdateUtil.checkUpdateKey(upFile.getParamData().getString(0, "UPDATE_KEY")) != true) {
                out.println("<SCRIPT language=\"JScript\">");
                out.println("parent.fnUpload_OnUpdateKeyInvalid();");
                out.println("</SCRIPT>");
                return;
            }

            FileItem fileItem = null;
            for (int i = 0; i < upFile.getFileList().size(); i++) {
                fileItem = ((NFileUploadInfo)upFile.getFileList().get(i)).getFileItem();
                fileItem.write(new File(SystemUpdateUtil.getUpdateSourceRoot() + "/" + NFileUtil.getFileName(fileItem.getName())));
            }

            out.println("<SCRIPT language=\"JScript\">");
            out.println("parent.fnUpload_OnSuccess();");
            out.println("</SCRIPT>");

        } catch (Exception e) {
            out.println("<SCRIPT language=\"JScript\">");
            out.println("parent.fnUpload_OnFail(\"" + NTextUtil.toJS(NCommonUtil.getExceptionMessage(e)) + "\");");
            out.println("</SCRIPT>");
        }
    }
}
