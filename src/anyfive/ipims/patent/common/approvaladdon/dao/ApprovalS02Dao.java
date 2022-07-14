package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalS02Dao extends NAbstractServletDao
{
    public ApprovalS02Dao(NServiceResource nsr)
    {
        super(nsr);
    }
    /**
     * 선행기술조사 품의서 선행기술조사형태 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public String retrievePriorSearchConsultPrschType(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalS02", "/retrievePriorSearchConsultPrschType");
        dao.bind(apprKey);

        return dao.executeQueryForString();
    }

    /**
     * 선행기술조사 품의서 사무소송부일 업데이트
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updatePriorSearchConsultOfficeSendDate(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalS02", "/updatePriorSearchConsultOfficeSendDate");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 선행기술조사 의뢰 업체 정보(수신인)
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchOffice(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalS02", "/retrievePriorSearchOffice");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
    }
}
