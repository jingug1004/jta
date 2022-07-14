package anyfive.ipims.patent.applymgt.intpatent.master.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class IntPatentMasterDao extends NAbstractServletDao
{
    public IntPatentMasterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내출원마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentMasterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/master", "/retrieveIntPatentMasterList");
        dao.bind(xReq);

        // 사용자의 특허건담당 권한 여부에 따른 검색
        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor");
        }

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_TYPE").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if (xReq.getParam("SEARCH_TYPE").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if (xReq.getParam("SEARCH_TYPE").equals("REG_NO")) {
                dao.addQuery("regNO");
            }
            if (xReq.getParam("SEARCH_TYPE").equals("INVENTOR")) {
                dao.addQuery("searchInventor");
            }
        }

        if (xReq.getParam("SEARCH_NO_ONLY").equals("1") != true) {

            // 사무소
            if (xReq.getParam("OFFICE_CODE").equals("") != true) {
                dao.addQuery("officeCode");
            }

            // 발명의 명칭
            if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
                dao.addQuery("koAppTitle");
            }

            // 진행상태
            if (xReq.getParam("RES_STATUS").equals("") != true) {
                dao.addQuery("resStatus");
            }

            // 권리구분
            if (xReq.getParam("PA_GUBUN").equals("") != true) {
                dao.addQuery("paGubun");
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

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 평가등급
            if (xReq.getParam("CLEVEL").equals("") != true) {
                dao.addQuery("clevel");
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국내출원마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/master", "/retrieveIntPatentMaster");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내출원마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveExtGroupList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/master", "/retrieveExtGroupList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 국내출원마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createIntPatentMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/master", "/createIntPatentMaster");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/intpatent/master", "/createIntPatentMasterInt");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 국내출원마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntPatentMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/master", "/updateIntPatentMaster");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/intpatent/master", "/updateIntPatentMasterInt");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
