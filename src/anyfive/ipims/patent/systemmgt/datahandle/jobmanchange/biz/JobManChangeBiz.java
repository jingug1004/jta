package anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NTextUtil;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.dao.JobManChangeDao;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class JobManChangeBiz extends NAbstractServletBiz
{
    public JobManChangeBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 건담당자 일괄변경 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveJobManChangeList(AjaxRequest xReq) throws NException
    {
        JobManChangeDao dao = new JobManChangeDao(this.nsr);

        return dao.retrieveJobManChangeList(xReq);
    }

    /**
     * 건담당자 일괄변경 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateJobManChangeList(AjaxRequest xReq) throws NException
    {
        JobManChangeDao dao = new JobManChangeDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        MailBiz mail = new MailBiz(this.nsr);

        NMultiData data = xReq.getMultiData("ds_jobManChangeList");
        NSingleData mailInfo = new NSingleData();

        String jobMan = xReq.getParam("JOB_MAN");
        String refId = null;
        String remark = null;

        for (int i = 0; i < data.getRowSize(); i++) {
            refId = data.getString(i, "REF_ID");
            remark = dao.retrievePaperRemark(refId, jobMan);

            // 출원마스터의 건담당자 변경(비고란에 History 추가)
            dao.updateApplyMaster(refId, jobMan);

            // 해외건의 경우 해외그룹의 건담당자 변경(비고란에 History 추가)
            if (data.getString(i, "INOUT_DIV").equals("EXT")) {
                dao.updateExtGroup(refId, jobMan);
            }

            // 진행서류 생성
            docBiz.init(refId);
            docBiz.setEvent("JOB_MAN_CHANGE");
            docBiz.setValue("REMARK", remark);
            docBiz.create();


            // 건담당자 변경 메일 발송
            mailInfo = dao.getRecvInfo(jobMan);

            mail.init();
            mailInfo.setString("REMARK", remark);
            mailInfo.setString("REF_NO", data.getString(i, "REF_NO"));
            mailInfo.setString("KO_APP_TITLE", data.getString(i, "KO_APP_TITLE"));
            mail.template.init("/jobmanchange/jobmanchange");
            mail.template.setData(mailInfo);
            mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
            mail.addTo(mailInfo.getString("TO_ADDR"), mailInfo.getString("TO_NAME"));
            mail.create();
        }
    }
}
