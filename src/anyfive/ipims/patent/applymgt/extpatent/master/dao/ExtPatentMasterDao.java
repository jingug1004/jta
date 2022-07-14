package anyfive.ipims.patent.applymgt.extpatent.master.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class ExtPatentMasterDao extends NAbstractServletDao
{
    public ExtPatentMasterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentMasterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/master", "/retrieveExtPatentMasterList");
        dao.bind(xReq);

        // 사용자의 특허건담당 권한 여부에 따른 검색
        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor");
        }

        // 번호검색
        if (xReq.getParam("OPT_SEL_NO").equals("") != true && xReq.getParam("SEL_NO").equals("") != true) {
            if (xReq.getParam("OPT_SEL_NO").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if (xReq.getParam("OPT_SEL_NO").equals("GRP_NO")) {
                dao.addQuery("grpNo");
            }
            if (xReq.getParam("OPT_SEL_NO").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if (xReq.getParam("OPT_SEL_NO").equals("REG_NO")) {
                dao.addQuery("regNo");
            }
            if (xReq.getParam("OPT_SEL_NO").equals("INT_FIRM_REF")) {
                dao.addQuery("intFirmRef");
            }
            if (xReq.getParam("OPT_SEL_NO").equals("EXT_FIRM_REF")) {
                dao.addQuery("extFirmRef");
            }
            if (xReq.getParam("OPT_SEL_NO").equals("KR_APP")) {
                dao.addQuery("krApp");
            }
            if (xReq.getParam("OPT_SEL_NO").equals("INVENTOR")) {
                dao.addQuery("invName");
            }
            if (xReq.getParam("OPT_SEL_NO").equals("PRE_REF_NO")) {
                dao.addQuery("preRefNo");
            }
        }

        if (xReq.getParam("NO_ONLY").equals("1") != true) {

            // 출원사무소
            if (xReq.getParam("OFFICE_CODE").equals("") != true) {
                dao.addQuery("officeCode");
            }

            // 진행상태
            if (xReq.getParam("STATUS").equals("") != true) {
                dao.addQuery("status");
            }

            // 출원국가
            if (xReq.getParam("COUNTRY_CODE").equals("") != true) {
                dao.addQuery("countryCode");
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

            // 발명의명칭
            if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
                dao.addQuery("koAppTitle");
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 해외출원마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/master", "/retrieveExtPatentMaster");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 해외출원마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtPatentMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/master", "/updateExtPatentMaster");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/extpatent/master", "/updateExtPatentMasterExt");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
