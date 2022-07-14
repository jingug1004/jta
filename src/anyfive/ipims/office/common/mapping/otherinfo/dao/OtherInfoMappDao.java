package anyfive.ipims.office.common.mapping.otherinfo.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class OtherInfoMappDao extends NAbstractServletDao
{
    public OtherInfoMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상대정보 목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveOtherInfoList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/mapping/otherinfo", "/retrieveOtherInfoList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }
}
