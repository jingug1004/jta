package anyfive.ipims.office.common.mapping.inventor.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class InventorMappDao extends NAbstractServletDao
{
    public InventorMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 발명자 목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveInventorList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/mapping/inventor", "/retrieveInventorList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }
}
