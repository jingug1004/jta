package anyfive.ipims.patent.applymgt.tmark.intmasterrenew.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class TMarkIntMasterRenewDao extends NAbstractServletDao
{
    public TMarkIntMasterRenewDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내출원마스터 갱신정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntMasterRenewInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intmasterrenew", "/retrieveTMarkIntMasterRenewInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 상표국내출원마스터 갱신 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTMarkIntMasterRenew(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intmasterrenew", "/createTMarkIntMasterRenew");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmasterrenew", "/createTMarkIntMasterIntRenew");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 상표국내출원품의서 갱신 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTMarkIntConsultRenew(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intmasterrenew", "/createTMarkIntConsultRenew");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmasterrenew", "/createTMarkIntConsultTmarkRenew");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 상표국내출원의뢰서 갱신 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTMarkIntRequestRenew(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intmasterrenew", "/createTMarkIntRequestRenew");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmasterrenew", "/createTMarkIntRequestTmarkRenew");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
