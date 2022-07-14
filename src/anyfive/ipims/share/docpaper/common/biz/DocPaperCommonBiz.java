package anyfive.ipims.share.docpaper.common.biz;

import java.util.regex.Matcher;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NDateUtil;
import any.util.etc.NTextUtil;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.common.util.SystemTypes;
import anyfive.ipims.share.docpaper.common.dao.DocPaperCommonDao;
import anyfive.ipims.share.docpaper.common.util.DocPaperConsts;

public class DocPaperCommonBiz extends NAbstractServletBiz
{
    private String            refId   = null;
    private String            listSeq = null;
    private NSingleData       data    = null;
    private boolean           isEvent = false;
    private DocPaperCommonDao dao     = null;

    public DocPaperCommonBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 초기화
     *
     * @param refId
     * @param paper
     */
    public void init(String refId)
    {
        this.refId = refId;
        this.data = new NSingleData();
        this.dao = new DocPaperCommonDao(this.nsr);
    }

    /**
     * 진행서류 코드 설정
     *
     * @param paperCode
     * @param paperSubcode
     */
    public void setPaper(String paperCode, String paperSubcode) throws NException
    {

        if (paperSubcode == null || paperSubcode.equals("")) paperSubcode = DocPaperConsts.SUBCODE_NONE;

        this.data = this.dao.retrieveDocPaper(this.refId, paperCode, paperSubcode);

        if (this.data.isEmpty() == true) {
            this.throwCreateException("존재하지 않는 진행서류입니다.");
        }

        if (SessionUtil.getUserInfo(this.nsr).getSystemType().equals(SystemTypes.OFFICE)) {
            this.setValue("CRE_USER", SessionUtil.getUserInfo(this.nsr).getUserId());
        }

        this.setValue("PAPER_CODE", paperCode);
        this.setValue("PAPER_SUBCODE", paperSubcode);
        this.setValue("PAPER_DATE", NDateUtil.getSysDate());
        this.setValue("INPUT_OWNER", DocPaperConsts.OWNER_SYSTEM);
    }

    /**
     * 진행서류 이벤트 설정
     *
     * @param eventId
     * @throws NException
     */
    public void setEvent(String eventId) throws NException
    {
        NSingleData eventInfo = this.dao.retrieveEventDocPaper(this.refId, eventId);

        if (eventInfo.isEmpty() == true) {
            this.throwCreateException("존재하지 않는 진행서류 이벤트 [" + eventId + "] 입니다.");
        }

        this.setPaper(eventInfo.getString("PAPER_CODE"), eventInfo.getString("PAPER_SUBCODE"));

        if (eventInfo.getString("NEXT_URGENT_DATE_QRY").trim().equals("") != true) {
            this.setValue("URGENT_DATE", this.dao.retrieveEventNextUrgentDate(eventInfo.getString("NEXT_URGENT_DATE_QRY")));
        }

        this.isEvent = true;
    }

    /**
     * REF_ID 반환
     *
     * @return
     */
    public String getRefId()
    {
        return this.refId;
    }

    /**
     * LIST_SEQ 반환
     *
     * @return
     */
    public String getListSeq()
    {
        return this.listSeq;
    }

    /**
     * 값 반환
     *
     * @param name
     */
    public String getValue(String name)
    {
        return this.data.getString(name);
    }

    /**
     * 값 설정
     *
     * @param name
     * @param value
     */
    public void setValue(String name, String value)
    {
        this.data.setString(name, value);
    }

    /**
     * 시스템형태별 입력주체 설정
     *
     * @param systemType
     */
    public void setInputOwnerBySystemType(String systemType)
    {
        if (SystemTypes.PATENT.equals(systemType)) {
            this.setValue("INPUT_OWNER", DocPaperConsts.OWNER_PATENT);
        }

        if (SystemTypes.OFFICE.equals(systemType)) {
            this.setValue("INPUT_OWNER", DocPaperConsts.OWNER_OFFICE);
        }
    }

    /**
     * 생성
     *
     * @return
     * @throws NException
     */
    public String create() throws NException
    {
        return this.create(false);
    }

