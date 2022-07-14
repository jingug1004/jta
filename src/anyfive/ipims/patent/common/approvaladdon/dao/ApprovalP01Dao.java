package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalP01Dao extends NAbstractServletDao
{
    public ApprovalP01Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내특허출원 품의서 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateIntPatentConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP01", "/updateIntPatentConsult");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 국내특허출원 특허팀의뢰일 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateIntPatentPatteamReqDate(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP01", "/updateIntPatentPatteamReqDate");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
