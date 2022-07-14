package anyfive.ipims.office.home.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class HomeDao extends NAbstractServletDao
{
    public HomeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 게시판 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveHomeBoardList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/home/home", "/retrieveHomeBoardList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 신규 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveHomeRecentList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/home/home", "/retrieveHomeRecentList_" + xReq.getParam("RECENT_ID"));
        dao.bind(xReq);

        return dao.executeQuery();
    }
}
