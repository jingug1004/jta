package anyfive.ipims.patent.applymgt.design.intmaster.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DesignIntMasterDao extends NAbstractServletDao
{
    public DesignIntMasterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인국내출원마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntMasterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/retrieveDesignIntMasterList");
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
     * 디자인국내출원마스터 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/retrieveDesignIntMaster");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 디자인국내출원마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDesignIntMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/updateDesignIntMaster");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/updateDesignIntMasterInt");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/updateDesignIntMasterReqDesign");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/updateDesignIntMasterConsultDesign");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 디자인국내출원마스터 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createDesignIntMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/createDesignIntMaster");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/createDesignIntMasterInt");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/createDesignIntMasterReq");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/createDesignIntMasterReqDesign");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/createDesignIntMasterConsult");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intmaster", "/createDesignIntMasterConsultDesign");
        dao.bind(xReq);
        dao.executeUpdate();

    }

}
