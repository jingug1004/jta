package anyfive.ipims.patent.costmgt.cost.consult.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.cost.consult.dao.CostConsultDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class CostConsultBiz extends NAbstractServletBiz
{
    public CostConsultBiz(NServiceResource nsr)
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
        CostConsultDao dao = new CostConsultDao(this.nsr);
        return dao.retrieveCostConsultList(xReq);
    }

    /**
     * 출원비용 품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createCostConsult(AjaxRequest xReq) throws NException
    {
        CostConsultDao dao = new CostConsultDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String consultId = seqUtil.getBizId();

        xReq.setUserData("CONSULT_ID", consultId);

        // 출원비용 품의서 생성
        dao.createCostConsult(xReq);

        NMultiData reqList = xReq.getMultiData("ds_costRequestList");
        String reqId = null;

        for (int i = 0; i < reqList.getRowSize(); i++) {
            reqId = reqList.getString(i, "REQ_ID");

            // 비용청구서 수정(품의서ID 설정)
            dao.updateCostRequestToConsult(reqId, consultId);

            // 비용마스터 수정(품의서ID 설정)
            dao.updateCostMasterToConsult(reqId, consultId);
        }

        return consultId;
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
        CostConsultDao dao = new CostConsultDao(this.nsr);
        return dao.retrieveCostConsult(xReq);
    }

    /**
     * 출원비용 품의서 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostConsultInputList(AjaxRequest xReq) throws NException
    {
        CostConsultDao dao = new CostConsultDao(this.nsr);
        return dao.retrieveCostConsultInputList(xReq);
    }

    /**
     * 출원비용 품의서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCostConsult(AjaxRequest xReq) throws NException
    {
        CostConsultDao dao = new CostConsultDao(this.nsr);
        dao.updateCostConsult(xReq);
    }

    /**
     * 출원비용 품의서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCostConsult(AjaxRequest xReq) throws NException
    {
        CostConsultDao dao = new CostConsultDao(this.nsr);

        // 비용청구서 수정(품의서ID 삭제)
        dao.updateCostRequestConsultId(xReq);

        // 비용마스터 수정(품의서ID 삭제)
        dao.updateCostMasterConsultId(xReq);

        // 출원비용 품의서 삭제
        dao.deleteCostConsult(xReq);
    }
}
