package anyfive.ipims.office.common.mapping.inventor.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.office.common.mapping.inventor.dao.InventorMappDao;

public class InventorMappBiz extends NAbstractServletBiz
{
    public InventorMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 발명자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveInventorList(String refId) throws NException
    {
        InventorMappDao dao = new InventorMappDao(this.nsr);

        return dao.retrieveInventorList(refId);
    }
}
