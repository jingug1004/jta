package anyfive.ipims.patent.costmgt.sale.consult.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class SaleMgtConsultDao extends NAbstractServletDao
{
    public SaleMgtConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 매각확정 품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createSaleMgtConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/sale/consult", "/createSaleMgtConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용마스터 품의ID 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateCostMstConsultId(AjaxRequest xReq, NMultiData updateList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/sale/consult", "/updateCostMstConsultId");
        dao.bind(xReq);

        return dao.executeBatch(updateList);
    }

    /**
     * 매각 확정 품의 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSaleMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/sale/consult", "/retrieveSaleMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 매각 확정 품의 상세 비용목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSaleMgtCostList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/sale/consult", "/retrieveSaleMgtCostList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 매각 확정 품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateSaleMgtConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/sale/consult", "/updateSaleMgtConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 매각 확정 품의 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteSaleMgtConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/sale/consult", "/deleteSaleMgtConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용마스터 품의ID 제거
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostMstConsultIdToNull(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/sale/consult", "/updateCostMstConsultIdToNull");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 매각 품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSaleMgtConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/sale/consult", "/retrieveSaleMgtConsultList");
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
}
