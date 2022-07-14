package anyfive.ipims.office.common.mapping.refno.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.office.common.mapping.refno.dao.RefNoMappDao;

public class RefNoMappBiz extends NAbstractServletBiz
{
    public RefNoMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * REF_NO 목록 조회
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @return
     * @throws NException
     */
    public NMultiData retrieveRefNoList(String grpId, String mappKind, String mappDiv) throws NException
    {
        RefNoMappDao dao = new RefNoMappDao(this.nsr);

        return dao.retrieveRefNoList(grpId, mappKind, mappDiv);
    }
}
