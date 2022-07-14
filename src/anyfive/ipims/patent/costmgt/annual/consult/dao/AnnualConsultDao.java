package anyfive.ipims.patent.costmgt.annual.consult.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AnnualConsultDao extends NAbstractServletDao
{
    public AnnualConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차료 품의서 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/consult", "/retrieveAnnualConsultList");
        dao.bind(xReq);

        // 제목
        if (xReq.getParam("CONSULT_SUBJECT").equals("") != true) {
            dao.addQuery("consultSubject");
        }
        // 상태
        if (xReq.getParam("CONSULT_STATUS").equals("") != true) {
            if (xReq.getParam("CONSULT_STATUS").equals("0") == true) {
                dao.addQuery("consultStatusDefault");
            } else {
                dao.addQuery("consultStatus");
            }
        }
        // 작성자
        if (xReq.getParam("CRE_USER_NAME").equals("") != true) {
            dao.addQuery("creUserName");
        }
        // 작성일
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        // 작성일
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연차료 품의서 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/consult", "/retrieveAnnualConsult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 연차료 품의서 비용 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualConsultInputList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/consult", "/retrieveAnnualConsultInputList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연차료 품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createAnnualConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/consult", "/createAnnualConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용마스터 수정(품의서ID 설정)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateCostMasterToConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/consult", "/updateCostMasterToConsult");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_annualPaymentList"));
    }

    /**
     * 연차료 품의서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAnnualConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/consult", "/updateAnnualConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 연차료 품의서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteAnnualConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/consult", "/deleteAnnualConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용마스터 수정(품의서ID 삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAnnualMasterConsultId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/consult", "/updateAnnualMasterConsultId");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
