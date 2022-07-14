package anyfive.ipims.patent.costmgt.annual.current.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.annual.current.dao.AnnualCurrentDao;

public class AnnualCurrentBiz extends NAbstractServletBiz
{
    public AnnualCurrentBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차료 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualCurrentList(AjaxRequest xReq) throws NException
    {
        AnnualCurrentDao dao = new AnnualCurrentDao(this.nsr);

        return dao.retrieveAnnualCurrentList(xReq);
    }
}
