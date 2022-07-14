package anyfive.ipims.patent.applymgt.tmark.intconsult.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class TMarkIntConsultDao extends NAbstractServletDao
{
    public TMarkIntConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내출원품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intconsult", "/retrieveTMarkIntConsultList");
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

            // 상표명
            if (xReq.getParam("SR_TMARK_NAME").equals("") != true) {
                dao.addQuery("srTmarkName");
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

            // 사무소
            if (xReq.getParam("SR_FIRM_CODE").equals("") != true) {
                dao.addQuery("firmCode");
            }

            // 건담당자
            if (xReq.getParam("SR_JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 상표국내출원품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intconsult", "/retrieveTMarkIntConsult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 상표국내출원품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkIntConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intconsult", "/updateTMarkIntConsult");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intconsult", "/updateTMarkIntConsultTmark");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
