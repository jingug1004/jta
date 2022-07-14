package anyfive.ipims.patent.ipbiz.analy.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AnalyDao extends NAbstractServletDao
{
    public AnalyDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 분석자료 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnalyList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/analy", "/retrieveAnalyList");
        dao.bind(xReq);

        // 관리번호
        if (xReq.getParam("MGT_NO").equals("") != true) {
            dao.addQuery("mgtNo");
        }
        // 분석자료명
        if (xReq.getParam("ANALY_NAME").equals("") != true) {
            dao.addQuery("disputeSubject");
        }
        // 관련업체
        if (xReq.getParam("COMPETITOR").equals("") != true) {
            dao.addQuery("competitor");
        }
        // 작성일
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 분석자료 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createAnaly(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/analy", "/createAnaly");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 분석자료 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnaly(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/analy", "/retrieveAnaly");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 분석자료 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAnaly(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/analy", "/updateAnaly");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 분석자료 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteAnaly(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/analy", "/deleteAnaly");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
