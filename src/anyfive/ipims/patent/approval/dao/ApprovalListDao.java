package anyfive.ipims.patent.approval.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ApprovalListDao extends NAbstractServletDao
{
    public ApprovalListDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/approval/approval", "/retrieveApprovalAnsList");
        dao.bind(xReq);

        if (xReq.getParam("APPR_CODE").equals("") != true) {
            dao.addQuery("apprCode");
        }

        if (xReq.getParam("ANS_STATUS").equals("") != true) {
            dao.addQuery("ansStatus");
        }

        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }

        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/approval/approval", "/retrieveApprovalReqList");
        dao.bind(xReq);

        if (xReq.getParam("APPR_CODE").equals("") != true) {
            dao.addQuery("apprCode");
        }

        if (xReq.getParam("REQ_STATUS").equals("") != true) {
            dao.addQuery("reqStatus");
        }

        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }

        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 메일 KEY 로부터 사용자 ID 조회
     *
     * @param mailKey
     * @return
     * @throws NException
     */
    public String retrieveLoginIdByApprovalMailKey(String mailKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/approval/approval", "/retrieveLoginIdByApprovalMailKey");
        dao.bind("MAIL_KEY", mailKey);

        return dao.executeQueryForString();
    }

    /**
     * 메일 KEY 로부터 결재번호 조회
     *
     * @param mailKey
     * @return
     * @throws NException
     */
    public String retrieveApprNoByApprovalMailKey(String mailKey) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/approval/approval", "/retrieveApprNoByApprovalMailKey");
        dao.bind("MAIL_KEY", mailKey);

        return dao.executeQueryForString();
    }

    /**
     * 결재함 업무화면 정보 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalApprInfo(String apprNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/approval/approval", "/retrieveApprovalApprInfo");
        dao.bind("APPR_NO", apprNo);

        return dao.executeQueryForSingle();
    }

    /**
     * 결재함 APPR_KEYS 조회
     *
     * @param apprNo
     * @param apprInfo
     * @return
     * @throws NException
     */
    public NSingleData retrieveApprovalApprKeys(String apprNo, NSingleData apprInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/approval/approval", "/retrieveApprovalApprKeys");
        dao.bind("APPR_NO", apprNo);

        dao.replaceText("apprPkCols", apprInfo.getString("APPR_PK_COLS"));
        dao.replaceText("apprTable", apprInfo.getString("APPR_TABLE"));
        dao.replaceText("apprNoCol", apprInfo.getString("APPR_NO_COL"));

        return dao.executeQueryForSingle();
    }
}
