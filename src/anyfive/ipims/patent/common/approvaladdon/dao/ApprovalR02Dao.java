package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalR02Dao extends NAbstractServletDao
{
    public ApprovalR02Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차료 리마인더 유지여부 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrieveCostReminderKeepYn(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalR02", "/RetrieveCostReminderKeepYn");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
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

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalR02", "/updateEvalComMstPatdeptEndYn");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 연차료 리마인더 평가완료여부 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateAnnualReminderEvalEndYn(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalR02", "/updateAnnualReminderEvalEndYn");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
