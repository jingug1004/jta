package anyfive.ipims.patent.applymgt.docpaper.docpaperlist.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class DocPaperListDao extends NAbstractServletDao
{
    public DocPaperListDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaperList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/docpaper/docpaperlist", "/retrieveDocPaperList");
        dao.bind(xReq);

        // 사용자의   특허건담당 권한 여부에 따른 검색
        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor");
        }

        // 번호검색
        if (xReq.getParam("NO_GUBUN").equals("") != true && xReq.getParam("SR_NO_TEXT").equals("") != true) {
            if (xReq.getParam("NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("APP_NO")) {
                dao.addQuery("appNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("REG_NO")) {
                dao.addQuery("regNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("NOTICE_NO")) {
                dao.addQuery("noticeNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("OFFICE_REF_NO")) {
                dao.addQuery("officeRefNo");
            }
            if (xReq.getParam("NO_GUBUN").equals("EXT_OFFICE_REF_NO")) {
                dao.addQuery("extOfficeRefNo");
            }
        }

        if (xReq.getParam("SR_NO_ONLY").equals("1") != true) {

            // 국내외구분
            if (xReq.getParam("INOUT_DIV").equals("") != true) {
                dao.addQuery("inoutDiv");
            }

            // 진행서류구분
            if (xReq.getParam("RIGHT_DIV").equals("") != true) {
                dao.addQuery("rightDiv");
            }

            // 사무소
            if (xReq.getParam("OFFICE_CODE").equals("") != true) {
                dao.addQuery("officeCode");
            }

            // 국내진행서류
            if (xReq.getParam("PAPER_CODE").equals("") != true) {
                dao.addQuery("paperCode");
            }

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 입력자구분
            if (xReq.getParam("INPUT_OWNER").equals("") != true) {
                dao.addQuery("inputOwner");
            }

            // 검색일자
            if (xReq.getParam("DATE_GUBUN").equals("") != true) {
                if (xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("dateStart");
                }
                if (xReq.getParam("DATE_END").equals("") != true) {
                    dao.addQuery("dateEnd");
                }
            }

            // 최후입력건조회
            if (xReq.getParam("CHK_LAST").equals("1") == true) {
                dao.addQuery("chkLast");
            }

            // 미확인건
            if (xReq.getParam("CHK_NOREAD").equals("1") == true) {
                dao.addQuery("chkNoRead");
            }
        }

        return dao.executeQueryForGrid(xReq);
    }
}
