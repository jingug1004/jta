package anyfive.ipims.patent.applymgt.extpatent.eppct.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtPatentEpPctDao extends NAbstractServletDao
{
    public ExtPatentEpPctDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * EP/PCT OL 모출원 서지사항 조회
     *
     * @param divisionPriorRefId
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentEpPctPrior(String divisionPriorRefId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/eppct", "/retrieveExtPatentEpPctPrior");
        dao.bind("DIVISION_PRIOR_REF_ID", divisionPriorRefId);

        return dao.executeQueryForSingle();
    }

    /**
     * EP/PCT OL 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentEpPct(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/eppct", "/retrieveExtPatentEpPct");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * EP/PCT OL 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExtPatentEpPct(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/eppct", "/createExtPatentEpPct");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * EP/PCT OL 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtPatentEpPct(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/eppct", "/updateExtPatentEpPct");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
