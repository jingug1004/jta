package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalT01Dao extends NAbstractServletDao
{
    public ApprovalT01Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내상품출원 품의서 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateTMarkIntConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalT01", "/updateTMarkIntConsult");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 국내상품출원 특허팀의뢰일 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateTMarkIntPatteamReqDate(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalT01", "/updateTMarkIntPatteamReqDate");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
