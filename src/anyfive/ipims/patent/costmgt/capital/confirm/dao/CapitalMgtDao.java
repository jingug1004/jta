package anyfive.ipims.patent.costmgt.capital.confirm.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CapitalMgtDao extends NAbstractServletDao
{
    public CapitalMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자본적 지출 확정 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        if (xReq.getParam("ASSET_STATUS").equals("0")) {//처리상태
            dao.setQuery("/ipims/patent/costmgt/capital/confirm", "/retrieveCapitalMgtStatusZList");
        }
        if (xReq.getParam("ASSET_STATUS").equals("1")) {//품의상태
            dao.setQuery("/ipims/patent/costmgt/capital/confirm", "/retrieveCapitalMgtStatusOList");
        }

        dao.bind(xReq);

         // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        // 국가구분
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 사무소
        if (xReq.getParam("OFFICE_CODE").equals("") != true) {
            dao.addQuery("officeCode");
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
     * 자본적 지출 확정 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createCapitalMgt(AjaxRequest xReq, NMultiData createList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/capital/confirm", "/createCapitalMgt");
        dao.bind(xReq);

        return dao.executeBatch(createList);
    }

    /**
     * 자본적 지출  확정  취소(삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCapitalMgt(AjaxRequest xReq, NMultiData deleteList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/capital/confirm", "/deleteCapitalMgt");
        dao.bind(xReq);

        dao.executeBatch(deleteList);
    }
}
