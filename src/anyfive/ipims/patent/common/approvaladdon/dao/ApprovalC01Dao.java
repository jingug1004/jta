package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalC01Dao extends NAbstractServletDao
{
    public ApprovalC01Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용마스터 전표상태 업데이트(1:처리대상)
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateCostSlipStatus(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalC01", "/updateCostSlipStatus");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
