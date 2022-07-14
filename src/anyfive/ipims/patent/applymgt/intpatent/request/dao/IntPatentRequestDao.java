package anyfive.ipims.patent.applymgt.intpatent.request.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class IntPatentRequestDao extends NAbstractServletDao
{
    public IntPatentRequestDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내특허 출원의뢰 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentRequestList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/request", "/retrieveIntPatentRequestList");
        dao.bind(xReq);

        // 사용자의 특허건담당 권한 여부에 따른 검색
        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor");
        }

        // REF-NO
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }

        // 발명의명칭
        if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
            dao.addQuery("koAppTitle");
        }

        // 진행상태
        if (xReq.getParam("STATUS").equals("") != true) {
            dao.addQuery("status");
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

        // 초록정보
        if (xReq.getParam("INV_ABSTRACT").equals("") != true) {
            dao.addQuery("invAbstract");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국내특허 출원의뢰 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/request", "/retrieveIntPatentRequest");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 국내특허 출원의뢰 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createIntPatentRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/request", "/createIntPatentRequest");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/intpatent/request", "/createIntPatentRequestPat");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 국내특허 출원의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntPatentRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/request", "/updateIntPatentRequest");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/intpatent/request", "/updateIntPatentRequestPat");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 국내특허 출원의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createPatentConveyChk(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/request", "/createPatentConveyChk");
        dao.bind(xReq);
        dao.executeUpdate();
    }

}
