package anyfive.ipims.patent.applymgt.docpaper.extrejectexam.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtRejectExamDao extends NAbstractServletDao
{
    public ExtRejectExamDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외거절검토서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtRejectExam(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/extrejectexam", "/retrieveExtRejectExam");
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
     * 해외거절검토서 경과목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveExtRejectExamPassList(String refId, String oaSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/extrejectexam", "/retrieveExtRejectExamPassList");
        dao.bind("REF_ID", refId);
        dao.bind("OA_SEQ", oaSeq);

        return dao.executeQuery();
    }

    /**
     * 해외거절검토서 관련국내REF-NO 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveExtRejectExamIntRefList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/extrejectexam", "/retrieveExtRejectExamIntRefList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }

    /**
     * 해외거절검토서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExtRejectExam(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/extrejectexam", "/createExtRejectExam");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외거절검토서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtRejectExam(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/extrejectexam", "/updateExtRejectExam");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
