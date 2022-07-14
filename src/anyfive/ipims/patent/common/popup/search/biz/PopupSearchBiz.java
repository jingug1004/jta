package anyfive.ipims.patent.common.popup.search.biz;

import any.core.dataset.NDataProtocol;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.popup.search.dao.PopupSearchDao;

public class PopupSearchBiz extends NAbstractServletBiz
{
    public PopupSearchBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사용자 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveUserSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        if (xReq.getParam("SYSTEM_TYPE").equals("OFFICE")) {
            return dao.retrieveOfficeUserSearchList(xReq);
        }

        return dao.retrievePatentUserSearchList(xReq);
    }

    /**
     * 발명자 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveInventorSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveInventorSearchList(xReq);
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
     * 부서 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveDeptCodeSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveDeptCodeSearchList(xReq);
    }

    /**
     * 국가 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveCountrySearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveCountrySearchList(xReq);
    }

    /**
     * 프로젝트 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveProjectSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveProjectSearchList(xReq);
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
     * IP Biz. 분석자료 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveIpBizAnalySearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveIpBizAnalySearchList(xReq);
    }

    /**
     * 기술분류코드 트리 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveTechCodeSearchTree(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveTechCodeSearchTree(xReq);
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

    /**
     * 제품코드 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveProdCodeSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveProdCodeSearchList(xReq);
    }

    /**
     * 진행서류 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrievePaperSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrievePaperSearchList(xReq);
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
     * 메뉴코드 트리 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveMenuCodeSearchTree(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveMenuCodeSearchTree(xReq);
    }

    /**
     * IP Biz. 당사정보 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveOurInfoSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveOurInfoSearchList(xReq);
    }

    /**
     * IP Biz. kipris 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveKiprisSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveKiprisSearchList(xReq);
    }

    /**
     * 출원인 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveApplicantSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveApplicantSearchList(xReq);
    }

    /**
     * 심의대상 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveRvtgSearchList(AjaxRequest xReq) throws NException
    {
        PopupSearchDao dao = new PopupSearchDao(this.nsr);

        return dao.retrieveRvtgSearchList(xReq);
    }


}
