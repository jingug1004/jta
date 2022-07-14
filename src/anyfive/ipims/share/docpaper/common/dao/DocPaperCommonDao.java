package anyfive.ipims.share.docpaper.common.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class DocPaperCommonDao extends NAbstractServletDao
{
    public DocPaperCommonDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 조회
     *
     * @param refId
     * @param paperCode
     * @param paperSubcode
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaper(String refId, String paperCode, String paperSubcode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveDocPaper");
        dao.bind("REF_ID", refId);
        dao.bind("PAPER_CODE", paperCode);
        dao.bind("PAPER_SUBCODE", paperSubcode);

        return dao.executeQueryForSingle();
    }

    /**
     * 이벤트 진행서류 조회
     *
     * @param refId
     * @param eventId
     * @return
     * @throws NException
     */
    public NSingleData retrieveEventDocPaper(String refId, String eventId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveEventDocPaper");
        dao.bind("REF_ID", refId);
        dao.bind("EVENT_ID", eventId);

        return dao.executeQueryForSingle();
    }

    /**
     * 이벤트 다음 업무처리기한일 조회
     *
     * @param nextUrgentDateQry
     * @return
     * @throws NException
     */
    public String retrieveEventNextUrgentDate(String nextUrgentDateQry) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveEventNextUrgentDate");
        dao.replaceText("NEXT_URGENT_DATE_QRY", nextUrgentDateQry);

        return dao.executeQueryForString();
    }

    /**
     * 현재 진행중인 OA들을 모두 종료처리
     *
     * @param refId
     * @param listSeq
     * @return
     * @throws NException
     */
    public int updateOACloseAll(String refId, String listSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateOACloseAll");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);

        return dao.executeUpdate();
    }

    /**
     * OA 생성
     *
     * @param refId
     * @param oaSeq
     * @param startPaperSeq
     * @param dueDate
     * @return
     * @throws NException
     */
    public int createOA(String refId, String oaSeq, String startPaperSeq, String dueDate) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/createOA");
        dao.bind("REF_ID", refId);
        dao.bind("OA_SEQ", oaSeq);
        dao.bind("START_PAPER_SEQ", startPaperSeq);
        dao.bind("DUE_DATE", dueDate);

        return dao.executeUpdate();
    }

    /**
     * IDS 생성
     *
     * @param refId
     * @param oaSeq
     * @return
     * @throws NException
     */
    public int createIDS(String refId, String listSeq, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/createIDS");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);
        dao.bind(data);


        return dao.executeUpdate();
    }

    /**
     * 진행중인 OA 시퀀스 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public String retrieveOASeq(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveOASeq");
        dao.bind("REF_ID", refId);

        return dao.executeQueryForString();
    }

    /**
     * OA 종료
     *
     * @param refId
     * @param oaSeq
     * @param endPaperSeq
     * @return
     * @throws NException
     */
    public int updateOAClose(String refId, String oaSeq, String endPaperSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateOAClose");
        dao.bind("REF_ID", refId);
        dao.bind("OA_SEQ", oaSeq);
        dao.bind("END_PAPER_SEQ", endPaperSeq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 생성
     *
     * @param refId
     * @param listSeq
     * @param data
     * @return
     * @throws NException
     */
    public int createDocPaper(String refId, String listSeq, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/createDocPaper");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);
        dao.bind(data);

        return dao.executeUpdate();
    }

    public int proDocPaper(String refId, String listSeq, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/proDocPaper");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);
        dao.bind(data);

        return dao.executeUpdate();
    }


    /**
     * 출원 마스터상태 업데이트
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int updateApplyMasterStatus(String refId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateApplyMasterStatus");
        dao.bind("REF_ID", refId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 분쟁/소송 마스터상태 업데이트
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int updateDisputeMasterStatus(String refId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateDisputeMasterStatus");
        dao.bind("REF_ID", refId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 마스터 포기여부 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public boolean retrieveAppMasterAbdYn(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveAppMasterAbdYn");
        dao.bind("REF_ID", refId);

        return dao.executeQueryForSingle().equals("1");
    }

    /**
     * 마스터 포기처리
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int updateMasterAbd(String refId, String listSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateMasterAbd");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 알림메일 발송정보 조회
     *
     * @param refId
     * @param listSeq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInformMailSendInfo(String refId, String listSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveInformMailSendInfo");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);

        return dao.executeQueryForSingle();
    }

    /**
     * 진행서류 알림메일 특허팀 수신정보 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveInformMailPatteamRecvInfo(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveInformMailPatteamRecvInfo");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }

    /**
     * 진행서류 알림메일 사무소 수신정보 조회
     *
     * @param officeCode
     * @return
     * @throws NException
     */
    public NMultiData retrieveInformMailOfficeRecvInfo(String officeCode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveInformMailOfficeRecvInfo");
        dao.bind("OFFICE_CODE", officeCode);

        return dao.executeQuery();
    }
    /**
     * 진행서류 알림메일 모든 발명자 수신목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveInformMailAllpatent() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveInformMailAllpatent");

        return dao.executeQuery();
    }

    /**
     * 진행서류 알림메일 발명자 수신목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveInformMailInventorRecvList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveInformMailInventorRecvList");
        dao.bind("REF_ID", refId);

        dao.addQuery("intInoutDiv", "1");

        return dao.executeQuery();
    }

    /**
     * 진행서류 알림메일 발명자 수신목록 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveInformMailInventorRecvList(String refId, String inoutDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveInformMailInventorRecvList");
        dao.bind("REF_ID", refId);

        if(inoutDiv.equals("EXT")){
            dao.addQuery("extInoutDiv", "1");
        }else{
            dao.addQuery("intInoutDiv", "1");
        }

        return dao.executeQuery();
    }

    /**
     * 진행서류 입력정보 조회
     *
     * @param refId
     * @param listSeq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInputDocPaper(String refId, String listSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveInputDocPaper");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);

        return dao.executeQueryForSingle();
    }

    /**
     * 삭제할 진행서류에 의해 종료되었던 OA를 다시 진행중으로 복원
     *
     * @param refId
     * @param listSeq
     * @return
     * @throws NException
     */
    public int updateOAStart(String refId, String listSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateOAStart");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 입력정보 삭제
     *
     * @param refId
     * @param listSeq
     * @return
     * @throws NException
     */
    public int deleteInputDocPaper(String refId, String listSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/deleteInputDocPaper");
        dao.bind("REF_ID", refId);
        dao.bind("LIST_SEQ", listSeq);

        return dao.executeUpdate();
    }

    /**
     * OA 삭제
     *
     * @param refId
     * @param oaSeq
     * @return
     * @throws NException
     */
    public int deleteOA(String refId, String oaSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/deleteOA");
        dao.bind("REF_ID", refId);
        dao.bind("OA_SEQ", oaSeq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 이벤트 조회
     *
     * @param paperCode
     * @param paperSubcode
     * @return
     * @throws NException
     */
    public NMultiData retrieveDocPaperEvent(String paperCode, String paperSubcode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveDocPaperEvent");
        dao.bind("PAPER_CODE", paperCode);
        dao.bind("PAPER_SUBCODE", paperSubcode);

        return dao.executeQuery();
    }

    /**
     * OA DUE_DATE 수정
     *
     * @param refId
     * @param oaSeq
     * @return
     * @throws NException
     */
    public int updateOADueDate(String refId, String oaSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateOADueDate");
        dao.bind("REF_ID", refId);
        dao.bind("OA_SEQ", oaSeq);

        return dao.executeUpdate();
    }

    /**
     * 마스터 공개정보 수정
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int updateMasterPublicInfo(String refId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateMasterPublicInfo");
        dao.bind("REF_ID", refId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 마스터 공고정보 수정
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int updateMasterNoticeInfo(String refId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateMasterNoticeInfo");
        dao.bind("REF_ID", refId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 알림메일(미국 및 EPO 담당 국내사무소에 IDS제출요청메일발송)
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NMultiData retrieveInformMailRecvList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/retrieveInformMailRecvList");
        dao.bind("REF_ID", refId);

        //dao.addQuery("intInoutDiv", "1");

        return dao.executeQuery();
    }

    /**
     * 마스터 심서청구 유무 수정
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int updateMasterExamReqYn(String refId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/common", "/updateMasterExamReqYn");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }
}
