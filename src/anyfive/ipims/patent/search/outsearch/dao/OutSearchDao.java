package anyfive.ipims.patent.search.outsearch.dao;

import org.w3c.dom.Element;

import any.core.config.NConfig;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NResultSetConverter;
import any.util.etc.NDateUtil;
import any.util.etc.NHttpUtil;
import any.util.etc.NXmlUtil;
import anyfive.framework.ajax.AjaxRequest;

public class OutSearchDao extends NAbstractServletDao
{
    public OutSearchDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * KIPRIS DB 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveKiprisSearchList(AjaxRequest xReq) throws NException
    {
        NHttpUtil http = new NHttpUtil();

        http.init(NConfig.getString("/config/kipris/search-url"), "POST", "euc-kr");
        http.addParam("Query", xReq.getParam("QUERY"));
        http.addParam("currentPage", Integer.toString(xReq.pagingInfo.no));
        http.addParam("docCount", Integer.toString(xReq.pagingInfo.size));
        http.send();

        Element docRoot = NXmlUtil.parse(http.getResponseText()).getDocumentElement();

        String totalCount = NXmlUtil.nodeToSingleData(docRoot.getElementsByTagName("XMLINFO").item(0)).getString("HITS");
        NMultiData searchList = NXmlUtil.nodeListToMultiData(docRoot.getElementsByTagName("XMLLIST"));

        for (int i = 0; i < searchList.getRowSize(); i++) {
            searchList.setString(i, "AD", searchList.getString(i, "AD").replaceFirst(" 00:00:00", "").replaceAll("/", ""));
        }

        return NResultSetConverter.getGridData(searchList, totalCount);
    }

    /**
     * WIPS 로그인
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void loginWips(AjaxRequest xReq) throws NException
    {
        NHttpUtil http = new NHttpUtil();

        http.init(NConfig.getString("/config/wips/login-url"), "POST");
        http.addParam("txtID", NConfig.getString("/config/wips/login-id"));
        http.addParam("txtPassword", NConfig.getString("/config/wips/login-pw"));
        http.send();
    }

    /**
     * WIPS DB 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveWipsSearchList(AjaxRequest xReq) throws NException
    {
        NHttpUtil http = new NHttpUtil();

         http.init(NConfig.getString("/config/wips/login-url"), "POST");
         http.addParam("txtID", NConfig.getString("/config/wips/login-id"));
         http.addParam("txtPassword", NConfig.getString("/config/wips/login-pw"));
         http.send();

         String cookies = http.getResponseCookies();

         http.init(NConfig.getString("/config/wips/search-url"), "POST");
         http.addParam("QUERY", xReq.getParam("QUERY"));
         http.addParam("CC", xReq.getParam("CC"));
         http.addParam("DF", xReq.getParam("DF"));
         http.addParam("PAGENO", "1");
         http.addParam("SORTTYPE", "TI");
         http.addParam("SORTORDER", "0");
         http.addParam("COMPANY", "lscable" + NDateUtil.getSysDate());
         http.setCookies(cookies);
         http.send();

        NMultiData searchList = new NMultiData();

        return NResultSetConverter.getGridData(searchList, "0");
    }
}
