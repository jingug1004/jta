package anyfive.ipims.share.cost.input.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.cost.input.dao.CostInputDao;

public class CostInputBiz extends NAbstractServletBiz
{
    public CostInputBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createCost(AjaxRequest xReq) throws NException
    {
        CostInputDao dao = new CostInputDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        xReq.setUserData("COST_SEQ", seqUtil.getCostSeq());

        dao.createCost(xReq);
    }

    /**
     * 비용 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCost(AjaxRequest xReq) throws NException
    {
        CostInputDao dao = new CostInputDao(this.nsr);

        return dao.retrieveCost(xReq);
    }

    /**
     * 비용 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCost(AjaxRequest xReq) throws NException
    {
        CostInputDao dao = new CostInputDao(this.nsr);

        if (dao.updateCost(xReq) == 0) {
            throw new NBizException("수정할 수 있는 상태가 아닙니다.");
        }
    }

    /**
     * 비용 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCost(AjaxRequest xReq) throws NException
    {
        CostInputDao dao = new CostInputDao(this.nsr);

        if (dao.deleteCost(xReq) == 0) {
            throw new NBizException("삭제할 수 없습니다.");
        }
    }
}
