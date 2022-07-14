package anyfive.ipims.patent.statistic.office.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.statistic.office.dao.OfficeEvalMasterDao;

public class OfficeEvalMasterBiz extends NAbstractServletBiz
{
    public OfficeEvalMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사무소평가현황 목록조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeEvalMasterList(AjaxRequest xReq) throws NException
    {
        OfficeEvalMasterDao dao = new OfficeEvalMasterDao(this.nsr);

        return dao.retrieveOfficeEvalMasterList(xReq);
    }

    /**
     * 사무소평가현황 목록조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeEvalMasterDetail(AjaxRequest xReq) throws NException
    {
        OfficeEvalMasterDao dao = new OfficeEvalMasterDao(this.nsr);

        return dao.retrieveOfficeEvalMasterDetail(xReq);
    }

    /**
     * 종합평가의견조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveEvalOpinionView(AjaxRequest xReq) throws NException
    {
        OfficeEvalMasterDao dao = new OfficeEvalMasterDao(this.nsr);

        return dao.retrieveEvalOpinionView(xReq);
    }

    /**
     * 세부평가항목조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveEvalItem(AjaxRequest xReq) throws NException
    {
        OfficeEvalMasterDao dao = new OfficeEvalMasterDao(this.nsr);

        return dao.retrieveEvalItem(xReq);
    }
}
