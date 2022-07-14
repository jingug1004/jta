package anyfive.ipims.patent.home.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.home.dao.DueDateDao;

public class DueDateBiz extends NAbstractServletBiz
{
    public DueDateBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * DUE-DATE별 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveDueDateCount(AjaxRequest xReq) throws NException
    {
        DueDateDao dao = new DueDateDao(this.nsr);

        return dao.retrieveDueDateCount(xReq);
    }

    /**
     * DUE-DATE별 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDueDateList(AjaxRequest xReq) throws NException
    {
        DueDateDao dao = new DueDateDao(this.nsr);

        return dao.retrieveDueDateList(xReq);
    }
}
