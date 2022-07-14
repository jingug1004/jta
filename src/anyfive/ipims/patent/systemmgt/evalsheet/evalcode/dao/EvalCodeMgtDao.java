package anyfive.ipims.patent.systemmgt.evalsheet.evalcode.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class EvalCodeMgtDao extends NAbstractServletDao
{
    public EvalCodeMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가코드 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalCodeMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalcode", "/retrieveEvalCodeMgtList");
        dao.bind(xReq);

        if (xReq.getParam("EVAL_TITLE").equals("") != true) {
            dao.addQuery("evalTitle");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 평가코드 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalcode", "/retrieveEvalCodeMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 평가코드 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createEvalCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalcode", "/createEvalCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가코드 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateEvalCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalcode", "/updateEvalCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가코드 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteEvalCodeMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalcode", "/deleteEvalCodeMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
