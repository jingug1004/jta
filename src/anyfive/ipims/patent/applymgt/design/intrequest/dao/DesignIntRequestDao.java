package anyfive.ipims.patent.applymgt.design.intrequest.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class DesignIntRequestDao extends NAbstractServletDao
{
    public DesignIntRequestDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인국내출원의뢰 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntRequestList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intrequest", "/retrieveDesignIntRequestList");
        dao.bind(xReq);

        // 사용자의 특허건담당 권한 여부에 따른 검색
        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor");
        }

        // REF_NO
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
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

        // 진행상태
        if (xReq.getParam("STATUS").equals("") != true) {
            dao.addQuery("status");
        }

        // 건담당자 조회
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 디자인국내출원의뢰 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intrequest", "/retrieveDesignIntRequest");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 디자인국내출원의뢰 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createDesignIntRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intrequest", "/createDesignIntRequest");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intrequest", "/createDesignIntRequestDesign");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 디자인국내출원의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDesignIntRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intrequest", "/updateDesignIntRequest");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intrequest", "/updateDesignIntRequestDesign");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 디자인국내출원의뢰 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteDesignIntRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intrequest", "/deleteDesignIntRequestDesign");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intrequest", "/deleteDesignIntRequest");
        dao.bind(xReq);
        dao.executeUpdate();
    }
}