    /**
     * 생성
     *
     * @param isSendMail
     *            알림메일 발송여부
     * @return
     * @throws NException
     */
    public String create(boolean isSendMail) throws NException
    {

        if (this.refId == null || this.refId.equals("")) {
            this.throwCreateException("관련번호가 정의되지 않았습니다.");
        }
        if (this.getValue("PAPER_CODE").equals("")) {
            this.throwCreateException("진행서류코드가 정의되지 않았습니다.");
        }
        if (this.getValue("PAPER_SUBCODE").equals("")) {
            this.throwCreateException("세부서류코드가 정의되지 않았습니다.");
        }

        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        this.listSeq = seqUtil.getPaperListSeq(this.refId);

        // OA 생성

        //if (!(this.getValue("DUE_DATE").equals("") && this.getValue("DUE_DATE").equals(null))) {
        if (this.getValue("OA_MGT_STEP").equals("S")) {
            this.dao.updateOACloseAll(this.refId, this.listSeq);
            this.setValue("OA_SEQ", seqUtil.getOASeq(this.refId));
            this.dao.createOA(this.refId, this.getValue("OA_SEQ"), this.listSeq, this.getValue("DUE_DATE"));
        }

        if(this.getValue("INOUT_DIV").equals("INT") && this.getValue("COUNTRY_CODE").equals("US")){
            this.dao.createIDS(this.refId , this.listSeq , this.data);
        }

        // 현재 진행중인 OA 시퀀스 설정
        if (this.getValue("PAPER_STEP").equals("OA") || this.getValue("PAPER_STEP").equals("ETC")) {
            this.setValue("OA_SEQ", this.dao.retrieveOASeq(this.refId));
        }

        // OA 종료
        if (this.getValue("OA_MGT_STEP").equals("E") || this.getValue("PAPER_STEP").equals("REG")) {
            this.dao.updateOACloseAll(this.refId, this.listSeq);
        }

        //기한리스트처리완료 입력시
        if (this.getValue("PAPER_CODE").equals("10INT-0084") || this.getValue("PAPER_CODE").equals("10EXT-0089")) {
            this.dao.proDocPaper(this.refId, this.listSeq, this.data);
        }

        // 진행서류 생성
        this.dao.createDocPaper(this.refId, this.listSeq, this.data);

        // 진행서류 이벤트 처리
        if (this.isEvent != true) {
            NMultiData eventList = this.dao.retrieveDocPaperEvent(this.getValue("PAPER_CODE"), this.getValue("PAPER_SUBCODE"));
            for (int i = 0; i < eventList.getRowSize(); i++) {
                this.executeEvent(eventList.getString(i, "EVENT_ID"));
            }
        }

        // 마스터 상태 업데이트
        if (this.getValue("MST_STATUS_YN").equals("1")) {
            if (this.getValue("MST_DIV").equals("A") == true) {
                this.dao.updateApplyMasterStatus(this.refId, this.data);
            }
            if (this.getValue("MST_DIV").equals("C") == true) {
                this.dao.updateDisputeMasterStatus(this.refId, this.data);
            }
        }

        // 마스터 포기처리
        if (this.getValue("MST_ABD_YN").equals("1") && this.dao.retrieveAppMasterAbdYn(this.refId) != true) {
            this.dao.updateMasterAbd(this.refId, this.listSeq);
        }

        //심사청구-진행완료일때 마스터심사청구 유무 변경
        if ((this.getValue("PAPER_CODE").equals("10EXT-0034") && this.getValue("PAPER_SUBCODE").equals("001")) == true
                || (this.getValue("PAPER_CODE").equals("10INT-0035") && this.getValue("PAPER_SUBCODE").equals("001")) == true
           ) {
                this.dao.updateMasterExamReqYn(this.refId, this.data);
        }

        // 진행서류 알림메일 생성
        this.createInformMail(isSendMail);

        if (this.getValue("WITH_PAPER_CODE").equals("") != true) {

            DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
            docBiz.init(this.refId);
            docBiz.setPaper(this.getValue("WITH_PAPER_CODE"), this.getValue("WITH_PAPER_SUBCODE"));
            docBiz.setValue("COMMENTS", this.getValue("PAPER_NAME") + "-" + this.getValue("PAPER_SUBNAME") + " " + docBiz.getValue("PAPER_NAME"));
            docBiz.create(true);
        }

        return this.listSeq;
    }
    /**
     * 삭제
     *
     * @param listSeq
     * @throws NException
     */
    public void delete(String listSeq) throws NException
    {
        this.listSeq = listSeq;

        if (this.refId == null || this.refId.equals("")) {
            this.throwDeleteException("관련번호가 정의되지 않았습니다.");
        }
        if (this.listSeq == null || this.listSeq.equals("")) {
            this.throwDeleteException("진행서류번호가 정의되지 않았습니다.");
        }

        // 진행서류 입력정보 조회
        NSingleData paperInfo = this.dao.retrieveInputDocPaper(this.refId, this.listSeq);

        // 삭제할 진행서류에 의해 종료되었던 OA를 다시 진행중으로 복원
        this.dao.updateOAStart(this.refId, this.listSeq);

        // 진행서류 입력정보 삭제
        this.dao.deleteInputDocPaper(this.refId, this.listSeq);

        // OA 삭제
        if (paperInfo.getString("OA_MGT_STEP").equals("S")) {
            if (this.dao.deleteOA(this.refId, paperInfo.getString("OA_SEQ")) == 0) {
                this.throwDeleteException("이미 진행중이거나 종료된 OA의 시작서류를 삭제할 수가 없습니다.");
            }
        }

        // OA DUE_DATE 수정
        this.dao.updateOADueDate(this.refId, paperInfo.getString("OA_SEQ"));

        // 첨부파일 삭제
        FileBiz fileBiz = new FileBiz(this.nsr);
        fileBiz.deleteFileList(paperInfo.getString("FILE_ID"));
    }

