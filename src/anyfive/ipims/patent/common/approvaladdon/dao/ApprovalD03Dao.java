package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalD03Dao extends NAbstractServletDao
{
    public ApprovalD03Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 오더레터 출원국가 목록 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NMultiData retrieveExtNewOLCountryList(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD03", "/retrieveExtNewOLCountryList");
        dao.bind(apprKey);

        return dao.executeQuery();
    }

    /**
     * 디자인마스터 생성
     *
     * @param apprKey
     * @param refId
     * @param countryCode
     * @throws NException
     */
    public void createDesignMaster(NSingleData apprKey, String refId, String countryCode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD03", "/createDesignMaster");
        dao.bind(apprKey);
        dao.bind("REF_ID", refId);
        dao.bind("COUNTRY_CODE", countryCode);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD03", "/createDesignMasterExt");
        dao.bind(apprKey);
        dao.bind("REF_ID", refId);
        dao.bind("COUNTRY_CODE", countryCode);
        dao.executeUpdate();
    }

    /**
     * 오더레터 출원국가 업데이트(REF_ID)
     *
     * @param apprKey
     * @param refId
     * @param countryCode
     * @return
     * @throws NException
     */
    public int updateExtNewOLCountry(NSingleData apprKey, String refId, String countryCode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD03", "/updateExtNewOLCountry");
        dao.bind(apprKey);
        dao.bind("REF_ID", refId);
        dao.bind("COUNTRY_CODE", countryCode);

        return dao.executeUpdate();
    }

    /**
     * 오더레터 업데이트(사무소송부일)
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateExtNewOrderLetter(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalD03", "/updateExtNewOrderLetter");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }
}
