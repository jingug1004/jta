package anyfive.ipims.patent.applymgt.design.extmaster.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DesignExtMasterDao extends NAbstractServletDao
{
    public DesignExtMasterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인해외출원 마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignExtMasterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/extmaster", "/retrieveDesignExtMasterList");
        dao.bind(xReq);

        //번호검색
        if (xReq.getParam("SR_NO_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("SR_NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("APP_NO")) {
                dao.addQuery("appNo");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("REG_NO")) {
                dao.addQuery("regNo");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("INVENTOR")) {
                dao.addQuery("empNo");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("GRP_NO")) {
                dao.addQuery("grpNo");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("INT_FIRM_REF")) {
                dao.addQuery("intFirmRef");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("EXT_FIRM_REF")) {
                dao.addQuery("extFirmRef");
            }
            if(xReq.getParam("SR_NO_GUBUN").equals("KR_APP")) {
                dao.addQuery("krApp");
            }
        }
        if(xReq.getParam("SR_NO_ONLY").equals("1") != true){

            // 출원국가
            if (xReq.getParam("SR_COUNTRY").equals("") != true) {
                dao.addQuery("srCountry");
            }

            // 진행상태
            if (xReq.getParam("SR_STATUS").equals("") != true) {
                dao.addQuery("srStatus");
            }

            // 디자인명
            if (xReq.getParam("SR_TITLE").equals("") != true) {
                dao.addQuery("srTitle");
            }

            // 건담당자
            if (xReq.getParam("SR_JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 사무소
            if (xReq.getParam("SR_FIRM_CODE").equals("") != true) {
                dao.addQuery("firmCode");
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

            // 발명자
            if (xReq.getParam("SR_INV_GUBUN").equals("") != true && xReq.getParam("SR_INV_TEXT").equals("") != true) {
                if (xReq.getParam("SR_INV_GUBUN").equals("EMP_NAME")) {
                    dao.addQuery("empName");
                }
                if(xReq.getParam("SR_INV_GUBUN").equals("EMP_NO")) {
                    dao.addQuery("empNO");
                }
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 디자인해외출원 마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignExtMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/extmaster", "/retrieveDesignExtMaster");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 디자인해외출원 마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDesignIntMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/extmaster", "/updateDesignExtMaster");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/extmaster", "/updateDesignExtMasterExt");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
