package anyfive.ipims.office.home.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.home.dao.HomeDao;

public class HomeBiz extends NAbstractServletBiz
{
    public HomeBiz(NServiceResource nsr)
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
        HomeDao dao = new HomeDao(this.nsr);

        return dao.retrieveHomeBoardList(xReq);
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
        HomeDao dao = new HomeDao(this.nsr);

        return dao.retrieveHomeRecentList(xReq);
    }
}
