package anyfive.ipims.patent.applymgt.tmark.intmaster.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class TMarkIntMasterDao extends NAbstractServletDao
{
    public TMarkIntMasterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내출원마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntMasterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/retrieveTMarkIntMasterList");
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
                dao.addQuery("regNo");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("INVENTOR")) {
                dao.addQuery("empNo");
            }
        }
        if(xReq.getParam("SR_NO_ONLY").equals("1") != true){

            // 상표명
            if (xReq.getParam("SR_TMARK_NAME").equals("") != true) {
                dao.addQuery("srTmarkName");
            }

            // 건담당자
            if (xReq.getParam("SR_JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
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
     * 상표국내출원마스터 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/retrieveTMarkIntMaster");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 상표국내출원마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkIntMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/updateTMarkIntMaster");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/updateTMarkIntMasterTmark");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/updateTMarkIntConsultTmark");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/updateTMarkIntRequestTmark");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 상표국내출원마스터 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTMarkIntMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/createTMarkIntMaster");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/createTMarkIntMasterInt");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/createTMarkIntConsult");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/createTMarkIntConsultTmark");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/createTMarkIntRequest");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intmaster", "/createTMarkIntRequestTmark");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
