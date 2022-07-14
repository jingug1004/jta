package anyfive.framework.app;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import any.core.config.NConfig;
import any.core.message.NMessage;
import any.core.service.servlet.util.NServletValidChecker;
import anyfive.framework.session.SessionUtil;
import anyfive.framework.session.UserInfo;

public abstract class AbstractApp
{
    protected HttpServletRequest  req                    = null;
    protected HttpServletResponse res                    = null;
    protected JspWriter           out                    = null;

    public final short            PAGE_TYPE_COMMON       = 0;
    public final short            PAGE_TYPE_DEFAULT      = 1;
    public final short            PAGE_TYPE_POPUP        = 2;

    public final String           HTC_GRID               = "/anyfive/framework/grid/GridHTC.jsp";
    public final String           HTC_TREE               = "/anyfive/framework/tree/TreeHTC.jsp";
    public final String           HTC_CHART              = "/anyfive/framework/chart/ChartHTC.jsp";

    public boolean                debugMode;
    public String                 langCode;
    public NMessage               message;

    public final UserInfo         userInfo;

    private boolean               flexGridConstantWrited = false;

    public AbstractApp(HttpServletRequest req, HttpServletResponse res, JspWriter out) throws Exception
    {
        this(req, res, out, false, false);
    }

    public AbstractApp(HttpServletRequest req, HttpServletResponse res, JspWriter out, boolean isAccessCheckSkip, boolean isSessionCheckSkip) throws Exception
    {
        this.req = req;
        this.res = res;
        this.out = out;

        this.res.setDateHeader("Expires", 0);
        this.res.setHeader("Pragma", "no-cache");
        this.res.setHeader("Cache-Control", "no-cache");

        this.out.clear();

        this.userInfo = SessionUtil.getUserInfo(this.req);
        this.debugMode = SessionUtil.isDebugMode(this.req);
        this.langCode = SessionUtil.getLangCode(this.req);
        this.message = new NMessage(this.langCode);

        if (this.checkValidAccess(isAccessCheckSkip) == true) {
            this.checkValidSession(isSessionCheckSkip);
        }
    }

    public boolean checkValidAccess(boolean isAccessCheckSkip) throws Exception
    {
        if (isAccessCheckSkip == true) return true;
        if (NServletValidChecker.isValidAccess(this.req, this.res) == true) return true;

        this.req.getRequestDispatcher(NConfig.getString(NConfig.DEFAULT_CONFIG + "/error-page/access")).forward(this.req, this.res);

        return false;
    }

    public boolean checkValidSession(boolean isSessionCheckSkip) throws Exception
    {
        if (isSessionCheckSkip == true) return true;
        if (NServletValidChecker.isValidSession(this.req, this.res) == true) return true;

        this.req.getRequestDispatcher(NConfig.getString(NConfig.DEFAULT_CONFIG + "/error-page/session")).forward(this.req, this.res);

        return false;
    }

