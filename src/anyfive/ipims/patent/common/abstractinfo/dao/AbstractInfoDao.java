package anyfive.ipims.patent.common.abstractinfo.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AbstractInfoDao extends NAbstractServletDao
{
    public AbstractInfoDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 마스터 구분 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveAbstractMstDiv(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/abstractinfo/abstractinfo", "/retrieveAbstractMstDiv");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 서지정보 조회
     *
     * @param mstDiv
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAbstractInfo(String mstDiv, AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/abstractinfo/abstractinfo", "/retrieveAbstractInfo" + mstDiv);
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }
}
