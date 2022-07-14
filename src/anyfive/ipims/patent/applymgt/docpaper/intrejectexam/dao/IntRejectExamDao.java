package anyfive.ipims.patent.applymgt.docpaper.intrejectexam.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class IntRejectExamDao extends NAbstractServletDao
{
    public IntRejectExamDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내거절검토서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntRejectExam(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/intrejectexam", "/retrieveIntRejectExam");
        dao.bind(xReq);

        if (xReq.getParam("OA_SEQ").equals("") != true) {
            dao.addQuery("oaSeq", "1");
        } else if (xReq.getParam("LIST_SEQ").equals("") == true) {
            dao.addQuery("maxOaSeq", "1");
        } else {
            dao.addQuery("listSeq", "1");
        }

        return dao.executeQueryForSingle();
    }

    /**
     * 국내거절검토서 경과목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveIntRejectExamPassList(String refId, String oaSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/intrejectexam", "/retrieveIntRejectExamPassList");
        dao.bind("REF_ID", refId);
        dao.bind("OA_SEQ", oaSeq);

        return dao.executeQuery();
    }

    /**
     * 국내거절검토서 관련해외REF-NO 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveIntRejectExamExtRefList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/intrejectexam", "/retrieveIntRejectExamExtRefList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }

    /**
     * 국내거절검토서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createIntRejectExam(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/intrejectexam", "/createIntRejectExam");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 국내거절검토서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateIntRejectExam(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/intrejectexam", "/updateIntRejectExam");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
