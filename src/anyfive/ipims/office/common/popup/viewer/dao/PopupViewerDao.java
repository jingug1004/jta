package anyfive.ipims.office.common.popup.viewer.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PopupViewerDao extends NAbstractServletDao
{
    public PopupViewerDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     *  출원정보조회 By REF_ID
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAbstractInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/popup/viewer", "/retrieveAbstractInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/popup/viewer", "/retrieveInventorList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/popup/viewer", "/retrieveInventorList2");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

}
