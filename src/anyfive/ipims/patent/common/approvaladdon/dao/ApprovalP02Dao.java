package anyfive.ipims.patent.common.approvaladdon.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ApprovalP02Dao extends NAbstractServletDao
{
    public ApprovalP02Dao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내특허출원 품의서 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/retrieveIntPatentConsult");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내특허출원 의뢰서 수정
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateIntPatentRequest(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/updateIntPatentRequest");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 국내특허출원 품의서 수정
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public int updateIntPatentConsult(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/updateIntPatentConsult");
        dao.bind(apprKey);

        return dao.executeUpdate();
    }

    /**
     * 국내특허출원 마스터 조회
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentMaster(NSingleData apprKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/retrieveIntPatentMaster");
        dao.bind(apprKey);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내특허출원 마스터 수정
     *
     * @param apprKey
     * @return
     * @throws NException
     */
    public void updateIntPatentMaster(NSingleData apprKey, NSingleData masterInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/updateIntPatentMaster");
        dao.bind(apprKey);
        dao.bind(masterInfo);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/updateIntPatentMasterInt");
        dao.bind(apprKey);
        dao.bind(masterInfo);
        dao.executeUpdate();
    }

    /**
     * 우선권취하되는 자출원건 수정
     *
     * @param refId
     * @param priorityRefId
     * @return
     * @throws NException
     */
    public int updateIntPatentMasterForPriorChild(String refId, String priorityRefId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/updateIntPatentMasterForPriorChild");
        dao.bind("PRIORITY_REF_ID", priorityRefId);
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 병합종료되는 자출원건 수정
     *
     * @param refId
     * @param unionRefId
     * @return
     * @throws NException
     */
    public int updateIntPatentMasterForUnionChild(String refId, String unionRefId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/updateIntPatentMasterForUnionChild");
        dao.bind("UNION_REF_ID", unionRefId);
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 승계/포기 알림메일 수신자 목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveNoticeMailRecvList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/approvaladdon/approvalP02", "/retrieveNoticeMailRecvList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }
}
