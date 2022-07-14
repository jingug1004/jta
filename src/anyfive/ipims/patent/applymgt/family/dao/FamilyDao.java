package anyfive.ipims.patent.applymgt.family.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NProcedureDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class FamilyDao extends NAbstractServletDao
{
    public FamilyDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 패밀리 프로시저 실행
     *
     * @param workId
     * @param refId
     * @return
     * @throws NException
     */
    public int executeFamilyProcedure(String workId, String refId) throws NException
    {
        NProcedureDao dao = new NProcedureDao(this.nsr);

        dao.setProcedure("/ipims/patent/applymgt/family/family", "/executeFamilyProcedure");
        dao.bind("WORK_ID", workId);
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 패밀리 메인 목록 조회
     *
     * @param workId
     * @return
     * @throws NException
     */
    public NMultiData retrieveFamilyMainList(String workId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/family/family", "/retrieveFamilyMainList");
        dao.bind("WORK_ID", workId);

        return dao.executeQuery();
    }

    /**
     * 패밀리 링크 목록 조회
     *
     * @param workId
     * @return
     * @throws NException
     */
    public NMultiData retrieveFamilyLinkList(String workId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/family/family", "/retrieveFamilyLinkList");
        dao.bind("WORK_ID", workId);

        return dao.executeQuery();
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/family/family", "/retrieveFamilyTooltip");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/family/family", "/retrieveFamilyFlowList");
        dao.bind(xReq);

        return dao.executeQuery();
    }
}
