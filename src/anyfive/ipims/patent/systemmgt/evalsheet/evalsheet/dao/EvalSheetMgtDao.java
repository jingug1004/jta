package anyfive.ipims.patent.systemmgt.evalsheet.evalsheet.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class EvalSheetMgtDao extends NAbstractServletDao
{
    public EvalSheetMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가서 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalSheetMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalsheet", "/retrieveEvalSheetMgtList");
        dao.bind(xReq);

        if (xReq.getParam("EVAL_SHEET_NAME").equals("") != true) {
            dao.addQuery("evalSheetName");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 평가서 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalSheetMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalsheet", "/retrieveEvalSheetMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 평가서 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createEvalSheetMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalsheet", "/createEvalSheetMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가서 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateEvalSheetMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalsheet", "/updateEvalSheetMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가서 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteEvalSheetMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/evalsheet/evalsheet", "/deleteEvalSheetMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
