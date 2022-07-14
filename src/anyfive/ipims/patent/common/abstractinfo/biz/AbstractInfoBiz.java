package anyfive.ipims.patent.common.abstractinfo.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.abstractinfo.dao.AbstractInfoDao;

public class AbstractInfoBiz extends NAbstractServletBiz
{
    public AbstractInfoBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 서지정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAbstractInfo(AjaxRequest xReq) throws NException
    {
        AbstractInfoDao dao = new AbstractInfoDao(this.nsr);

        String mstDiv = dao.retrieveAbstractMstDiv(xReq);

        if (mstDiv.equals("") == true) return null;

        return dao.retrieveAbstractInfo(mstDiv, xReq);
    }
}
