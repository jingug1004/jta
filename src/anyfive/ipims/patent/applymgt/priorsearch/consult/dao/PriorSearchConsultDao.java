package anyfive.ipims.patent.applymgt.priorsearch.consult.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PriorSearchConsultDao extends NAbstractServletDao
{
    public PriorSearchConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 조사의뢰품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/consult", "/retrievePriorSearchConsultList");
        dao.bind(xReq);

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
     * 조사의뢰품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/consult", "/retrievePriorSearchConsult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 조사의뢰서 업데이트
     *
     * @param prschId
     * @return
     * @throws NException
     */
    public int updatePriorSearchRequest(String prschId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/consult", "/updatePriorSearchRequest");
        dao.bind("PRSCH_ID", prschId);

        return dao.executeUpdate();
    }

    /**
     * 조사품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPriorSearchConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/consult", "/createPriorSearchConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 선행조사 - 출원 맵핑목록 생성
     *
     * @param refId
     * @param mappDiv
     * @param prschId
     * @return
     * @throws NException
     */
    public int createPriorSearchApplyMapp(String refId, String mappDiv, String prschId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/consult", "/createPriorSearchApplyMapp");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);
        dao.bind("PRSCH_ID", prschId);

        return dao.executeUpdate();
    }

    /**
     * 조사의뢰품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePriorSearchConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/consult", "/updatePriorSearchConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
