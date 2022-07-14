package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalD01Dao extends NAbstractServletDao
{
    public ApprovalD01Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내디자인출원 품의서 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateDesignIntConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD01", "/updateDesignIntConsult");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 국내디자인출원 특허팀의뢰일 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateDesignIntPatteamReqDate(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD01", "/updateDesignIntPatteamReqDate");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
