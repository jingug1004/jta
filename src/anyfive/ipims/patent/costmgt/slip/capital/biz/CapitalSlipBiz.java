package anyfive.ipims.patent.costmgt.slip.capital.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.slip.capital.dao.CapitalSlipDao;

public class CapitalSlipBiz extends NAbstractServletBiz
{
    public CapitalSlipBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자본적 지출 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalSlipList(AjaxRequest xReq) throws NException
    {
        CapitalSlipDao dao = new CapitalSlipDao(this.nsr);

        return dao.retrieveCapitalSlipList(xReq);
    }

    /**
     * 전표처리 비용 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalSlipDetailList(AjaxRequest xReq) throws NException
    {
        CapitalSlipDao dao = new CapitalSlipDao(this.nsr);

        return dao.retrieveCapitalSlipDetailList(xReq);
    }
}
