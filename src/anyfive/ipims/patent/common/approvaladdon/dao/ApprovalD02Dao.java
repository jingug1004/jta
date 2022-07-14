package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalD02Dao extends NAbstractServletDao
{
    public ApprovalD02Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내디자인출원 품의서 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD02", "/retrieveDesignIntConsult");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내디자인출원 품의서 수정
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateDesignIntConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD02", "/updateDesignIntConsult");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 국내디자인출원 마스터 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntMaster(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD02", "/retrieveDesignIntMaster");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내디자인출원 마스터 수정
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public void updateDesignIntMaster(NSingleData apprKey, NSingleData masterInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD02", "/updateDesignIntMaster");
        dao.bind(apprKey);
        dao.bind(masterInfo);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD02", "/updateDesignIntMasterInt");
        dao.bind(apprKey);
        dao.bind(masterInfo);
        dao.executeUpdate();
    }
}
