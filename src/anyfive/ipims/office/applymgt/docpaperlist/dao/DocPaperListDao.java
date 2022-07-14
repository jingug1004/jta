package anyfive.ipims.office.applymgt.docpaperlist.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DocPaperListDao extends NAbstractServletDao
{
    public DocPaperListDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 신규요청현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRecentDocPaperList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/applymgt/docpaperlist", "/retrieveRecentDocPaperList");
        dao.bind(xReq);

        // REF-NO
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }

        // 국내외구분
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        return dao.executeQueryForGrid(xReq);
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

        dao.setQuery("/ipims/office/applymgt/docpaperlist", "/retrieveDocPaperList");
        dao.bind(xReq);

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

            // 권리구분
            if (xReq.getParam("RIGHT_DIV").equals("") != true) {
                dao.addQuery("rightDiv");
            }

            // 사무소담당자
            if (xReq.getParam("OFFICE_JOB_MAN").equals("") != true) {
                dao.addQuery("officeJobMan");
            }

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 진행서류
            if (xReq.getParam("PAPER_CODE").equals("") != true) {
                dao.addQuery("paperCode");
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
                dao.replaceText("DATE_GUBUN", xReq.getParam("DATE_GUBUN"));
            }

            // 최후입력건조회
            if (xReq.getParam("CHK_LAST").equals("1") == true) {
                dao.addQuery("chkLast");

                // 검색일자
                if (xReq.getParam("DATE_GUBUN").equals("") != true) {
                    if (xReq.getParam("DATE_START").equals("") != true) {
                        dao.addQuery("dateStart", "chkLastDateQuery");
                    }
                    if (xReq.getParam("DATE_END").equals("") != true) {
                        dao.addQuery("dateEnd", "chkLastDateQuery");
                    }
                    dao.replaceText("DATE_GUBUN", xReq.getParam("DATE_GUBUN").replaceFirst("A.", "X."));
                }
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 분쟁/소송 진행서류현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDisputePaperList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/office/applymgt/docpaperlist", "/retrieveDisputePaperList");
        dao.bind(xReq);

        // 검색번호
        if (xReq.getParam("NUM_KIND").equals("") != true && xReq.getParam("NUM_TEXT").equals("") != true) {
            dao.addQuery("numText");
        }

        // 상대회사
        if (xReq.getParam("OTHER_NAME").equals("") != true) {
            dao.addQuery("otherName");
        }

        // 진행서류
        if (xReq.getParam("PAPER_CODE").equals("") != true) {
            dao.addQuery("paperCode");
        }

        // 검색일자
        if (xReq.getParam("DATE_KIND").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        // 구분
        if (xReq.getParam("DISPUTE_DIV").equals("") != true) {
            dao.addQuery("disputeDiv");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
