package anyfive.framework.grid.util;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.CellView;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.DateFormat;
import jxl.write.DateTime;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.NumberFormat;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import any.core.dataset.NDataProtocol;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.exception.NSysException;
import any.util.ajax.NAjaxUtil;
import any.util.etc.NTextUtil;
import any.util.file.NFileDownload;
import anyfive.framework.ajax.AjaxRequest;

public class GridResponse
{
    private HttpServletRequest  req  = null;
    private HttpServletResponse res  = null;

    private AjaxRequest         xReq = null;

    public GridResponse(HttpServletRequest req, HttpServletResponse res) throws NException
    {
        this.req = req;
        this.res = res;

        this.xReq = new AjaxRequest(this.req);

        this.setContentType("text/xml; charset=utf-8");
    }

    public void setContentType(String contentType)
    {
        this.res.setContentType(contentType);
    }

    public void flush(String responseText) throws Exception
    {
        this.res.getWriter().print(responseText);
        this.res.getWriter().println();
    }

    public void flush(NSingleData data) throws Exception
    {
        NSingleData resultData = (NSingleData)data.get("_RESULT_DATA_");

        if (resultData == null) throw new NSysException("Flush data \"" + data.getId() + "\" is not for grid.");

        if (this.xReq.pagingInfo.downloadMode == 0) {
            this.flushToGrid(data, resultData);
        } else {
            this.flushToExcel(data, resultData);
        }
    }

    private void flushToGrid(NSingleData data, NSingleData resultData) throws Exception
    {
        StringBuffer sb = new StringBuffer();
        String key = null;

        sb.append("{").append("\n");
        sb.append("\"info\":{\"totalCount\":" + resultData.getString("totalCount"));

        for (int i = 0; i < data.getKeySize(); i++) {
            key = data.getKey(i);
            if (data.get(key) instanceof NDataProtocol) continue;
            sb.append(",\"").append(NTextUtil.toJS(key) + "\"");
            sb.append(":\"").append(NTextUtil.toJS(data.getString(key))).append("\"");
        }

        sb.append("},").append("\n");
        sb.append("\"data\":" + NAjaxUtil.getJsonDataString((NMultiData)resultData.get("resultList"), null)).append("\n");
        sb.append("}");

        this.flush(sb.toString());
    }

