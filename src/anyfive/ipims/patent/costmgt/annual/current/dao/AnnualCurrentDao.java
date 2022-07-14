package anyfive.ipims.patent.costmgt.annual.current.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AnnualCurrentDao extends NAbstractServletDao
{
    public AnnualCurrentDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차료 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualCurrentList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/current", "/retrieveAnnualCurrentList");
        dao.bind(xReq);

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 연차료구분
        if (xReq.getParam("ANNUAL_DIV").equals("") != true) {
            dao.addQuery("annualDiv");
        }

        // 번호검색
        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
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

        // 발명의명칭
        if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
            dao.addQuery("koAppTitle");
        }

        // 진행상태
        if (xReq.getParam("STATUS").equals("") != true) {
            dao.addQuery("status");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
