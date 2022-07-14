package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalO01Dao extends NAbstractServletDao
{
    public ApprovalO01Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내 거절검토서 내용 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntRejectExam(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalO01", "/retrieveIntRejectExam");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내 거절검토서 발송일 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateIntRejectExamSendDate(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalO01", "/updateIntRejectExamSendDate");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
