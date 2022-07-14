package anyfive.ipims.patent.applymgt.council.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.applymgt.council.dao.CouncilDao;
import anyfive.ipims.patent.common.mapping.council.biz.CouncilMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;

public class CouncilBiz extends NAbstractServletBiz
{
    public CouncilBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 심의현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCouncilRequestListR(AjaxRequest xReq) throws NException
    {
        CouncilDao dao = new CouncilDao(this.nsr);

        return dao.retrieveCouncilRequestListR(xReq);
    }

    /**
     * 심의요청서 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createCouncilRequest(AjaxRequest xReq) throws NException
    {
        CouncilDao dao = new CouncilDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // REF_ID 시퀀스 생성
        String refId = seqUtil.getBizId();
        String mgtNo = seqUtil.getMetNo();

        xReq.setUserData("MGT_ID", refId);
        xReq.setUserData("MGT_NO", mgtNo);

        // 심의요청서 작성
        dao.createCouncilRequest(xReq);

        // 심의대상 맵핑목록 저장
        CouncilMappBiz mappBiz = new CouncilMappBiz(this.nsr);
        mappBiz.updateMgtIdList(refId, xReq.getMultiData("ds_mgtId"));

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 심의위원 맵핑목록 저장
        mappBiz.updateReviewMemberList(refId, xReq.getMultiData("ds_reviewMember"));

        return refId;
    }

    /**
     * 심의요청서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCouncilRequestRD(AjaxRequest xReq) throws NException
    {
        CouncilDao dao = new CouncilDao(this.nsr);

        String mgtId = xReq.getParam("MGT_ID");

        NSingleData result = new NSingleData();

        // 심의요청서 조회
        result.set("ds_mainInfo", dao.retrieveCouncilRequestRD(xReq));

        CouncilMappBiz mappBiz = new CouncilMappBiz(this.nsr);

        // 심의대상 맵핑목록 조회
        result.set("ds_mgtId", mappBiz.retrieveMgtIdList(mgtId));

        // 심의위원 맵핑목록 조회
        result.set("ds_reviewMember", mappBiz.retrieveReviewMemberListEvl(mgtId));

        return result;
    }

    /**
     * 심의요청서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateCouncilRequestRD(AjaxRequest xReq) throws NException
    {
        CouncilDao dao = new CouncilDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String mgtId = xReq.getParam("MGT_ID");

        // 심의요청서 작성
        dao.updateCouncilRequestRD(xReq);

        // 심의대상 맵핑목록 저장
        CouncilMappBiz mappBiz = new CouncilMappBiz(this.nsr);
        mappBiz.updateMgtIdList(mgtId, xReq.getMultiData("ds_mgtId"));

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 심의위원 맵핑목록 저장
        mappBiz.updateReviewMemberList(mgtId, xReq.getMultiData("ds_reviewMember"));

        return mgtId;
    }

    /**
     * 심의요청서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCouncilRequest(AjaxRequest xReq) throws NException
    {
        CouncilDao dao = new CouncilDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String mgtId = xReq.getParam("MGT_ID");

        int cnt = dao.deleteCouncilRequest(xReq);

        // 심의대상 맵핑목록 삭제
        CouncilMappBiz mappBiz = new CouncilMappBiz(this.nsr);
        mappBiz.deleteAllMgtIdList(mgtId, xReq.getMultiData("ds_mgtId"));

        // 첨부파일 삭제
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 심의위원 맵핑목록 삭제
        mappBiz.deleteAllReviewMemberList(mgtId, xReq.getMultiData("ds_reviewMember"));

        if (cnt == 0) {
            throw new NBizException("심의요청서를 삭제할 수 없습니다.");
        }
    }

    /**
     * 심의요청완료
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void UpdateCouncilRequestEmail(AjaxRequest xReq) throws NException
    {
        CouncilDao dao = new CouncilDao(this.nsr);

        MailBiz mail = new MailBiz(this.nsr);
        mail.init();
        NSingleData courseInfo = dao.retrieveCouncilRequest(xReq);
        NSingleData mailInfo = new NSingleData();
        StringBuffer strB = new StringBuffer();
        NMultiData stuList = dao.retrieveCouncilRequestList(xReq);

        mail = new MailBiz(this.nsr);
        mail.init();
        mail.setSubject("\"" + courseInfo.getString("REQ_SUBJECT") + "\" 심의요청드립니다.");
        mailInfo.setString("EMP_HNAME", SessionUtil.getUserInfo(this.nsr).getEmpHname());
        mailInfo.setString("REQ_SUBJECT", courseInfo.getString("REQ_SUBJECT"));
        mailInfo.setString("START_DATE", courseInfo.getString("START_DATE"));
        mailInfo.setString("END_DATE", courseInfo.getString("END_DATE"));

        mailInfo.setString("stuList", strB.toString());
        mail.template.init("/council/review");
        mail.template.setData(mailInfo);

        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        for (int i = 0; i < stuList.getRowSize(); i++) {
            mail.addTo(stuList.getString(i, "MAIL_ADDR"), stuList.getString(i, "EMP_HNAME"));
        }
        mail.create();

        // 심의상태 '1' 로 수정. 단 심의요청일경우
        if (xReq.getParam("STATUS").equals("1")) {
            dao.updateCouncilRequestST(xReq);
        }

        return;
    }
}