    public void writeHTMLDocType() throws Exception
    {
        this.out.clear();
        this.out.print("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
    }

    public void writeMetaTags() throws Exception
    {
        this.out.println("<META http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
        this.out.println("<META http-equiv=\"Cache-Control\" content=\"no-cache; no-store; no-save\">");
        this.out.println("<META http-equiv=\"Expires\" content=\"0\">");
        this.out.print("<META http-equiv=\"Pragma\" content=\"no-cache\">");
    }

    public void writeHTMLHeader() throws Exception
    {
        this.writeHTMLHeader(this.PAGE_TYPE_COMMON);
    }

    public void writeHTMLHeader(short pageType) throws Exception
    {
        this.writeMetaTags();
        this.out.println();

        this.out.println("<LINK rel=\"StyleSheet\" type=\"text/css\" href=\"" + this.req.getContextPath() + "/anyfive/framework/css/style.css\">");
        this.out.println("<LINK rel=\"StyleSheet\" type=\"text/css\" href=\"" + this.req.getContextPath() + "/anyfive/framework/htc/anyworks.jsp\">");
        this.out.println("<SCRIPT language=\"JScript\" src=\"" + this.req.getContextPath() + "/anyfive/framework/js/anyworks.js\"></SCRIPT>");
        this.out.println("<SCRIPT language=\"JScript\" src=\"" + this.req.getContextPath() + "/anyfive/framework/js/behavior.js\"></SCRIPT>");
        this.out.println("<SCRIPT language=\"JScript\" src=\"" + this.req.getContextPath() + "/anyfive/framework/js/common.js\"></SCRIPT>");

        this.writePageInitialize(pageType);
        this.writeHTCImport("/anyfive/framework/file/FileHTC.jsp");
        this.out.println();

        this.appendHTMLHeader();

        this.out.print("<SPAN id=\"__OFFSET_SIZE_CALC_SPAN__\" style=\"position:absolute; left:0px; top:0px; visibility:hidden;\"></SPAN>");
    }

    public void writePageInitialize(short pageType) throws Exception
    {
        this.out.println("<SCRIPT language=\"JScript\" src=\"" + this.req.getContextPath() + "/anyfive/framework/js/initialize.jsp?type=" + pageType + "\"></SCRIPT>");
    }

    protected abstract void appendHTMLHeader() throws Exception;

    public void writeHTCImport(String htcPath) throws Exception
    {
        if (this.flexGridConstantWrited != true && (HTC_GRID.equals(htcPath) || HTC_TREE.equals(htcPath))) {
            this.out.println("<SCRIPT language=\"VBScript\" src=\"" + this.req.getContextPath() + "/anyfive/framework/grid/flexgrid/FlexGridConstant.vbs\"></SCRIPT>");
            this.flexGridConstantWrited = true;
        }
        this.out.print("<?IMPORT namespace=\"ANY\" implementation=\"" + this.req.getContextPath() + htcPath + "\">");
    }

    public void writeBodyMessage() throws Exception
    {
        this.out.print("<SCRIPT language=\"JScript\">bfShowBodyMessage();</SCRIPT>");
    }

    public void writeBodyHeader() throws Exception
    {
        this.writeBodyMessage();
        this.out.println();

        this.out.println("<DIV id=\"__BODY_MAIN_DIV__\" style=\"width:100%; height:100%; padding:10px; overflow:auto;\">");
        this.out.println("<TABLE border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" height=\"100%\">");
        this.out.println("    <TR id=\"__PAGE_TITLE_TR__\" style=\"display:none;\">");
        this.out.println("        <TD style=\"padding-bottom:10px;\">");
        this.out.println("            <IMG src=\"" + this.req.getContextPath() + "/anyfive/framework/img/title.gif\" align=\"absmiddle\">");
        this.out.println("            <SPAN id=\"__PAGE_TITLE_SPAN__\" class=\"title_main\"></SPAN>");
        this.out.println("            <SCRIPT language=\"JScript\">cfSetPageTitle(document.title);</SCRIPT>");
        this.out.println("        </TD>");
        this.out.println("    </TR>");
        this.out.println("    <TR>");
        this.out.print("        <TD valign=\"top\" height=\"100%\" id=\"__BODY_CONTENT_TD__\">");
    }

    public void writeBodyFooter() throws Exception
    {
        this.writeBodyFooter(false);
    }

    public void writeBodyFooter(boolean closeButton) throws Exception
    {
        this.out.println("        </TD>");
        this.out.println("    </TR>");

        if (closeButton == true) {
            this.out.println("    <TR id=\"__SHOW_HIDE_OBJECT__\" pageType=\"popup\">");
            this.out.println("        <TD align=\"right\" style=\"padding-top:5px;\">");
            this.out.println("            <BUTTON auto=\"close\"></BUTTON>");
            this.out.println("        </TD>");
            this.out.println("    </TR>");
        }

        this.out.println("</TABLE>");
        this.out.println("</DIV>");
        this.out.print("<SCRIPT language=\"JScript\">document.onready();</SCRIPT>");
    }

    public String getEncodingParameter(String key)
    {
        String result = null;

        try {
            String param = this.req.getParameter(key);
            if (param != null) {
                result = new String(param.getBytes("8859_1"), "utf-8");
            }
        } catch (UnsupportedEncodingException e) {
        }

        return result;
    }
}
