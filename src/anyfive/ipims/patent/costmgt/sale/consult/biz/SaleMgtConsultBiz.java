package anyfive.ipims.patent.costmgt.sale.consult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.sale.consult.dao.SaleMgtConsultDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class SaleMgtConsultBiz extends NAbstractServletBiz
{
    public SaleMgtConsultBiz(NServiceResource nsr)
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
    public String createSaleMgtConsult(AjaxRequest xReq) throws NException
    {
        SaleMgtConsultDao dao = new SaleMgtConsultDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String consultId = seqUtil.getBizId();

        xReq.setUserData("CONSULT_ID", consultId);

        // 매각 확정 생성
        dao.createSaleMgtConsult(xReq);

        // 비용마스터 품의ID 저장
        dao.updateCostMstConsultId(xReq, xReq.getMultiData("ds_saleMgtList"));

        return consultId;
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
        SaleMgtConsultDao dao = new SaleMgtConsultDao(this.nsr);

        return dao.retrieveSaleMgt(xReq);
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
        SaleMgtConsultDao dao = new SaleMgtConsultDao(this.nsr);

        return dao.retrieveSaleMgtCostList(xReq);
    }

    /**
     * 매각 확정 품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSaleMgtConsult(AjaxRequest xReq) throws NException
    {
        SaleMgtConsultDao dao = new SaleMgtConsultDao(this.nsr);

        dao.updateSaleMgtConsult(xReq);
    }

    /**
     * 매각 확정 품의 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteSaleMgtConsult(AjaxRequest xReq) throws NException
    {
        SaleMgtConsultDao dao = new SaleMgtConsultDao(this.nsr);

        // 비용마스터 수정(품의서ID 삭제)
        dao.updateCostMstConsultIdToNull(xReq);

        // 매각 확정 품의 삭제
        dao.deleteSaleMgtConsult(xReq);
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
        SaleMgtConsultDao dao = new SaleMgtConsultDao(this.nsr);

        return dao.retrieveSaleMgtConsultList(xReq);
    }
}
