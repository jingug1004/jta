package anyfive.ipims.patent.common.approval.biz;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.exception.NSysException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NTextUtil;
import any.util.uuid.NUUID;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.ipims.patent.common.approval.dao.ApprovalDao;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ApprovalBiz extends NAbstractServletBiz
{
    private ApprovalDao dao       = null;
    private String      apprCode  = null;
    private String      apprNo    = null;
    private String      reqSeq    = null;
    private String      ansOrd    = null;
    private short       apprEvent = -1;
    private NSingleData apprKey   = null;
    private String      serverURL = null;
    private String      refNo     = null;

    public ApprovalBiz(NServiceResource nsr)
    {
        super(nsr);

        this.dao = new ApprovalDao(this.nsr);
    }

    /**
     * 결재정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApproval(AjaxRequest xReq) throws NException
    {
        this.apprCode = xReq.getParam("APPR_CODE");
        this.apprKey = xReq.getSingleData("ds_apprKey");

        if (this.apprCode.equals("")) {
            this.throwException("결재코드가 정의되지 않습니다.");
        }

        if (this.apprKey.isEmpty()) {
            this.throwException("결재키가 정의되지 않습니다.");
        }

        NSingleData result = new NSingleData();

        NSingleData apprMgt = this.dao.retrieveApprovalMgt(xReq);

        if (apprMgt.isEmpty() == true) {
            this.throwException("결재환경정보[" + xReq.getParam("APPR_CODE") + "]가 존재하지 않습니다.");
        }

        NSingleData apprMain = this.dao.retrieveApprovalMainInfo(this.apprCode, this.apprKey, apprMgt);

        this.apprNo = apprMain.getString("APPR_NO");

        apprMgt.setString("LOGIN_USER_ID", this.nsr.userInfo.getUserId());

        result.set("ds_apprMain", apprMain);
        result.set("ds_apprMgt", apprMgt);

        if (this.apprNo.equals("")) return result;

        result.set("ds_apprMst", this.dao.retrieveApprovalMaster(this.apprNo, apprMgt));
        result.set("ds_apprReq", this.dao.retrieveApprovalRequestList(this.apprNo));
        result.set("ds_apprAnsA", this.dao.retrieveApprovalAnswerListA(this.apprNo));
        result.set("ds_apprAnsB", this.dao.retrieveApprovalAnswerListB(this.apprNo));

        return result;
    }

    /**
     * 결재 공통처리
     *
     * @param xReq
     * @throws NException
     */
    public void executeApproval(AjaxRequest xReq) throws NException
    {
        this.serverURL = xReq.getContextURL();
        this.executeApproval(xReq, ApprovalEvents.valueOf(xReq.getParam("APPR_EVENT")));
    }

    /**
     * 결재 공통처리
     *
     * @param xReq
     * @throws NException
     */
    private void executeApproval(AjaxRequest xReq, short apprEvent) throws NException
    {
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        this.apprEvent = apprEvent;
        this.apprCode = xReq.getParam("APPR_CODE");
        this.apprNo = xReq.getParam("APPR_NO");
        this.apprKey = xReq.getSingleData("ds_apprKey");
        this.reqSeq = xReq.getParam("REQ_SEQ");
        this.ansOrd = xReq.getParam("ANS_ORD");
        this.refNo = xReq.getParam("REF_NO");

        if (this.apprCode.equals("")) {
            this.throwException("결재코드가 정의되지 않습니다.");
        }

        if ((this.apprKey == null || this.apprKey.isEmpty()) && this.apprNo.equals("")) {
            this.throwException("결재키와 결재번호 중 하나는 지정되어야 합니다.");
        }

        NSingleData apprMgt = xReq.getSingleData("ds_apprMgt");
        NSingleData reqInfo = xReq.getSingleData("ds_apprReqSave");
        NSingleData ansInfo = xReq.getSingleData("ds_apprAnsSave");
        NMultiData ansUserListA = xReq.getMultiData("ds_apprAnsUserA");
        NMultiData ansUserListB = xReq.getMultiData("ds_apprAnsUserB");

        if (this.apprKey != null) {
            String[] apprPkCols = apprMgt.getString("APPR_PK_COLS").split(",");
            for (int i = 0; i < apprPkCols.length; i++) {
                if (this.apprKey.getKeyIndex(apprPkCols[i].trim()) == -1) {
                    this.throwException("결재 키 [" + apprPkCols[i].trim() + "]의 값이 정의되지 않았습니다.");
                }
            }
        }

        if (this.apprEvent == ApprovalEvents.REQUEST || this.apprEvent == ApprovalEvents.UPPER) {
            if (ansUserListA.getRowSize() == 0) this.throwException("결재처리자가 없습니다.");
        }

        if (apprMgt == null) {
            apprMgt = this.dao.retrieveApprovalMgt(xReq);
        }
        if (this.apprKey == null || this.apprKey.isEmpty()) {
            this.apprKey = this.dao.retrieveApprovalKeys(this.apprNo, apprMgt);
        }

        // 결재마스터 테이블 및 업무테이블 처리
        switch (this.apprEvent) {
        case ApprovalEvents.NONE:
        case ApprovalEvents.REQUEST:
            if (this.apprNo.equals("")) {
                if (this.apprKey.isEmpty()) {
                    this.throwException("업무테이블의 Key값이 정의되지 않았습니다.");
                }
                this.apprNo = seqUtil.getApprNo();
                if (this.dao.updateApprovalNoOfBizTable(apprMgt, this.apprKey, this.apprNo) == 0) {
                    this.throwException("업무테이블에 결재번호를 적용할 수 없습니다.");
                }
            }
            this.reqSeq = seqUtil.getApprReqSeq(this.apprNo);
            if (this.dao.updateApprovalMaster(this.apprNo, this.reqSeq) == 0) {
                if (this.dao.createApprovalMaster(this.apprNo, this.apprCode, this.reqSeq) == 0) {
                    this.throwException("결재정보를 생성할 수 없습니다.\n\n이미 결재요청된 건인지 확인하시기 바랍니다.");
                }
            }
            break;
        }

        String apprStatus = null;
        boolean isAgreeAllApproval = false; // 최종승인처리 여부

        // 결재요청 테이블 및 결재처리 테이블 처리
        switch (this.apprEvent) {
        case ApprovalEvents.NONE:
            this.dao.createApprovalRequest(this.apprNo, this.reqSeq, reqInfo);
            apprStatus = "8";
            break;
        case ApprovalEvents.REQUEST:
            this.dao.createApprovalRequest(this.apprNo, this.reqSeq, reqInfo);
            this.dao.createApprovalAnswerA(this.apprNo, this.reqSeq, ansUserListA);
            this.dao.createApprovalAnswerB(this.apprNo, this.reqSeq, ansUserListB);
            this.dao.updateApprovalNextAnswerStatus(this.apprNo, this.reqSeq);
            this.createRequestMail();
            apprStatus = "1";
            break;
        case ApprovalEvents.CANCEL:
            this.createCancelMail();
            this.dao.deleteApprovalAnswerListA(this.apprNo, this.reqSeq);
            this.dao.deleteApprovalAnswerListB(this.apprNo, this.reqSeq);
            if (this.dao.deleteApprovalRequest(this.apprNo, this.reqSeq) == 0) {
                this.throwException("결재취소할 수 없는 건입니다.\n\n이미 결재처리된 건인지 확인하세요.");
            }
            apprStatus = "0";
            break;
        case ApprovalEvents.REWRITE:
            apprStatus = "0";
            break;
        case ApprovalEvents.AGREE:
            if (this.dao.updateApprovalAnswer(this.apprNo, this.reqSeq, this.ansOrd, ansInfo) == 0) {
                this.throwException("승인처리할 수 없습니다.\n\n결재취소된 건인지 확인하시기 바랍니다.");
            }

            if (this.dao.updateApprovalNextAnswerStatus(this.apprNo, this.reqSeq) == 0) {
                isAgreeAllApproval = true;
            } else {
                this.createRequestMail();
            }
            break;
        case ApprovalEvents.AGREEALL:
            this.dao.updateApprovalRequest(this.apprNo, this.reqSeq, "8");
            this.createDistributeMail();
            apprStatus = "8";
            break;
        case ApprovalEvents.REJECT:
            if (this.dao.updateApprovalAnswer(this.apprNo, this.reqSeq, this.ansOrd, ansInfo) == 0) {
                this.throwException("반려처리할 수 없습니다.\n\n결재취소된 건인지 확인하시기 바랍니다.");
            }
            this.dao.updateApprovalRequest(this.apprNo, this.reqSeq, "9");
            this.createRejectMail();
            apprStatus = "9";
            break;
        case ApprovalEvents.UPPER:
            if (this.dao.updateApprovalAnswer(this.apprNo, this.reqSeq, this.ansOrd, ansInfo) == 0) {
                this.throwException("상위요청할 수 없습니다.\n\n결재취소된 건인지 확인하시기 바랍니다.");
            }
            this.dao.createApprovalAnswerA(this.apprNo, this.reqSeq, ansUserListA);
            this.dao.updateApprovalNextAnswerStatus(this.apprNo, this.reqSeq);
            this.createRequestMail();
            break;
        }

        // 결재 마스터 수정
        this.dao.updateApprovalMasterStatus(this.apprNo, apprStatus);

        // 업무프로세스 처리
        if (this.apprKey.getKeySize() == 1 && this.dao.retrieveWorkProcessAvail(this.apprCode, this.apprKey).equals("1")) {
            this.executeWorkProcess();
        }

        // 결재업무별 처리
        this.executeAddon(apprMgt);

        // 최종승인 처리
        if (isAgreeAllApproval == true) {
            this.executeApproval(xReq, ApprovalEvents.AGREEALL);
        }
    }

    /**
     * 결재요청메일 생성
     *
     * @throws NException
     */
    private void createRequestMail() throws NException
    {
        MailBiz mail = new MailBiz(this.nsr);

        NSingleData mailInfo = this.dao.retrieveApprovalMailSendInfoReq(this.apprNo);
        NSingleData ansInfo = this.dao.retrieveApprovalMailAnsInfo(this.apprNo);
        NMultiData histList = this.dao.retrieveApprovalMailHistoryList(this.apprNo);

        mail.init();
        mail.template.init("/approval/request");
        mail.template.setData(mailInfo);
        for (int i = 0; i < histList.getRowSize(); i++) {
            mail.template.addValue("ansList", "    <TR>\n");
            mail.template.addValue("ansList", "        <TD align=\"center\">" + Integer.toString(i + 1) + "차 결재자</TD>\n");
            mail.template.addValue("ansList", "        <TD>" + histList.getString(i, "ANS_USER_NAME") + "</TD>\n");
            mail.template.addValue("ansList", "        <TD align=\"center\">[" + histList.getString(i, "ANS_STATUS_NAME") + "]</TD>\n");
            mail.template.addValue("ansList", "        <TD align=\"center\">" + histList.getString(i, "ANS_DATE") + "</TD>\n");
            mail.template.addValue("ansList", "        <TD>" + histList.getString(i, "ANS_MEMO") + "</TD>\n");
            mail.template.addValue("ansList", "    </TR>\n");
        }
        mail.template.setValue("REF_NO", this.refNo);
        mail.template.setValue("DIST_USER_NAMES", this.getDistUserNames());
        mail.template.setValue("APPR_LINK", this.getApprLink(ansInfo.getString("TO_USER_ID")));
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.setFrom(mailInfo.getString("FROM_ADDR"), mailInfo.getString("FROM_NAME"));
        mail.addTo(ansInfo.getString("TO_ADDR"), ansInfo.getString("TO_NAME"));
        mail.create();
    }

    /**
     * 결재취소메일 생성
     *
     * @throws NException
     */
    private void createCancelMail() throws NException
    {
        MailBiz mail = new MailBiz(this.nsr);

        NSingleData mailInfo = this.dao.retrieveApprovalMailSendInfoReq(this.apprNo);
        NSingleData ansInfo = this.dao.retrieveApprovalMailAnsInfo(this.apprNo);

        mail.init();
        mail.template.init("/approval/cancel");
        mail.template.setData(mailInfo);
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.setFrom(mailInfo.getString("FROM_ADDR"), mailInfo.getString("FROM_NAME"));
        mail.addTo(ansInfo.getString("TO_ADDR"), ansInfo.getString("TO_NAME"));
        mail.create();
    }

    /**
     * 결재반려메일 생성
     *
     * @throws NException
     */
    private void createRejectMail() throws NException
    {
        MailBiz mail = new MailBiz(this.nsr);

        NSingleData mailInfo = this.dao.retrieveApprovalMailSendInfoAns(this.apprNo, this.ansOrd);
        NSingleData ansInfo = this.dao.retrieveApprovalMailReqInfo(this.apprNo);

        mail.init();
        mail.template.init("/approval/reject");
        mail.template.setData(mailInfo);
        mail.template.setValue("APPR_LINK", this.getApprLink(ansInfo.getString("TO_USER_ID")));
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.setFrom(mailInfo.getString("FROM_ADDR"), mailInfo.getString("FROM_NAME"));
        mail.addTo(ansInfo.getString("TO_ADDR"), ansInfo.getString("TO_NAME"));
        mail.create();
    }

    /**
     * 결재배포메일 생성
     *
     * @throws NException
     */
    private void createDistributeMail() throws NException
    {
        MailBiz mail = new MailBiz(this.nsr);
        NMultiData distList = new NMultiData();

        if(apprCode.equals("P02")){
            distList = this.dao.retrieveApprovalMailDistList2(this.apprNo);
        }else{
            distList = this.dao.retrieveApprovalMailDistList(this.apprNo);
        }


        if (distList.getRowSize() == 0) return;

        NSingleData mailInfo = this.dao.retrieveApprovalMailSendInfoReq(this.apprNo);
        NMultiData histList = this.dao.retrieveApprovalMailHistoryList(this.apprNo);

        String distUserNames = this.getDistUserNames();

        for (int i = 0; i < distList.getRowSize(); i++) {
            mail.init();

            if(apprCode.equals("P01") || apprCode.equals("P02")){//특허 국내출원 의뢰 , 품의
                mail.template.init("/approval/distribute2"); // REF_NO 추가
            }else{//  그외
                mail.template.init("/approval/distribute");
            }
            mail.template.setData(mailInfo);
            for (int j = 0; j < histList.getRowSize(); j++) {
                mail.template.addValue("ansList", "    <TR>\n");
                mail.template.addValue("ansList", "        <TD align=\"center\">" + Integer.toString(j + 1) + "차 결재자</TD>\n");
                mail.template.addValue("ansList", "        <TD>" + histList.getString(j, "ANS_USER_NAME") + "</TD>\n");
                mail.template.addValue("ansList", "        <TD align=\"center\">[" + histList.getString(j, "ANS_STATUS_NAME") + "]</TD>\n");
                mail.template.addValue("ansList", "        <TD align=\"center\">" + histList.getString(j, "ANS_DATE") + "</TD>\n");
                mail.template.addValue("ansList", "        <TD>" + histList.getString(j, "ANS_MEMO") + "</TD>\n");
                mail.template.addValue("ansList", "    </TR>\n");
            }

            if(apprCode.equals("P01")){//특허 국내출원 의뢰
                mail.template.setValue("REF_NO", this.refNo);
            }else if(apprCode.equals("P02")){//특허 국내출원 품의
                mail.template.setValue("REF_NO", distList.getString(i, "REF_NO"));
            }

            mail.template.setValue("DIST_USER_NAMES", distUserNames);
            mail.template.setValue("APPR_LINK", this.getApprLink(distList.getString(i, "TO_USER_ID")));
            mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
            mail.setFrom(mailInfo.getString("FROM_ADDR"), mailInfo.getString("FROM_NAME"));
            mail.addTo(distList.getString(i, "TO_ADDR"), distList.getString(i, "TO_NAME"));
            mail.create();
        }
    }

    /**
     * 배포자들 문자열 반환(쉼표로 구분)
     *
     * @return
     * @throws NException
     */
    private String getDistUserNames() throws NException
    {
        StringBuffer sb = new StringBuffer();

        NMultiData distUserList = this.dao.retrieveApprovalAnswerListB(this.apprNo);

        for (int i = 0; i < distUserList.getRowSize(); i++) {
            sb.append((i > 0 ? ", " : "") + distUserList.getString(i, "DIST_USER_NAME"));
        }

        return sb.toString();
    }

    /**
     * 결재 바로가기 링크 문자열 반환
     *
     * @param userId
     * @return
     */
    private String getApprLink(String userId) throws NException
    {
        String apprViewer = this.serverURL + "/anyfive/ipims/patent/approval/ApprovalViewR.jsp";

        String mailKey = NUUID.randomUUID().toString().replaceAll("-", "").toUpperCase();

        this.dao.createApprovalMailKey(mailKey, this.apprNo, userId);

        //원본 return "<A href=\"javascript:window.open('" + apprViewer + "?MAIL_KEY=" + mailKey + "', '_ipims_appr_viewer_', 'width=850,height=650,resizable=yes').focus();\">[바로가기]</A>";
        return "<A href=\"" + apprViewer + "?MAIL_KEY=" + mailKey + "\" target=\"_blank\">[바로가기]</A>";
    }

    /**
     * 결재업무별 처리
     *
     * @param apprMgt
     * @throws NException
     */
    private void executeAddon(NSingleData apprMgt) throws NException
    {
        String className = "anyfive.ipims.patent.common.approvaladdon.biz.Approval" + this.apprCode + "Biz";

        try {
            Class<?> bizClass = Class.forName(className);
            Constructor<?> constructor = bizClass.getConstructor(new Class[] {NServiceResource.class});
            ApprovalAbstractBiz instance = (ApprovalAbstractBiz)constructor.newInstance(new Object[] {this.nsr});
            instance.execute(this.apprNo, this.apprKey, this.apprEvent, apprMgt);
        } catch (ClassNotFoundException e) {
            throw new NSysException("ClassNotFoundException \"" + className + "\" in ApprovalBiz.executeAddon");
        } catch (InstantiationException e) {
            throw new NSysException("InstantiationException \"" + className + "\" in ApprovalBiz.executeAddon");
        } catch (NoSuchMethodException e) {
            throw new NSysException("NoSuchMethodException \"" + className + ".execute\" in ApprovalBiz.executeAddon");
        } catch (IllegalAccessException e) {
            throw new NSysException("IllegalAccessException \"" + className + ".execute\" in ApprovalBiz.executeAddon");
        } catch (InvocationTargetException e) {
            Throwable cause = e.getCause();
            if (cause == null) {
                throw new IllegalStateException("Got InvocationTargetException, but the cause is null.");
            } else if (cause instanceof NBizException) {
                throw (NBizException)cause;
            } else if (cause instanceof NSysException) {
                throw (NSysException)cause;
            } else if (cause instanceof RuntimeException) {
                throw (NSysException)cause;
            } else {
                throw new NException(e.getTargetException());
            }
        }
    }

    /**
     * 업무프로세스 처리
     *
     * @throws NException
     */
    private void executeWorkProcess() throws NException
    {
        String wpEventId = null;

        try {
            wpEventId = WorkProcessConst.Action.class.getField("APPR_" + ApprovalEvents.name(this.apprEvent)).get(this).toString();
        } catch (NoSuchFieldException e) {
            return;
        } catch (IllegalAccessException e) {
            return;
        }

        if (wpEventId == null) return;

        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(this.apprKey.getString(this.apprKey.getKey(0)), wpEventId);
    }

    /**
     * 예외처리
     *
     * @param message
     * @throws NBizException
     */
    private void throwException(String message) throws NBizException
    {
        throw new NBizException("[ERROR] 결재처리시 다음과 같은 에러가 발생했습니다.\n\n" + message);
    }
}
