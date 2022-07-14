package anyfive.ipims.patent.ipbiz.expopin.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExpOpinionDao extends NAbstractServletDao
{
    public ExpOpinionDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 감정서 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExpOpinionList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/expopin", "/retrieveExpOpinionList");
        dao.bind(xReq);

        //관리번호
        if (xReq.getParam("MGT_NO").equals("") != true) {
            dao.addQuery("searchMgtNo");
        }
        //감정의 분류
        if (xReq.getParam("EXPOPIN_CLS").equals("") != true) {
            dao.addQuery("searchExpopinCls");
        }
        //국가
        if (xReq.getParam("COUNTRY_CODE").equals("") != true) {
            dao.addQuery("searchCountryCode");
        }
        //권리 구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("searchRightDiv");
        }
        // 검색일자(검정일,작성일)
        if (xReq.getParam("SEARCH_DATE").equals("") != true) {
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
     * 감정서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExpOpinion(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/expopin", "/createExpOpinion");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 감정서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExpOpinion(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/expopin", "/retrieveExpOpinion");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 감정서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExpOpinion(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/expopin", "/updateExpOpinion");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 감정서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteExpOpinion(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/expopin", "/deleteExpOpinion");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

}
