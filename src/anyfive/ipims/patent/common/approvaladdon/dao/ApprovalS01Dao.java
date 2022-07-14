package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalS01Dao extends NAbstractServletDao
{
    public ApprovalS01Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 선행기술조사 품의서 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updatePriorSearchConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalS01", "/updatePriorSearchConsult");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 선행기술조사 의뢰일 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updatePriorSearchReqDate(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalS01", "/updatePriorSearchReqDate");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