    /**
     * OA DUE_DATE 수정
     *
     * @param listSeq
     * @throws NException
     */
    public void updateOADueDate(String listSeq) throws NException
    {
        // 진행서류 입력정보 조회
        NSingleData paperInfo = this.dao.retrieveInputDocPaper(this.refId, listSeq);

        // OA DUE_DATE 수정
        this.dao.updateOADueDate(this.refId, paperInfo.getString("OA_SEQ"));
    }

    /**
     * 진행서류 이벤트 처리
     *
     * @param eventId
     * @throws NException
     */
    private void executeEvent(String eventId) throws NException
    {
        // OA 기간연장 처리
        if (eventId.equals("OA_PERIOD_EXTEND")) {
            if (this.getValue("OA_SEQ").equals("")) {
                this.throwCreateException("기간연장 처리할 수 있는 진행중인 OA가 존재하지 않습니다.");
            }
            if (this.getValue("DUE_DATE").equals("")) {
                throw new NBizException("법정기한을 입력해야 합니다.");
            }
            this.dao.updateOADueDate(this.refId, this.getValue("OA_SEQ"));
        }

        // 공개번호 입력
        if (eventId.equals("PUBLIC_NO_INPUT")) {
            this.dao.updateMasterPublicInfo(this.refId, this.data);
        }

        // 공고번호 입력
        if (eventId.equals("NOTICE_NO_INPUT")) {
            this.dao.updateMasterNoticeInfo(this.refId, this.data);
        }
    }