    private void flushToExcel(NSingleData data, NSingleData resultData) throws Exception
    {
        String downloadTitle = this.xReq.getParam("_DOWNLOAD_TITLE_");
        String rowNumDir = this.xReq.getParam("_ROW_NUM_DIR_");

        if (downloadTitle == null || downloadTitle.equals("")) {
            downloadTitle = "GridData";
        }

        NMultiData headerText = this.xReq.getMultiData("ds_headerText");
        NMultiData columnList = this.xReq.getMultiData("ds_columnList");
        NMultiData resultList = (NMultiData)resultData.get("resultList");

        WritableWorkbook workbook = null;

        try {

            workbook = Workbook.createWorkbook(this.res.getOutputStream());

            WritableSheet sheet = workbook.createSheet("Sheet1", 0);

            WritableCellFormat headerFormat = new WritableCellFormat();
            this.setCellFormatStyle(headerFormat);
            headerFormat.setFont(new WritableFont(WritableFont.ARIAL, 9, WritableFont.BOLD, false));
            headerFormat.setAlignment(Alignment.CENTRE);
            headerFormat.setBackground(Colour.GRAY_25);

            int headerRows = headerText.getRowSize();
            int headerCols = headerText.getKeySize();

            for (int r = 0; r < headerRows; r++) {
                sheet.setRowView(r, 15 * 20);
                for (int c = 0; c < headerCols; c++) {
                    sheet.addCell(new Label(c, r, headerText.getString(r, c), headerFormat));
                }
            }

            try {

                int mergeStartCol = 0;
                int mergeStartRow = 0;

                for (int r = 0; r < headerRows; r++) {
                    mergeStartCol = 0;
                    for (int c = 1; c < headerCols; c++) {
                        if (headerText.getString(r, c).equals(headerText.getString(r, mergeStartCol)) == true) continue;
                        if (mergeStartCol != c - 1) sheet.mergeCells(mergeStartCol, r, c - 1, r);
                        mergeStartCol = c;
                    }
                    if (mergeStartCol != headerCols - 1) sheet.mergeCells(mergeStartCol, r, headerCols - 1, r);
                }

                for (int c = 0; c < headerCols; c++) {
                    mergeStartRow = 0;
                    for (int r = 1; r < headerRows; r++) {
                        if (headerText.getString(mergeStartRow, c).equals(headerText.getString(r, c)) == true) continue;
                        if (mergeStartRow != r - 1) sheet.mergeCells(c, mergeStartRow, c, r - 1);
                        mergeStartRow = r;
                    }
                    if (mergeStartRow != headerRows - 1) sheet.mergeCells(c, mergeStartRow, c, headerRows - 1);
                }

            } catch (Exception e) {
            }

            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");

            for (int c = 0; c < columnList.getRowSize(); c++) {
                String columnId = columnList.getString(c, "ID");
                String columnAlign = columnList.getString(c, "ALIGN");
                String columnType = columnList.getString(c, "TYPE");
                boolean columnComma = columnList.getString(c, "COMMA").equals("1");
                int columnDigits = columnList.getInt(c, "DIGITS");
                int columnWidth = columnList.getInt(c, "WIDTH");
                boolean columnHide = columnList.getString(c, "HIDE").equals("1");
                String key = resultList.getKey(resultList.getKeyIndex(columnId));

                CellView cellView = new CellView();
                cellView.setSize(columnWidth);
                cellView.setHidden(columnHide);
                sheet.setColumnView(c, cellView);

                WritableCellFormat cellFormat;

                if (columnType.equals("number") == true) {
                    if (columnDigits == -1) {
                        cellFormat = new WritableCellFormat(new NumberFormat((columnComma ? "#,##0" : "###0")));
                    } else {
                        cellFormat = new WritableCellFormat(new NumberFormat((columnComma ? "#,##0" : "###0") + "." + NTextUtil.lpad("", columnDigits, "0")));
                    }
                } else if (columnType.equals("date") == true) {
                    cellFormat = new WritableCellFormat(new DateFormat("yyyy/MM/DD"));
                } else {
                    cellFormat = new WritableCellFormat();
                }

                this.setCellFormatStyle(cellFormat);

                if (columnAlign.equals("center")) {
                    cellFormat.setAlignment(Alignment.CENTRE);
                } else if (columnAlign.equals("right")) {
                    cellFormat.setAlignment(Alignment.RIGHT);
                } else {
                    cellFormat.setAlignment(Alignment.LEFT);
                }

                if (columnId.equals("ROW_NUM") == true && key == null) {
                    for (int r = 0; r < resultList.getRowSize(); r++) {
                        sheet.addCell(new Number(c, r + headerRows, (rowNumDir.toUpperCase().equals("ASC") ? r + 1 : resultList.getRowSize() - r), cellFormat));
                    }
                } else {
                    String value = null;
                    for (int r = 0; r < resultList.getRowSize(); r++) {
                        value = resultList.getString(r, key);
                        if (columnType.equals("number") == true) {
                            if (value == null || value.equals("")) {
                                sheet.addCell(new Label(c, r + headerRows, "", cellFormat));
                            } else {
                                try {
                                    sheet.addCell(new Number(c, r + headerRows, Double.parseDouble(value), cellFormat));
                                } catch (Exception e) {
                                    sheet.addCell(new Label(c, r + headerRows, value, cellFormat));
                                }
                            }
                        } else if (columnType.equals("date") == true) {
                            if (value == null || value.equals("")) {
                                sheet.addCell(new Label(c, r + headerRows, "", cellFormat));
                            } else {
                                try {
                                    sheet.addCell(new DateTime(c, r + headerRows, simpleDateFormat.parse(value), cellFormat));
                                } catch (Exception e) {
                                    sheet.addCell(new Label(c, r + headerRows, value, cellFormat));
                                }
                            }
                        } else {
                            sheet.addCell(new Label(c, r + headerRows, value, cellFormat));
                        }
                    }
                }
            }

        } catch (Exception e) {
            throw e;
        } finally {
            NFileDownload fileDown = new NFileDownload(this.req, this.res);
            fileDown.setHeader(downloadTitle + ".xls", -1);
            workbook.write();
            try {
                workbook.close();
            } catch (Exception e) {
            }
        }
    }

    private void setCellFormatStyle(WritableCellFormat format) throws Exception
    {
        format.setFont(new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD, false));
        format.setVerticalAlignment(VerticalAlignment.CENTRE);
        format.setBorder(Border.ALL, BorderLineStyle.THIN);
    }
}
