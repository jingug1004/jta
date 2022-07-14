package anyfive.ipims.patent.costmgt.capital.consult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.capital.consult.dao.CapitalMgtConsultDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class CapitalMgtConsultBiz extends NAbstractServletBiz
{
    public CapitalMgtConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자본적 지출 품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalMgtConsultList(AjaxRequest xReq) throws NException
    {
        CapitalMgtConsultDao dao = new CapitalMgtConsultDao(this.nsr);

        return dao.retrieveCapitalMgtConsultList(xReq);
    }

    /**
     * 자본적 지출 품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createCapitalMgtConsult(AjaxRequest xReq) throws NException
    {
        CapitalMgtConsultDao dao = new CapitalMgtConsultDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String consultId = seqUtil.getBizId();

        xReq.setUserData("CONSULT_ID", consultId);

        // 자본적 지출 품의 생성
        dao.createCapitalMgtConsult(xReq);

        // 비용마스터 품의ID 저장
        dao.updateCostMstConsultId(xReq, xReq.getMultiData("ds_capitalMgtList"));

        return consultId;
    }

    /**
     * 자본적 지출 확정 품의 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalMgtConsult(AjaxRequest xReq) throws NException
    {
        CapitalMgtConsultDao dao = new CapitalMgtConsultDao(this.nsr);

        return dao.retrieveCapitalMgtConsult(xReq);
    }

    /**
     * 자본적 지출  확정 품의 상세 비용목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalMgtCostInput(AjaxRequest xReq) throws NException
    {
        CapitalMgtConsultDao dao = new CapitalMgtConsultDao(this.nsr);

        return dao.retrieveCapitalMgtCostInput(xReq);
    }

    /**
     * 매각 확정 품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCapitalMgtConsult(AjaxRequest xReq) throws NException
    {
        CapitalMgtConsultDao dao = new CapitalMgtConsultDao(this.nsr);

        dao.updateCapitalMgtConsult(xReq);
    }

    /**
     * 자본적 지출 확정 품의 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCapitalMgtConsult(AjaxRequest xReq) throws NException
    {
        CapitalMgtConsultDao dao = new CapitalMgtConsultDao(this.nsr);

        // 비용마스터 수정(품의서ID 삭제)
        dao.updateCostMstConsultIdToNull(xReq);

        // 자본적 지출 품의 삭제
        dao.deleteCapitalMgtConsult(xReq);
    }

}
