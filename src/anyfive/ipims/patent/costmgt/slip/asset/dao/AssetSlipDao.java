package anyfive.ipims.patent.costmgt.slip.asset.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AssetSlipDao extends NAbstractServletDao
{
    public AssetSlipDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자산/거절 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetSlipList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/asset", "/retrieveAssetSlipList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 자산/거절 전표 비용목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetSlipCostList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/asset", "/retrieveAssetSlipCostList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
