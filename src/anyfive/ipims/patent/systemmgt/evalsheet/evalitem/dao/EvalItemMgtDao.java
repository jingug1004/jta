package anyfive.ipims.patent.systemmgt.evalsheet.evalitem.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class EvalItemMgtDao extends NAbstractServletDao
{
    public EvalItemMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가항목 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalItemMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalitem", "/retrieveEvalItemMgtList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 평가항목 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalItemMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalitem", "/retrieveEvalItemMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 평가항목 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createEvalItemMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalitem", "/createEvalItemMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가항목 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateEvalItemMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalitem", "/updateEvalItemMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가항목 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteEvalItemMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalitem", "/deleteEvalItemMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가항목 표시순서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateEvalItemMgtDispOrdList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalitem", "/updateEvalItemMgtDispOrdList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_evalItemList"));
    }
}
