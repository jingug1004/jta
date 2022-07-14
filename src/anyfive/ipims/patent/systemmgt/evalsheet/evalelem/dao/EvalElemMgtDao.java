package anyfive.ipims.patent.systemmgt.evalsheet.evalelem.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class EvalElemMgtDao extends NAbstractServletDao
{
    public EvalElemMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가요소 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalElemMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalelem", "/retrieveEvalElemMgtList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 평가요소 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalElemMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalelem", "/retrieveEvalElemMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 평가요소 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createEvalElemMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalelem", "/createEvalElemMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가요소 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateEvalElemMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalelem", "/updateEvalElemMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가요소 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteEvalElemMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalelem", "/deleteEvalElemMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가요소 표시순서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateEvalElemMgtDispOrdList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalelem", "/updateEvalElemMgtDispOrdList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_evalElemList"));
    }
}
