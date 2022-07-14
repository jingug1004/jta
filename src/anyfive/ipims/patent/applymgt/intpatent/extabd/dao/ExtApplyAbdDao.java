package anyfive.ipims.patent.applymgt.intpatent.extabd.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtApplyAbdDao extends NAbstractServletDao
{
    public ExtApplyAbdDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/extabd", "/retrieveExtApplyAbd");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 해외출원 포기내역 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtApplyAbd(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/extabd", "/updateExtApplyAbd");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
