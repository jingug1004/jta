package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalE02Dao extends NAbstractServletDao
{
    public ApprovalE02Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 특허부서 평가완료여부 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateEvalComMstPatdeptEndYn(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalE02", "/updateEvalComMstPatdeptEndYn");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
