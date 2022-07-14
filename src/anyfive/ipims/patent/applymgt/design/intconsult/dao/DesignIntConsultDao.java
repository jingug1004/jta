package anyfive.ipims.patent.applymgt.design.intconsult.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DesignIntConsultDao extends NAbstractServletDao
{
    public DesignIntConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인국내출원 품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intconsult", "/retrieveDesignIntConsultList");
        dao.bind(xReq);

        //번호검색
        if (xReq.getParam("SR_NO_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("SR_NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("REG_NO")) {
                dao.addQuery("regNO");
            }
        }
        if(xReq.getParam("SR_NO_ONLY").equals("1") != true){

            // 건담당자
            if (xReq.getParam("SR_JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 발명자
            if (xReq.getParam("SR_INV_GUBUN").equals("") != true && xReq.getParam("SR_INV_TEXT").equals("") != true) {
                if (xReq.getParam("SR_INV_GUBUN").equals("EMP_NAME")) {
                    dao.addQuery("empName");
                }
                if(xReq.getParam("SR_INV_GUBUN").equals("EMP_NO")) {
                    dao.addQuery("empNO");
                }
            }

            // 사무소
            if (xReq.getParam("SR_FIRM_CODE").equals("") != true) {
                dao.addQuery("firmCode");
            }

            // 진행상태
            if (xReq.getParam("SR_STATUS").equals("") != true) {
                dao.addQuery("srStatus");
            }

            // 검색일자
            if (xReq.getParam("SR_DATE_CODE").equals("") != true) {
                if (xReq.getParam("SR_SDATE").equals("") != true) {
                    dao.addQuery("dateStart");
                }
                if (xReq.getParam("SR_EDATE").equals("") != true) {
                    dao.addQuery("dateEnd");
                }
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 디자인국내출원 품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intconsult", "/retrieveDesignIntConsult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 디자인국내출원 품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDesignIntConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intconsult", "/updateDesignIntConsult");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intconsult", "/updateDesignIntConsultDesign");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intconsult", "/updateDesignIntReqDesign");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
