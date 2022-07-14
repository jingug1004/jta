package anyfive.ipims.patent.applymgt.priorsearch.request.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class PriorSearchRequestDao extends NAbstractServletDao
{
    public PriorSearchRequestDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 조사의뢰 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchRequestList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/request", "/retrievePriorSearchRequestList");
        dao.bind(xReq);

        // 발명자는 자기가 의뢰한 건만 조회
        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor");
        }

        // 검색어
        if (xReq.getParam("SEARCH_KIND").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_KIND").equals("1")) {
                dao.addQuery("reqUser");
            } else {
                dao.addQuery("jobMan");
            }
        }

        // 의뢰번호
        if (xReq.getParam("PRSCH_NO").equals("") != true) {
            dao.addQuery("prschNo");
        }

        // 의뢰제목
        if (xReq.getParam("PRSCH_SUBJECT").equals("") != true) {
            dao.addQuery("prschSubject");
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
        if (xReq.getParam("BIZ_STATUS").equals("") != true) {
            dao.addQuery("bizStatus");
        }

        // 조사구분
        if (xReq.getParam("PRSCH_DIV").equals("") != true) {
            dao.addQuery("prschDiv");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 조사의뢰 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/request", "/retrievePriorSearchRequest");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 조사의뢰 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPriorSearchRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/request", "/createPriorSearchRequest");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 조사의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePriorSearchRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/request", "/updatePriorSearchRequest");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
