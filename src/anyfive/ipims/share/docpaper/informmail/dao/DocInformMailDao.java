package anyfive.ipims.share.docpaper.informmail.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DocInformMailDao extends NAbstractServletDao
{
    public DocInformMailDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 알림메일 수신자 목록 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInformMailReceiverSearchList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/informmail", "/retrieveInformMailReceiverSearchList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 진행서류 알림메일 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInformMailInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/informmail", "/retrieveInformMailInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 알림메일 수신자 정보 조회
     *
     * @param userId
     * @return
     * @throws NException
     */
    public NSingleData retrieveInformMailRecvInfo(String userId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/informmail", "/retrieveInformMailRecvInfo");
        dao.bind("USER_ID", userId);

        return dao.executeQueryForSingle();
    }
}
