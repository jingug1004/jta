package anyfive.ipims.patent.schedule.assetif.biz;

import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.schedule.assetif.dao.ExecuteAssetIFDao;

public class ExecuteAssetIFBiz extends NAbstractServletBiz
{
    public ExecuteAssetIFBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자산번호 정보 I/F Process
     *
     * @return
     * @throws NException
     */
    public void updateAssetInfo() throws NException
    {
        ExecuteAssetIFDao dao = new ExecuteAssetIFDao(this.nsr);

        dao.updateAssetInfo();

    }
}


