package anyfive.ipims.patent.common.popup.search.dao;

import any.core.dataset.NDataProtocol;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.popup.search.util.PopupSearchUtil;

public class PopupSearchDao extends NAbstractServletDao
{
    public PopupSearchDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 특허팀 사용자 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrievePatentUserSearchList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrievePatentUserSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }
        if (xReq.getParam("USER_ID").equals("") != true){
            dao.addQuery("userId");
        }

        return PopupSearchUtil.getResult(xReq, dao);
    }

    /**
     * 사무소 사용자 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NDataProtocol retrieveOfficeUserSearchList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveOfficeUserSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }
        if (xReq.getParam("USER_ID").equals("") != true){
            dao.addQuery("userId");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveInventorSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        if (xReq.getParam("OUT_SEARCH").equals("1")) {
            dao.addQuery("out");
            if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
                dao.addQuery("out/searchText");
            }
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveRefNoSearchList");
        dao.bind(xReq);

        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
            dao.bind("RIGHT_DIV", xReq.getParam("RIGHT_DIV").split(","));
        }

        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        if (xReq.getParam("ABD_YN").equals("") != true) {
            dao.addQuery("abdYn");
        }

        if (xReq.getParam("APP_NO_NOT_NULL").equals("1") == true) {
            dao.addQuery("appNoNotNull");
        }

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_LIKE").equals("1") == true) {
                dao.addQuery("searchTextLike");
            } else {
                dao.addQuery("searchText");
            }
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveDeptCodeSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveCountrySearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        if (xReq.getParam("OL_GRP_ID").equals("") != true) {
            dao.addQuery("olGrpId");
        }

        dao.addQuery("orderBy");

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveProjectSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrievePrschSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        if (xReq.getParam("PRSCH_DIV").equals("") != true) {
            dao.addQuery("prschDiv");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveDisputeSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveIpBizAnalySearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveTechCodeSearchTree");
        dao.bind(xReq);

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveIpcCodeSearchTree");
        dao.bind(xReq);

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveProdCodeSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrievePaperSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        if (xReq.getParam("PAPER_DIV").equals("") != true) {
            dao.addQuery("paperDiv");
        }

        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrievePaperSearchByRefList");
        dao.bind(xReq);

        if (xReq.getParam("PAPER_STEP").equals("") != true) {
            dao.addQuery("paperStep");
        }

        if (xReq.getParam("PAPER_INPUT_AVAIL").equals("") != true) {
            dao.addQuery("paperInputAvail");
        }

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveMenuCodeSearchTree");
        dao.bind(xReq);

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveOurInfoSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveKiprisSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveApplicantSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return PopupSearchUtil.getResult(xReq, dao);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/popup/search", "/retrieveRvtgSearchList");
        dao.bind(xReq);

        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
            dao.bind("RIGHT_DIV", xReq.getParam("RIGHT_DIV").split(","));
        }

        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        if (xReq.getParam("ABD_YN").equals("") != true) {
            dao.addQuery("abdYn");
        }

        if (xReq.getParam("APP_NO_NOT_NULL").equals("1") == true) {
            dao.addQuery("appNoNotNull");
        }

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_LIKE").equals("1") == true) {
                dao.addQuery("searchTextLike");
            } else {
                dao.addQuery("searchText");
            }
        }

        return PopupSearchUtil.getResult(xReq, dao);
    }



}
