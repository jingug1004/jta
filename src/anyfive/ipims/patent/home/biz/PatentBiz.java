package anyfive.ipims.patent.home.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.home.dao.PatentDao;

public class PatentBiz extends NAbstractServletBiz
{
    public PatentBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 특허보유현황 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrievePatentCountList(AjaxRequest xReq) throws NException
    {
        PatentDao dao = new PatentDao(this.nsr);

        return dao.retrievePatentCountList(xReq);
    }
}
