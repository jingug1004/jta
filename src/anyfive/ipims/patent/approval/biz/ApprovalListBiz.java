package anyfive.ipims.patent.approval.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.approval.dao.ApprovalListDao;

public class ApprovalListBiz extends NAbstractServletBiz
{
    public ApprovalListBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 결재처리함 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalAnsList(AjaxRequest xReq) throws NException
    {
        ApprovalListDao dao = new ApprovalListDao(this.nsr);

        return dao.retrieveApprovalAnsList(xReq);
    }

    /**
     * 결재요청함 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalReqList(AjaxRequest xReq) throws NException
    {
        ApprovalListDao dao = new ApprovalListDao(this.nsr);

        return dao.retrieveApprovalReqList(xReq);
    }

    /**
     * 메일 KEY 로부터 사용자 ID 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveLoginIdByApprovalMailKey(String mailKey) throws NException
    {
        ApprovalListDao dao = new ApprovalListDao(this.nsr);

        return dao.retrieveLoginIdByApprovalMailKey(mailKey);
    }

    /**
     * 결재함 업무화면 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalView(AjaxRequest xReq) throws NException
    {
        ApprovalListDao dao = new ApprovalListDao(this.nsr);

        String apprNo = xReq.getParam("APPR_NO");
        String mailKey = xReq.getParam("MAIL_KEY");

        if (apprNo.equals("") == true && mailKey.equals("") != true) {
            apprNo = dao.retrieveApprNoByApprovalMailKey(mailKey);
            if (apprNo.equals("") == true) {
                throw new NBizException("올바르지 않은 KEY [" + mailKey + "] 입니다.");
            }
        }

        NSingleData apprInfo = dao.retrieveApprovalApprInfo(apprNo);

        if (apprInfo.isEmpty()) {
            throw new NBizException("결재정보를 찾을 수 없습니다.");
        }

        NSingleData result = new NSingleData();

        result.set("ds_apprInfo", apprInfo);
        result.set("ds_apprKeys", dao.retrieveApprovalApprKeys(apprNo, apprInfo));

        return result;
    }
}
