package anyfive.ipims.office.common.popup.search.dao;

import any.core.dataset.NDataProtocol;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.common.popup.search.util.PopupSearchUtil;

public class PopupSearchDao extends NAbstractServletDao
{
    public PopupSearchDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/popup/search", "/retrieveRefNoSearchList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_LIKE").equals("1") == true) {
                dao.addQuery("searchTextLike");
            } else {
                dao.addQuery("searchText");
            }
        }

        // 국가
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
            if(xReq.getParam("EX_ASSETYN_CONFIRM").equals("") != true) {
                dao.addQuery("exAssetYNConfirm");

            }
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

        dao.setQuery("/ipims/office/common/popup/search", "/retrievePrschSearchList");
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

        dao.setQuery("/ipims/office/common/popup/search", "/retrieveDisputeSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
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

        dao.setQuery("/ipims/office/common/popup/search", "/retrievePaperSearchByRefList");
        dao.bind(xReq);

        if (xReq.getParam("PAPER_STEP").equals("") != true) {
            dao.addQuery("paperStep");
        }

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

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

        dao.setQuery("/ipims/office/common/popup/search", "/retrieveIpcCodeSearchTree");
        dao.bind(xReq);

        return PopupSearchUtil.getResult(xReq, dao);
    }
}
