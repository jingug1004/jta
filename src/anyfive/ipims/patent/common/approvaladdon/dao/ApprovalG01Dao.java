package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalG01Dao extends NAbstractServletDao
{
    public ApprovalG01Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로그램 검토결과 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateProgramExamResult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalG01", "/updateProgramExamResult");
        dao.bind(apprKey);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalG01", "/updateProgramPatTeamReqDate");
        dao.bind(apprKey);


        return dao.executeUpdate();
    }

    /**
     * 프로그램 의뢰일 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateProgramPatTeamReqDate(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalG01", "/updateProgramPatTeamReqDate");
        dao.bind(apprKey);


        return dao.executeUpdate();
    }
}
