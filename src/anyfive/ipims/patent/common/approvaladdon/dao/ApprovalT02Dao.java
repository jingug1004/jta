package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalT02Dao extends NAbstractServletDao
{
    public ApprovalT02Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내상표출원 품의서 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalT02", "/retrieveTMarkIntConsult");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내상표출원 품의서 수정
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateTMarkIntConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalT02", "/updateTMarkIntConsult");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 국내상표출원 마스터 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntMaster(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalT02", "/retrieveTMarkIntMaster");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내상표출원 마스터 수정
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public void updateTMarkIntMaster(NSingleData apprKey, NSingleData masterInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalT02", "/updateTMarkIntMaster");
        dao.bind(apprKey);
        dao.bind(masterInfo);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalT02", "/updateTMarkIntMasterInt");
        dao.bind(apprKey);
        dao.bind(masterInfo);
        dao.executeUpdate();
    }
}
