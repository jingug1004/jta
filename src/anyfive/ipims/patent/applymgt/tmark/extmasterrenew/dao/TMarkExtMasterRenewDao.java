package anyfive.ipims.patent.applymgt.tmark.extmasterrenew.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class TMarkExtMasterRenewDao extends NAbstractServletDao
{
    public TMarkExtMasterRenewDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표해외출원마스터 갱신정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtMasterRenewInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/extmasterrenew", "/retrieveTMarkExtMasterRenewInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 상표해외출원마스터 갱신 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTMarkExtMasterRenew(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/extmasterrenew", "/createTMarkExtMasterRenew");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/extmasterrenew", "/createTMarkExtMasterIntRenew");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
