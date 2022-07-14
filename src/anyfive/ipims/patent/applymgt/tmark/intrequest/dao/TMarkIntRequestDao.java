package anyfive.ipims.patent.applymgt.tmark.intrequest.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class TMarkIntRequestDao extends NAbstractServletDao
{
    public TMarkIntRequestDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내출원의뢰 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntRequestList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intrequest", "/retrieveTMarkIntRequestList");
        dao.bind(xReq);

        // 사용자의 특허건담당 권한 여부에 따른 검색
        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor");
        }

        // REF_NO
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }
        // 상표명
        if (xReq.getParam("SR_TMARK_NAME").equals("") != true) {
            dao.addQuery("srTmarkName");
        }
        // 진행상태
        if (xReq.getParam("STATUS").equals("") != true) {
            dao.addQuery("status");
        }
        // 건담당자 조회
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
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

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 상표국내출원의뢰 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intrequest", "/retrieveTMarkIntRequest");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 상표국내출원의뢰 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTMarkIntRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intrequest", "/createTMarkIntRequest");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intrequest", "/createTMarkIntRequestTmark");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 상표국내출원의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkIntRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intrequest", "/updateTMarkIntRequest");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intrequest", "/updateTMarkIntRequestTmark");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
