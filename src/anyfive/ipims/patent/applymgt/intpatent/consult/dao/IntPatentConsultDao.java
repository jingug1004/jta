package anyfive.ipims.patent.applymgt.intpatent.consult.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class IntPatentConsultDao extends NAbstractServletDao
{
    public IntPatentConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내출원품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/consult", "/retrieveIntPatentConsultList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("NO_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if(xReq.getParam("NO_GUBUN").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if(xReq.getParam("NO_GUBUN").equals("REG_NO")) {
                dao.addQuery("regNO");
            }
        }

        if(xReq.getParam("SR_NO_ONLY").equals("1") != true){

            // 발명의명칭
            if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
                dao.addQuery("koAppTitle");
            }

            // 발명자
            if (xReq.getParam("EMP_GUBUN").equals("") != true && xReq.getParam("SR_INV").equals("") != true) {
                if (xReq.getParam("EMP_GUBUN").equals("EMP_NAME")) {
                    dao.addQuery("empName");
                }
                if(xReq.getParam("EMP_GUBUN").equals("EMP_NO")) {
                    dao.addQuery("empNO");
                }
            }

            // 진행상태
            if (xReq.getParam("SR_STATUS").equals("") != true) {
                dao.addQuery("srStatus");
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

            // 사무소
            if (xReq.getParam("FIRM_CODE").equals("") != true) {
                dao.addQuery("firmCode");
            }

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국내출원품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/consult", "/retrieveIntPatentConsult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내출원품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntPatentConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/consult", "/updateIntPatentConsult");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/intpatent/consult", "/updateIntPatentConsultPat");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
