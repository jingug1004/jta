package anyfive.ipims.patent.applymgt.priorjob.oalist.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.priorjob.oalist.dao.OAListDao;

public class OAListBiz extends NAbstractServletBiz
{
    public OAListBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * OA검토현황 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOAList(AjaxRequest xReq) throws NException
    {
        OAListDao dao = new OAListDao(this.nsr);

        return dao.retrieveOAList(xReq);
    }
}
