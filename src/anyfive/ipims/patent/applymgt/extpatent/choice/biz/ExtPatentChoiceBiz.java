package anyfive.ipims.patent.applymgt.extpatent.choice.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.extpatent.choice.dao.ExtPatentChoiceDao;

public class ExtPatentChoiceBiz extends NAbstractServletBiz
{
    public ExtPatentChoiceBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원품의대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentChoiceList(AjaxRequest xReq) throws NException
    {
        ExtPatentChoiceDao dao = new ExtPatentChoiceDao(this.nsr);

        return dao.retrieveExtPatentChoiceList(xReq);
    }
}
