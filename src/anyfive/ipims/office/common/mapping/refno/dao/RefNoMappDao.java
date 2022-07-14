package anyfive.ipims.office.common.mapping.refno.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class RefNoMappDao extends NAbstractServletDao
{
    public RefNoMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * REF-NO 목록 조회
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @return
     * @throws NException
     */
    public NMultiData retrieveRefNoList(String grpId, String mappKind, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/common/mapping/refno", "/retrieveRefNoList");
        dao.bind("GRP_ID", grpId);
        dao.bind("MAPP_KIND", mappKind);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }
}
