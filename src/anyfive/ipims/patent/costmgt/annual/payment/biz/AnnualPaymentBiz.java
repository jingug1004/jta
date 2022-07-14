package anyfive.ipims.patent.costmgt.annual.payment.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.annual.payment.dao.AnnualPaymentDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class AnnualPaymentBiz extends NAbstractServletBiz
{
    public AnnualPaymentBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차료 납부관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualPaymentList(AjaxRequest xReq) throws NException
    {
        AnnualPaymentDao dao = new AnnualPaymentDao(this.nsr);

        return dao.retrieveAnnualPaymentList(xReq);
    }

    /**
     * 연차료 납부관리 업로드
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String uploadAnnualPayment(AjaxRequest xReq) throws NException
    {
        AnnualPaymentDao dao = new AnnualPaymentDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String result = null;
        if (dao.updateAnnualPayment(xReq) == 0) {

            xReq.setUserData("COST_SEQ", seqUtil.getCostSeq());
            if (dao.createCostMaster(xReq) == 0) {
                throw new NBizException("연차료 청구비용을 생성할 수 없습니다.\n\n존재하지 않는 REF-NO이거나 중복된 청구비용입니다.");
            }

            dao.createAnnualPayment(xReq);
            xReq.setUserData("COST_SEQ", seqUtil.getCostSeq());
            dao.createOfficeChargeMaster(xReq);
            xReq.setUserData("COST_SEQ", seqUtil.getCostSeq());

            dao.createExtChargeMaster(xReq);
           // dao.createCostReminde(xReq);
            result = "C";
        } else {
            dao.updatePriceCostMaster(xReq);
            dao.updateOfficeChargeMaster(xReq);
            dao.updateExtChargeMaster(xReq);
            dao.updateCostReminde(xReq);
            result = "U";
        }

        return result;
    }
}
