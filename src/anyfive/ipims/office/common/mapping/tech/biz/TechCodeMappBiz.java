package anyfive.ipims.office.common.mapping.tech.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.office.common.mapping.tech.dao.TechCodeMappDao;

public class TechCodeMappBiz extends NAbstractServletBiz
{
    public TechCodeMappBiz(NServiceResource nsr)
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
        TechCodeMappDao dao = new TechCodeMappDao(this.nsr);

        return dao.retrieveTechCodeList(refId, mappDiv);
    }
}
