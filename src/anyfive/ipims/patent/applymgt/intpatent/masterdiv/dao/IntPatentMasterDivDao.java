package anyfive.ipims.patent.applymgt.intpatent.masterdiv.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class IntPatentMasterDivDao extends NAbstractServletDao
{
    public IntPatentMasterDivDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내분할 모출원 서지사항 조회
     *
     * @param divisionPriorRefId
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentMasterDivPrior(String divisionPriorRefId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/masterdiv", "/retrieveIntPatentMasterDivPrior");
        dao.bind("DIVISION_PRIOR_REF_ID", divisionPriorRefId);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내분할 분할코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveIntPatentMasterDivDivisionCode(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/masterdiv", "/retrieveIntPatentMasterDivDivisionCode");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 국내마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createIntPatentMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/masterdiv", "/createIntPatentMaster");
        dao.bind(xReq);
        int result = dao.executeUpdate();

        if (result == 0) return result;

        dao.setQuery("/ipims/patent/applymgt/intpatent/masterdiv", "/createIntPatentMasterPat");
        dao.bind(xReq);
        dao.executeUpdate();

        return result;
    }

    /**
     * 국내출원품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createIntPatentConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/masterdiv", "/createIntPatentConsult");
        dao.bind(xReq);
        int result = dao.executeUpdate();

        if (result == 0) return result;

        dao.setQuery("/ipims/patent/applymgt/intpatent/masterdiv", "/createIntPatentConsultPat");
        dao.bind(xReq);
        dao.executeUpdate();

        return result;
    }

    /**
     * 국내출원품의서 생성(품의서가 없는 경우 마스터로부터)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createIntPatentConsultByMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/masterdiv", "/createIntPatentConsultByMaster");
        dao.bind(xReq);
        int result = dao.executeUpdate();

        if (result == 0) return result;

        dao.setQuery("/ipims/patent/applymgt/intpatent/masterdiv", "/createIntPatentConsultByMasterPat");
        dao.bind(xReq);
        dao.executeUpdate();

        return result;
    }
}
