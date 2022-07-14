package anyfive.ipims.patent.applymgt.applyplan.actual.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.applyplan.actual.dao.ApplyPlanActualDao;

public class ApplyPlanActualBiz extends NAbstractServletBiz
{
    public ApplyPlanActualBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원실적 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApplyPlanActualList(AjaxRequest xReq) throws NException
    {
        ApplyPlanActualDao dao = new ApplyPlanActualDao(this.nsr);

        String date = xReq.getParam("DATE_START");
        if(date != null && date !=""){
            date = date.substring(0,4);
        }

        return dao.retrieveApplyPlanActualList(xReq , date);
    }
}
