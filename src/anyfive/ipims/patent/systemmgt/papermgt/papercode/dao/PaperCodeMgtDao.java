package anyfive.ipims.patent.systemmgt.papermgt.papercode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PaperCodeMgtDao extends NAbstractServletDao
{
    public PaperCodeMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/retrievePaperCodeList");
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

        if (xReq.getParam("OA_MGT_STEP").equals("") != true) {
            dao.addQuery("oaMgtStep");
        }

        if (xReq.getParam("PAPER_STEP").equals("") != true) {
            dao.addQuery("paperStep");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 진행서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/retrievePaperCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 진행서류 코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveNewPaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/retrieveNewPaperCode");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 진행서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/createPaperCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/updatePaperCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deletePaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/deletePaperCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 세부서류 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteSubPaperCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/deleteSubPaperCodeList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 세부서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSubPaperCodeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/retrieveSubPaperCodeList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 세부서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSubPaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/retrieveSubPaperCode");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 세부서류 코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrievePaperSubcode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/retrievePaperSubcode");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 세부서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createSubPaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/createSubPaperCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 세부서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateSubPaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/updateSubPaperCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 세부서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteSubPaperCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/papermgt/papercode", "/deleteSubPaperCode");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
