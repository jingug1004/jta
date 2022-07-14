package anyfive.ipims.patent.applymgt.intpatent.conveyprint.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class IntPatentConveyPrintDao extends NAbstractServletDao
{
    public IntPatentConveyPrintDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 양도증인쇄 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConveyPrintList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/conveyprint", "/retrieveIntPatentConveyPrintList");
        dao.bind(xReq);

        // 사용자의 특허건담당 권한 여부에 따른 검색
        if (SessionUtil.getUserInfo(this.nsr).isMenuGroupUser("PAT") != true) {
            dao.addQuery("inventor");
        }

        // REF-NO
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }

        if (xReq.getParam("SR_NO_ONLY").equals("1") != true) {

            // 발명의명칭
            if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
                dao.addQuery("koAppTitle");
            }

            // 발명자
            if (xReq.getParam("INV_EMP_GUBUN").equals("") != true && xReq.getParam("SR_INV").equals("") != true) {
                if (xReq.getParam("INV_EMP_GUBUN").equals("EMP_NAME")) {
                    dao.addQuery("empName");
                }
                if (xReq.getParam("INV_EMP_GUBUN").equals("EMP_NO")) {
                    dao.addQuery("empNO");
                }
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
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 양도증인쇄 메인정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConveyPrintMain(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/conveyprint", "/retrieveIntPatentConveyPrintMain");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 양도증인쇄 발명자정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveIntPatentConveyPrintInventor(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/conveyprint", "/retrieveIntPatentConveyPrintInventor");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 양도증인쇄 발명자정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveIntPatentConveyPrintInventorTop(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/conveyprint", "/retrieveIntPatentConveyPrintInventorTop");
        dao.bind(xReq);

        return dao.executeQuery();
    }

}
