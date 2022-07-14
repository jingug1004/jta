package anyfive.ipims.patent.systemmgt.datahandle.costappcancle.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.costappcancle.dao.CostCancleDao;

public class CostCancleBiz extends NAbstractServletBiz
{
    public CostCancleBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용결재 취소 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostCancleList(AjaxRequest xReq) throws NException
    {
        CostCancleDao dao = new CostCancleDao(this.nsr);
        return dao.retrieveCostCancleList(xReq);
    }

    /**
     * 비용결재 취소 목록 취소
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void costcancleListU(AjaxRequest xReq) throws NException
    {
        NMultiData data = xReq.getMultiData("ds_costCancleList");
        CostCancleDao dao = new CostCancleDao(this.nsr);

        for( int i=0; i< data.getRowSize(); i++ ){
            dao.costcancleListU(data.getString(i, "APPR_NO"), xReq);
        }
    }
}
