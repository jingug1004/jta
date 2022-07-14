package anyfive.ipims.office.common.mapping.tech.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class TechCodeMappDao extends NAbstractServletDao
{
    public TechCodeMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 기술분류코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveTechCodeList(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/mapping/techcode", "/retrieveTechCodeList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }
}
