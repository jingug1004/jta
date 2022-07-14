package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalG02Dao extends NAbstractServletDao
{
    public ApprovalG02Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로그램 마스터 수정
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public void updateProgramMaster(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalG02", "/updateProgramMaster");
        dao.bind(apprKey);
        dao.executeUpdate();
    }
}
