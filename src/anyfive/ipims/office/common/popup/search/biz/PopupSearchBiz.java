package anyfive.ipims.office.common.popup.search.biz;

import any.core.dataset.NDataProtocol;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.common.popup.search.dao.PopupSearchDao;

public class PopupSearchBiz extends NAbstractServletBiz
{
    public PopupSearchBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * REF-NO 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveRefNoSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveRefNoSearchList(xReq);
    }

    /**
     * 선행기술조사 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrievePrschSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrievePrschSearchList(xReq);
    }

    /**
     * 분쟁/소송 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveDisputeSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveDisputeSearchList(xReq);
    }

    /**
     * REF별 진행서류 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrievePaperSearchByRefList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrievePaperSearchByRefList(xReq);
    }

    /**
     * IPC분류코드 트리 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveIpcCodeSearchTree(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveIpcCodeSearchTree(xReq);
    }
}
