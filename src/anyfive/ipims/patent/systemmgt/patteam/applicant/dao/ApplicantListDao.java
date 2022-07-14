package anyfive.ipims.patent.systemmgt.patteam.applicant.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ApplicantListDao extends NAbstractServletDao
{
    public ApplicantListDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원인 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApplicantList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);
        dao.setQuery("/ipims/patent/systemmgt/patteam/applicant", "/retrieveApplicantList");
        dao.bind(xReq);

        if (xReq.getParam("APP_MAN_NAME").equals("") != true) {
            dao.addQuery("APP_MAN_NAME");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 출원인 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApplicant(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/applicant", "/retrieveApplicant");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 출원인 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createApplicant(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/applicant", "/createApplicant");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 출원인 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateApplicant(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/applicant", "/updateApplicant");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 출원인 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteApplicant(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/applicant", "/deleteApplicant");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
