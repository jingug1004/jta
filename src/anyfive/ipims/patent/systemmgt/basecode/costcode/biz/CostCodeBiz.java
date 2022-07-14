package anyfive.ipims.patent.systemmgt.basecode.costcode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.costcode.dao.CostCodeDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class CostCodeBiz extends NAbstractServletBiz
{
    public CostCodeBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용종류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostCodeList(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);

        return dao.retrieveCostCodeList(xReq);
    }

    /**
     * 비용대분류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostCode(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);

        return dao.retrieveCostCode(xReq);
    }

    /**
     * 비용대분류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createCostCode(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String costCode = seqUtil.getCostGrandCode();

        xReq.setUserData("GRAND_CODE", costCode);

        dao.createCostGrandCode(xReq);

        //상세분류 생성 - "없음"
        // xReq.setUserData("DETAIL_CODE", "000");
        // xReq.setUserData("DETAIL_NAME", "없음");
        // xReq.setUserData("TAX_YN", "Y");
        // xReq.setUserData("DISP_ORD", "1");
        // xReq.setUserData("USE_YN", "1");

        // dao.createCostDetailCode(xReq);

        return costCode;
    }

    /**
     * 비용대분류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCostCode(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);

        dao.updateCostCode(xReq);
    }

    /**
     * 비용대분류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCostCode(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);

        dao.deleteCostDetailCodeList(xReq);
        dao.deleteCostCode(xReq);
    }

    /**
     * 상세분류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostDetailCodeList(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);

        return dao.retrieveCostDetailCodeList(xReq);
    }

    /**
     * 상세분류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostDetailCode(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);

        return dao.retrieveCostDetailCode(xReq);
    }

    /**
     * 상세분류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createCostDetailCode(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String costDetailcode = seqUtil.getCostDetailCode(xReq.getParam("GRAND_CODE"));

        xReq.setUserData("DETAIL_CODE", costDetailcode);

        dao.createCostDetailCode(xReq);

        return costDetailcode;
    }

    /**
     * 상세분류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCostDetailCode(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);

        dao.updateCostDetailCode(xReq);
    }

    /**
     * 상세분류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCostDetailCode(AjaxRequest xReq) throws NException
    {
        CostCodeDao dao = new CostCodeDao(this.nsr);

        dao.deleteCostDetailCode(xReq);
    }
}
