package anyfive.ipims.share.menu.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class MenuDao extends NAbstractServletDao
{
    public MenuDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/menu/menu", "/retrieveMenuList_" + SessionUtil.getUserInfo(this.nsr).getSystemType());
        dao.bind(xReq);

        return dao.executeQuery();
    }
}
