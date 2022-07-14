package anyfive.ipims.office.costmgt.intcost.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.costmgt.intcost.dao.IntCostDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class IntCostBiz extends NAbstractServletBiz
{
    public IntCostBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내비용입력 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntCostList(AjaxRequest xReq) throws NException
    {
        IntCostDao dao = new IntCostDao(this.nsr);

        return dao.retrieveIntCostList(xReq);
    }

    /**
     * 국내비용청구서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createIntCostRequest(AjaxRequest xReq) throws NException
    {
        IntCostDao dao = new IntCostDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String reqId = seqUtil.getBizId();

        xReq.setUserData("REQ_ID", reqId);

        // 국내비용청구서 생성
        dao.createIntCostRequest(xReq);

        // 국내비용입력 수정(청구서ID 설정)
        dao.updateIntCostListReqId(xReq);

        return reqId;
    }

    /**
     * 건별비용현황 상세비용 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntCostListR(AjaxRequest xReq) throws NException
    {
        IntCostDao dao = new IntCostDao(this.nsr);

        return dao.retrieveIntCostListR(xReq);
    }
}
