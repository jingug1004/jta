package anyfive.ipims.patent.applymgt.invreward.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.invreward.dao.InvRewardDao;

public class InvRewardBiz extends NAbstractServletBiz
{
    public InvRewardBiz(NServiceResource nsr)
    {
        super(nsr);
    }


    /**
     * 발명자별 보상금지급조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInvRewardList(AjaxRequest xReq) throws NException
    {
        InvRewardDao dao = new InvRewardDao(this.nsr);

        return dao.retrieveInvRewardList(xReq);
    }
}
