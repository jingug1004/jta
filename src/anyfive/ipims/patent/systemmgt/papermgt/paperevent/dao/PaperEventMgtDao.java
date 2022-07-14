package anyfive.ipims.patent.systemmgt.papermgt.paperevent.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PaperEventMgtDao extends NAbstractServletDao
{
    public PaperEventMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 이벤트 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperEventList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/retrievePaperEventList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 진행서류 이벤트 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperEvent(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/retrievePaperEvent");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 진행서류 이벤트ID 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrievePaperEventSeq() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/retrievePaperEventSeq");

        return dao.executeQueryForString();
    }

    /**
     * 진행서류 이벤트 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPaperEvent(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/createPaperEvent");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 이벤트 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePaperEvent(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/updatePaperEvent");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 이벤트 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deletePaperEvent(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/deletePaperEvent");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 이벤트별 진행서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperEventPaperList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/retrievePaperEventPaperList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 진행서류 이벤트별 진행서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperEventPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/retrievePaperEventPaper");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 진행서류 이벤트별 진행서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPaperEventPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/createPaperEventPaper");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 이벤트별 진행서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePaperEventPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/updatePaperEventPaper");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 이벤트별 진행서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deletePaperEventPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperevent", "/deletePaperEventPaper");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
