package anyfive.ipims.office.common.popup.viewer.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.common.popup.viewer.dao.PopupViewerDao;

public class PopupViewerBiz extends NAbstractServletBiz
{
    public PopupViewerBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원정보조회 By REF_ID
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAbstractInfo(AjaxRequest xReq) throws NException
    {
        PopupViewerDao dao = new PopupViewerDao(this.nsr);

        return dao.retrieveAbstractInfo(xReq);
    }

    /**
     * 발명자 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInventorList(AjaxRequest xReq) throws NException
    {
        PopupViewerDao dao = new PopupViewerDao(this.nsr);

        return dao.retrieveInventorList(xReq);
    }
    /**
     * 발명자 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInventorList2(AjaxRequest xReq) throws NException
    {
        PopupViewerDao dao = new PopupViewerDao(this.nsr);

        return dao.retrieveInventorList2(xReq);
    }
}
