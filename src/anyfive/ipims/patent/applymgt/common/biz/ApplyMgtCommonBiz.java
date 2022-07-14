package anyfive.ipims.patent.applymgt.common.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NTextUtil;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.ipims.patent.applymgt.common.dao.ApplyMgtCommonDao;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class ApplyMgtCommonBiz extends NAbstractServletBiz
{
    public ApplyMgtCommonBiz(NServiceResource nsr)
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
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);

        return dao.retrieveIntRequestEditAvail(xReq);
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
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);

        return dao.retrieveMasterInfo(xReq);
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
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);

        return dao.retrieveIntMasterTabInfo(xReq);
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
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);

        return dao.retrieveExtMasterTabInfo(xReq);
    }

    /**
     * 마스터 권리구분 변경시 진행서류 추가
     *
     * @param refId
     * @param rightDiv
     * @throws NException
     */
    public void createMasterRightDivChangePaper(String refId, String rightDiv) throws NException
    {
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // 건담당자 변경여부 조회
        NSingleData data = dao.retrieveMasterRightDivChangeInfo(refId, rightDiv);

        if (data.getString("CHANGE_YN").equals("1") != true) return;

        // 진행서류 생성
        docBiz.init(refId);
        docBiz.setEvent("RIGHT_DIV_CHANGE");
        docBiz.setValue("PAPER_REF_NO", data.getString("PAPER_REF_NO"));
        docBiz.setValue("COMMENTS", data.getString("COMMENTS"));
        docBiz.create();
    }

    /**
     * 마스터 건담당자 변경시 진행서류 추가
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void createMasterJobManChangePaper(String refId, String jobMan) throws NException
    {
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        MailBiz mail = new MailBiz(this.nsr);

        NSingleData mailInfo = new NSingleData();

        // 건담당자 변경여부 조회
        NSingleData data = dao.retrieveMasterJobManChangeInfo(refId, jobMan);

        if (data.getString("CHANGE_YN").equals("1") != true) return;

        // 진행서류 생성
        docBiz.init(refId);
        docBiz.setEvent("JOB_MAN_CHANGE");
        docBiz.setValue("PAPER_REF_NO", data.getString("PAPER_REF_NO"));
        docBiz.setValue("COMMENTS", data.getString("COMMENTS"));
        docBiz.create();

        // 건담당자 변경 메일 발송
        mailInfo = dao.getRecvInfo(jobMan);
        mail.init();
        mailInfo.setString("REMARK", data.getString("COMMENTS"));
        mailInfo.setString("REF_NO", data.getString("REF_NO"));
        mailInfo.setString("KO_APP_TITLE", data.getString("KO_APP_TITLE"));
        mail.template.init("/jobmanchange/jobmanchange");
        mail.template.setData(mailInfo);
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.addTo(mailInfo.getString("TO_ADDR"), mailInfo.getString("TO_NAME"));
        mail.create();
    }

    /**
     * 마스터 사무소 변경시 진행서류 추가
     *
     * @param refId
     * @param officeCode
     * @throws NException
     */
    public void createMasterOfficeCodeChangePaper(String refId, String officeCode) throws NException
    {
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // 사무소 변경여부 조회
        NSingleData data = dao.retrieveMasterOfficeCodeChangeInfo(refId, officeCode);

        if (data.getString("CHANGE_YN").equals("1") != true) return;

        docBiz.init(refId);
        docBiz.setEvent("OFFICE_CODE_CHANGE");
        docBiz.setValue("PAPER_REF_NO", data.getString("PAPER_REF_NO"));
        docBiz.setValue("COMMENTS", data.getString("COMMENTS"));
        docBiz.create();
    }

    /**
     * 마스터 사무소담당자 변경시 진행서류 추가
     *
     * @param refId
     * @param officeJobMan
     * @throws NException
     */
    public void createMasterOfficeJobManChangePaper(String refId, String officeJobMan) throws NException
    {
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        MailBiz mail = new MailBiz(this.nsr);

        // 사무소담당자 변경여부 조회
        NSingleData data = dao.retrieveMasterOfficeJobManChangeInfo(refId, officeJobMan);

        NSingleData mailInfo = new NSingleData();

        if (data.getString("CHANGE_YN").equals("1") != true) return;

        docBiz.init(refId);
        docBiz.setEvent("OFFICE_JOB_MAN_CHANGE");
        docBiz.setValue("PAPER_REF_NO", data.getString("PAPER_REF_NO"));
        docBiz.setValue("COMMENTS", data.getString("COMMENTS"));
        docBiz.create();

     // 사무소담당자 변경 메일 발송
        mailInfo = dao.getRecvInfo(officeJobMan);
        mail.init();
        mailInfo.setString("REMARK", data.getString("COMMENTS"));
        mailInfo.setString("REF_NO", data.getString("REF_NO"));
        mailInfo.setString("KO_APP_TITLE", data.getString("KO_APP_TITLE"));
        mail.template.init("/officejobmanchange/officejobmanchange");
        mail.template.setData(mailInfo);
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.addTo(mailInfo.getString("TO_ADDR"), mailInfo.getString("TO_NAME"));
        mail.create();
    }

    /**
     * 마스터 초록정보 저장
     *
     * @param refId
     * @param abAbstract
     * @param abClaim
     * @throws NException
     */
    public void updateMasterAbstract(String refId, String abAbstract, String abClaim) throws NException
    {
        ApplyMgtCommonDao dao = new ApplyMgtCommonDao(this.nsr);

        if (dao.updateMasterAbstract(refId) == 0) {
            dao.createMasterAbstract(refId);
        }

        dao.updateMasterAbstract(refId, abAbstract, abClaim);
    }
}
