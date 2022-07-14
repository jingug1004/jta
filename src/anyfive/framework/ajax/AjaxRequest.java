package anyfive.framework.ajax;

import javax.servlet.http.HttpServletRequest;

import any.core.exception.NException;
import any.util.ajax.NAbstractAjaxRequest;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.share.common.util.SystemTypes;

public class AjaxRequest extends NAbstractAjaxRequest
{
    public AjaxRequest(HttpServletRequest req) throws NException
    {
        super(req);
    }

    protected void appendSystemData()
    {
        if (SessionUtil.getUserInfo(this.req).isLogin() == true) {
            this.systemData.setString("$SYSTEM_TYPE", SessionUtil.getUserInfo(this.req).getSystemType());
            this.systemData.setString("$OFFICE_CODE", SessionUtil.getUserInfo(this.req).getOfficeCode());
        } else {
            this.systemData.setString("$SYSTEM_TYPE", SystemTypes.getSystemType(this.req));
        }
    }
}
