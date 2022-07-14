package anyfive.ipims.patent.applymgt.intpatent.extabd.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.extabd.dao.ExtApplyAbdDao;

public class ExtApplyAbdBiz extends NAbstractServletBiz
{
    public ExtApplyAbdBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원 포기내역 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtApplyAbd(AjaxRequest xReq) throws NException
    {
        ExtApplyAbdDao dao = new ExtApplyAbdDao(this.nsr);

        return dao.retrieveExtApplyAbd(xReq);
    }

    /**
     * 해외출원 포기내역 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtApplyAbd(AjaxRequest xReq) throws NException
    {
        ExtApplyAbdDao dao = new ExtApplyAbdDao(this.nsr);

        dao.updateExtApplyAbd(xReq);
    }
}
