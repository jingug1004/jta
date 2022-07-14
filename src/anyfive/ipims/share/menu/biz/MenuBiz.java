package anyfive.ipims.share.menu.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.menu.dao.MenuDao;

public class MenuBiz extends NAbstractServletBiz
{
    public MenuBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메뉴 목록 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveMenuList(AjaxRequest xReq) throws NException
    {
        MenuDao dao = new MenuDao(this.nsr);

        return dao.retrieveMenuList(xReq);
    }
}
