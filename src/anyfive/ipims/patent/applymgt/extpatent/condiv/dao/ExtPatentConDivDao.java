package anyfive.ipims.patent.applymgt.extpatent.condiv.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtPatentConDivDao extends NAbstractServletDao
{
    public ExtPatentConDivDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 계속/분할OL 모출원 서지사항 조회
     *
     * @param divisionPriorRefId
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentConDivPrior(String divisionPriorRefId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/condiv", "/retrieveExtPatentConDivPrior");
        dao.bind("DIVISION_PRIOR_REF_ID", divisionPriorRefId);

        return dao.executeQueryForSingle();
    }

    /**
     * 계속/분할OL 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentConDiv(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/condiv", "/retrieveExtPatentConDiv");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 계속/분할OL 분할코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveExtPatentConDivDivisionCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/condiv", "/retrieveExtPatentConDivDivisionCode");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 계속/분할OL 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExtPatentConDiv(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/condiv", "/createExtPatentConDiv");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 계속/분할OL 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtPatentConDiv(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/condiv", "/updateExtPatentConDiv");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 계속/분할OL 출원국가 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExtPatentConDivCountry(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/condiv", "/createExtPatentConDivCountry");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
