package anyfive.ipims.patent.applymgt.common.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NLobDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ApplyMgtCommonDao extends NAbstractServletDao
{
    public ApplyMgtCommonDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내출원 의뢰서 수정가능 여부 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveIntRequestEditAvail(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveIntRequestEditAvail");
        dao.bind(xReq);

        return dao.executeQueryForString();
    }

    /**
     * 출원 마스터 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMasterInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveMasterInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내출원 마스터 탭 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntMasterTabInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveIntMasterTabInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 해외출원 마스터 탭 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtMasterTabInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveExtMasterTabInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 마스터 권리구분 변경정보 조회
     *
     * @param refId
     * @param rightDiv
     * @return
     * @throws NException
     */
    public NSingleData retrieveMasterRightDivChangeInfo(String refId, String rightDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveMasterRightDivChangeInfo");
        dao.bind("REF_ID", refId);
        dao.bind("RIGHT_DIV", rightDiv);

        return dao.executeQueryForSingle();
    }

    /**
     * 마스터 건담당자 변경정보 조회
     *
     * @param refId
     * @param jobMan
     * @return
     * @throws NException
     */
    public NSingleData retrieveMasterJobManChangeInfo(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveMasterJobManChangeInfo");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);

        return dao.executeQueryForSingle();
    }

    /**
     * 마스터 사무소 변경정보 조회
     *
     * @param refId
     * @param officeCode
     * @return
     * @throws NException
     */
    public NSingleData retrieveMasterOfficeCodeChangeInfo(String refId, String officeCode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveMasterOfficeCodeChangeInfo");
        dao.bind("REF_ID", refId);
        dao.bind("OFFICE_CODE", officeCode);

        return dao.executeQueryForSingle();
    }

    /**
     * 마스터 사무소담당자 변경정보 조회
     *
     * @param refId
     * @param officeJobMan
     * @return
     * @throws NException
     */
    public NSingleData retrieveMasterOfficeJobManChangeInfo(String refId, String officeJobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveMasterOfficeJobManChangeInfo");
        dao.bind("REF_ID", refId);
        dao.bind("OFFICE_JOB_MAN", officeJobMan);

        return dao.executeQueryForSingle();
    }

    /**
     * 마스터 초록정보 생성
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int createMasterAbstract(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/createMasterAbstract");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 마스터 초록정보 수정
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int updateMasterAbstract(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/updateMasterAbstract");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 마스터 초록정보 저장
     *
     * @param refId
     * @param abAbstract
     * @param abClaim
     * @return
     * @throws NException
     */
    public int updateMasterAbstract(String refId, String abAbstract, String abClaim) throws NException
    {
        NLobDao dao = new NLobDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/common/common", "/retrieveMasterAbstractForUpdate");
        dao.bind("REF_ID", refId);
        dao.setClobData("ABSTRACT", abAbstract);
        dao.setClobData("CLAIM", abClaim);

        return dao.executeUpdate();
    }

    /**
     * 건담당자 일괄변경 메일 수신자 정보 조회
     *
     * @param jobMan
     * @return NSingleData
     * @throws NException
     */
    public NSingleData getRecvInfo(String jobMan ) throws NException{
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/jobmanchange", "/getRecvInfo");
        dao.bind("JOB_MAN", jobMan);

        return dao.executeQueryForSingle();
    };
}
