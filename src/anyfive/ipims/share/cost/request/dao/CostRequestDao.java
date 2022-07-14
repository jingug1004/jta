package anyfive.ipims.share.cost.request.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CostRequestDao extends NAbstractServletDao
{
    public CostRequestDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 청구서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/retrieveCostRequest");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내비용 상세목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntCostDetailList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/retrieveIntCostDetailList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국내비용청구서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createIntCostRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/createIntCostRequest");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 국내비용입력 수정(청구서ID 설정)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateIntCostListReqId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateIntCostListReqId");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_intCostList"));
    }

    /**
     * 비용청구 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateCostRequest");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용청구 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCostRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/deleteCostRequest");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용마스터 수정 (REQ_ID 삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostMasterReqId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateCostMasterReqId");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외비용 INVOICE 상세목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtInvoiceDetailList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/retrieveExtInvoiceDetailList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 해외INVOICE 수정 (REQ_ID 삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtInvoiceReqId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateExtInvoiceReqId");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외비용청구서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExtCostRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/createExtCostRequest");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외비용 INVOICE 수정(청구서ID 설정)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateExtInvoiceListReqId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateExtInvoiceListReqId");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_extInvoiceList"));
    }

    /**
     * 해외비용입력 수정(청구서ID 설정)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateExtCostListReqId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateExtCostListReqId");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_extInvoiceList"));
    }

    /**
     * 청구서 청구
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostRequestConfirm(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateCostRequestConfirm");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 국내비용 일괄확인
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateIntCostConfirmYn(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateIntCostConfirmYn");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_intCostList"));
    }

    /**
     * 청구서 반려
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateReCostRequestConfirm(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateReCostRequestConfirm");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 청구서 반려(ETC)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateReCostRequestConfirmEtc(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/updateReCostRequestConfirmEtc");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 청구서반려 알림메일 사무소 수신정보 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveInformMailOfficeRecvInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/request", "/retrieveInformMailOfficeRecvInfo");
        dao.bind(xReq);

        return dao.executeQuery();
    }

}