    /**
     * 진행서류 알림메일 생성
     *
     * @param isSendMail
     * @throws NException
     */
    private void createInformMail(boolean isSendMail) throws NException
    {
        if (isSendMail != true) return;
        NSingleData mailInfo = this.dao.retrieveInformMailSendInfo(this.refId, this.listSeq);

        // 담당자의견 메일에 엔터 적용
        String mailRemark = mailInfo.getString("REMARK");
        mailRemark = Matcher.quoteReplacement(mailRemark).replaceAll("\n", "<BR>\n");
        //mailRemark = mailRemark.replaceAll("\n", "<BR>\n");

        mailInfo.setString("REMARK", mailRemark);

        //System.out.println("PATTEAM_MAIL_YN:"+this.getValue("PATTEAM_MAIL_YN")+"\nOFFICE_MAIL_YN:"+this.getValue("OFFICE_MAIL_YN")+"\nINVENTOR_MAIL_YN:"+this.getValue("INVENTOR_MAIL_YN"));

        // 특허팀 알림메일 발송
        if (this.getValue("PATTEAM_MAIL_YN").equals("1")) {
            this.createInformMail(mailInfo, this.dao.retrieveInformMailPatteamRecvInfo(this.refId));
        }

        // 사무소 알림메일 발송
        if (this.getValue("OFFICE_MAIL_YN").equals("1")) {
          if(mailInfo.getString("PAPER_NAME").equals("사무소위임취소")){
              this.createUnSucMail(mailInfo, this.dao.retrieveInformMailOfficeRecvInfo(mailInfo.getString("OFFICE_CODE")));
          }else{
              this.createInformMail(mailInfo, this.dao.retrieveInformMailOfficeRecvInfo(mailInfo.getString("OFFICE_CODE")));
          }
        }

        // 발명자 알림메일 발송
        if (this.getValue("INVENTOR_MAIL_YN").equals("1")) {
          //if(mailInfo.getString("PAPER_NAME").equals("출원완료")){
          //      this.createSucMail(mailInfo, this.dao.retrieveInformMailInventorRecvList(this.refId));
          //}else{
              if(mailInfo.getString("INOUT_DIV").equals("EXT")){
                 this.createInformMail(mailInfo, this.dao.retrieveInformMailInventorRecvList(this.refId, mailInfo.getString("INOUT_DIV")));
              }else{
                 this.createInformMail(mailInfo, this.dao.retrieveInformMailInventorRecvList(this.refId));
              }
          //}
        }

       if(mailInfo.getString("PAPER_CODE").equals("10EXT-0019") || mailInfo.getString("PAPER_CODE").equals("10EXT-0020") || mailInfo.getString("PAPER_CODE").equals("10INT-0017") || mailInfo.getString("PAPER_CODE").equals("10INT-0018") || mailInfo.getString("PAPER_CODE").equals("10INT-0019"))
       {
           this.createMail(mailInfo, this.dao.retrieveInformMailRecvList(this.refId));
       }
    }
    /**
     * 출원완료 승계메일 생성
     *
     * @param mailInfo
     * @param recvList
     * @throws NException
     */
    private void createSucMail(NSingleData mailInfo, NMultiData recvList) throws NException
    {
        MailBiz mail = new MailBiz(this.nsr);

        mail.init();
        mail.template.init("/applymgt/succession");
        mail.template.setData(mailInfo);
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        for (int i = 0; i < recvList.getRowSize(); i++) {
            mail.addTo(recvList.getString(i, "TO_ADDR"), recvList.getString(i, "TO_NAME"));
        }
        mail.create();
    }
    /**
     * 출원완료 불승계메일 생성
     *
     * @param mailInfo
     * @param recvList
     * @throws NException
     */
    private void createUnSucMail(NSingleData mailInfo, NMultiData recvList) throws NException
    {
        MailBiz mail = new MailBiz(this.nsr);

        mail.init();
        mail.template.init("/applymgt/nosuccession");
        mail.template.setData(mailInfo);
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        for (int i = 0; i < recvList.getRowSize(); i++) {
            mail.addTo(recvList.getString(i, "TO_ADDR"), recvList.getString(i, "TO_NAME"));
        }
        mail.create();
    }



    /**
     * 진행서류 알림메일 생성
     *
     * @param mailInfo
     * @param recvList
     * @throws NException
     */
    private void createInformMail(NSingleData mailInfo, NMultiData recvList) throws NException
    {
        MailBiz mail = new MailBiz(this.nsr);

        mail.init();
        mail.template.init("/docpaper/docpaper");
        mail.template.setData(mailInfo);
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        for (int i = 0; i < recvList.getRowSize(); i++) {
            mail.addTo(recvList.getString(i, "TO_ADDR"), recvList.getString(i, "TO_NAME"));
        }
        mail.create();
    }

    /**
     * 생성 예외처리
     *
     * @param message
     * @throws NBizException
     */
    private void throwCreateException(String message) throws NBizException
    {
        throw new NBizException("[ERROR] 진행서류 생성시 다음과 같은 에러가 발생했습니다.\n\n" + message);
    }

    /**
     * 삭제 예외처리
     *
     * @param message
     * @throws NBizException
     */
    private void throwDeleteException(String message) throws NBizException
    {
        throw new NBizException("[ERROR] 진행서류 삭제시 다음과 같은 에러가 발생했습니다.\n\n" + message);
    }

    /**
     * 진행서류 알림메일 생성
     *
     * @param mailInfo
     * @param recvList
     * @throws NException
     */
    private void createMail(NSingleData mailInfo, NMultiData recvList) throws NException
    {
        MailBiz mail = new MailBiz(this.nsr);

        mail.init();
        mail.template.init("/docpaper/docpaper2");
        mail.template.setData(mailInfo);
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        for (int i = 0; i < recvList.getRowSize(); i++) {
            mail.addTo(recvList.getString(i, "TO_ADDR"), recvList.getString(i, "TO_NAME"));
        }
        mail.create();
    }
}
