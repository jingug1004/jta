package anyfive.ipims.patent.systemmgt.papermgt.paperwf.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PaperWFMgtDao extends NAbstractServletDao
{
    public PaperWFMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 워크플로우관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperWFList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/retrievePaperWFList");
        dao.bind(xReq);

        // W/F 종류
        if (xReq.getParam("WF_KIND").equals("") != true) {
            dao.addQuery("wfKind");
        }

        // 검색어
        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 진행서류 워크플로우관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperWF(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/retrievePaperWF");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 진행서류 워크플로우관리 코드 조회
     *
     * @return
     * @throws NException
     */
    public String retrievePaperWFCode() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/retrievePaperWFCode");

        return dao.executeQueryForString();
    }

    /**
     * 진행서류 워크플로우관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPaperWF(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/createPaperWF");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 워크플로우관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePaperWF(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/updatePaperWF");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 워크플로우관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deletePaperWF(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/deletePaperWF");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperWFPaperList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/retrievePaperWFPaperList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperWFPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/retrievePaperWFPaper");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPaperWFPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/createPaperWFPaper");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePaperWFPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/updatePaperWFPaper");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 워크플로우관리별 진행서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deletePaperWFPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/paperwf", "/deletePaperWFPaper");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
