package anyfive.ipims.patent.costmgt.cost.consult.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CostConsultDao extends NAbstractServletDao
{
    public CostConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원비용 품의서 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/retrieveCostConsultList");
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
        if (xReq.getParam("CRE_USER").equals("") != true) {
            dao.addQuery("creUser");
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
     * 출원비용 품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCostConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/createCostConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용청구서 수정(품의서ID 설정)
     *
     * @param reqId
     * @param consultId
     * @return
     * @throws NException
     */
    public int updateCostRequestToConsult(String reqId, String consultId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/updateCostRequestToConsult");
        dao.bind("CONSULT_ID", consultId);
        dao.bind("REQ_ID", reqId);

        return dao.executeUpdate();
    }

    /**
     * 비용마스터 수정(품의서ID 설정)
     *
     * @param reqId
     * @param consultId
     * @return
     * @throws NException
     */
    public int updateCostMasterToConsult(String reqId, String consultId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/updateCostMasterToConsult");
        dao.bind("CONSULT_ID", consultId);
        dao.bind("REQ_ID", reqId);

        return dao.executeUpdate();
    }

    /**
     * 출원비용 품의서 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/retrieveCostConsult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 출원비용 품의서 비용 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostConsultInputList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/retrieveCostConsultInputList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 출원비용 품의서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/updateCostConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 출원비용 품의서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCostConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/deleteCostConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용청구서 수정(품의서ID 삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostRequestConsultId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/updateCostRequestConsultId");
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
    public int updateCostMasterConsultId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/cost/consult", "/updateCostMasterConsultId");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
