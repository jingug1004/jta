package anyfive.framework.codedata.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.exception.NSysException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.codedata.NCodeData;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.codedata.dao.CodeDataDao;

public class CodeDataBiz extends NAbstractServletBiz
{
    public CodeDataBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    public NMultiData retrieveXmlCodeData(AjaxRequest xReq, String path) throws NException
    {
        try {
            return NCodeData.getCodeDataXmlRows(path);
        } catch(NSysException e) {
            return null;
        }
    }

    public NMultiData retrieveQryCodeData(AjaxRequest xReq, String path) throws NException
    {
        CodeDataDao dao = new CodeDataDao(this.nsr);

        return dao.retrieveQryCodeData(xReq, path);
    }

    public NMultiData retrieveGrpCodeData(AjaxRequest xReq, String groupName) throws NException
    {
        try {
            return NCodeData.getCodeDataGrpRows(groupName);
        } catch(NSysException e) {
            return null;
        }
    }
}
