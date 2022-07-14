package anyfive.framework.ajax;

import javax.servlet.http.HttpServletResponse;

import any.util.ajax.NAbstractAjaxResponse;

public class AjaxResponse extends NAbstractAjaxResponse
{
    public AjaxResponse(HttpServletResponse res)
    {
        super(res);
    }
}
