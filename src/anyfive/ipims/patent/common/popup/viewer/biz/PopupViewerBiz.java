package anyfive.ipims.patent.common.popup.viewer.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.popup.viewer.dao.PopupViewerDao;

public class PopupViewerBiz extends NAbstractServletBiz
{
    public PopupViewerBiz(NServiceResource nsr)
    {
        super(nsr);
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
     * 국내건의 해외출원 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtApplyByIntList(AjaxRequest xReq) throws NException
    {
        PopupViewerDao dao = new PopupViewerDao(this.nsr);

        return dao.retrieveExtApplyByIntList(xReq);
    }

    /**
     * 국외건의 해외출원 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtApplyByExtList(AjaxRequest xReq) throws NException
    {
        PopupViewerDao dao = new PopupViewerDao(this.nsr);

        return dao.retrieveExtApplyByExtList(xReq);
    }

    /**
     * 관련파일 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRefFileList(AjaxRequest xReq) throws NException
    {
        PopupViewerDao dao = new PopupViewerDao(this.nsr);

        return dao.retrieveRefFileList(xReq);
    }

    /**
     * 등급 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLevelList(AjaxRequest xReq) throws NException
    {
        PopupViewerDao dao = new PopupViewerDao(this.nsr);

        return dao.retrieveLevelList(xReq);
    }
}
