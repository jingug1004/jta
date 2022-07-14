package anyfive.ipims.patent.applymgt.family.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.uuid.NUUID;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.family.dao.FamilyDao;

public class FamilyBiz extends NAbstractServletBiz
{
    public FamilyBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 패밀리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveFamilyList(AjaxRequest xReq) throws NException
    {
        FamilyDao dao = new FamilyDao(this.nsr);

        NSingleData result = new NSingleData();

        String refId = xReq.getParam("REF_ID");
        String workId = NUUID.randomUUID().toString().replaceAll("-", "");

        dao.executeFamilyProcedure(workId, refId);

        result.set("ds_mainList", dao.retrieveFamilyMainList(workId));
        result.set("ds_linkList", dao.retrieveFamilyLinkList(workId));

        dao.executeFamilyProcedure(workId, null);

        return result;
    }

    /**
     * 패밀리 툴팁 상세정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveFamilyTooltip(AjaxRequest xReq) throws NException
    {
        FamilyDao dao = new FamilyDao(this.nsr);

        return dao.retrieveFamilyTooltip(xReq);
    }

    /**
     * 패밀리 Flow 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveFamilyFlowList(AjaxRequest xReq) throws NException
    {
        FamilyDao dao = new FamilyDao(this.nsr);

        return dao.retrieveFamilyFlowList(xReq);
    }
}
