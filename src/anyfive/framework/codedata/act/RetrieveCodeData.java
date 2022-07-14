package anyfive.framework.codedata.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.exception.NSysException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.codedata.NCodeData;
import any.util.etc.NTextUtil;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.framework.codedata.biz.CodeDataBiz;

public class RetrieveCodeData implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        NMultiData reqCodeList = xReq.getParamToMultiData();

        String id = null;
        String path = null;
        NMultiData result = null;

        AjaxResponse xRes = new AjaxResponse(res);

        CodeDataBiz biz = new CodeDataBiz(nsr);
        for (int i = 0; i < reqCodeList.getRowSize(); i++) {
            id = reqCodeList.getString(i, "ID");
            path = reqCodeList.getString(i, "PATH");
            result = null;
            try {
                switch (NCodeData.getCodeDataType(path)) {
                case NCodeData.TYPE_XML:
                    result = biz.retrieveXmlCodeData(xReq, path);
                    break;
                case NCodeData.TYPE_QUERY:
                    nsr.openConnection();
                    result = biz.retrieveQryCodeData(xReq, path);
                    break;
                case NCodeData.TYPE_GROUP:
                    result = biz.retrieveGrpCodeData(xReq, path);
                    break;
                }
                if (result == null) throw new NSysException("CodeData [" + path + "] is not Available!");
                xRes.flush(result, id);
            } catch (NException e) {
                xRes.flush("{id:\"" + id + "\",error:\"" + (nsr.debugMode ? NTextUtil.toJS(e.getMessage()) : "") + "\"}");
            }
        }
    }
}
