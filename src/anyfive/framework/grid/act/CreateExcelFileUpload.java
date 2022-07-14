package anyfive.framework.grid.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Sheet;
import jxl.Workbook;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.etc.NTextUtil;
import any.util.file.NFileUpload;
import any.util.file.NFileUploadInfo;

/**
 * 엑셀파일 업로드
 */
public class CreateExcelFileUpload implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        NFileUpload upFile = new NFileUpload(req);

        Workbook workbook = null;
        Sheet sheet = null;

        if (upFile.getFileList().size() != 1) {
            this.throwException(res, "업로드된 파일정보가 올바르지 않습니다.");
            return;
        }

        try {
            workbook = Workbook.getWorkbook(((NFileUploadInfo)upFile.getFileList().get(0)).getFileItem().getInputStream());
        } catch (Exception e) {
            this.throwException(res, "올바른 엑셀파일이 아닙니다.");
            return;
        }

        if (workbook == null) {
            this.throwException(res, "올바른 엑셀파일이 아닙니다.");
            return;
        }

        int sheetNo = upFile.getParamData().getInt(0, "sheetNo");
        boolean firstRowTitle = upFile.getParamData().getString(0, "firstRowTitle").equals("1");

        try {
            sheet = workbook.getSheet(sheetNo - 1);
        } catch (Exception e) {
            workbook.close();
            this.throwException(res, "올바른 시트번호가 아닙니다.");
            return;
        }

        if (sheet == null) {
            workbook.close();
            this.throwException(res, "올바른 시트번호가 아닙니다.");
            return;
        }

        try {

            res.getWriter().println("<SCRIPT language=\"JScript\">");
            res.getWriter().println("top.window.returnValue = {");
            res.getWriter().println("rows:" + sheet.getRows() + ",cols:" + sheet.getColumns() + ",firstRowTitle:" + firstRowTitle + ",data:[null");

            for (int r = 0; r < sheet.getRows(); r++) {
                res.getWriter().print(",[" + (r + 1));
                for (int c = 0; c < sheet.getColumns(); c++) {
                    res.getWriter().print(",\"" + NTextUtil.toJS(sheet.getCell(c, r).getContents()) + "\"");
                }
                res.getWriter().println("]");
            }

            res.getWriter().println("]};");
            res.getWriter().println("top.window.close();");
            res.getWriter().println("</SCRIPT>");

        } catch (Exception e) {
            throw e;
        } finally {
            workbook.close();
        }
    }

    private void throwException(HttpServletResponse res, String message) throws Exception
    {
        res.getWriter().println("<SCRIPT language=\"JScript\">");
        res.getWriter().println("parent.fnShowError(\"" + NTextUtil.toJS(message) + "\");");
        res.getWriter().println("</SCRIPT>");
    }
}
