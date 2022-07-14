package anyfive.ipims.patent.schedule.assetif.dao;

import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ExecuteAssetIFDao extends NAbstractServletDao
{
    public ExecuteAssetIFDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자산번호 수정
     *
     * @return
     * @throws NException
     */
    public void updateAssetInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/asset", "/updateAssetInfo");
        dao.executeUpdate();


        dao.setQuery("/ipims/patent/schedule/asset", "/updateIfAssetResult");
        dao.executeUpdate();


    }

}
