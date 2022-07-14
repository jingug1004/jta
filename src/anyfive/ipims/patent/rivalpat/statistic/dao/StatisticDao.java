package anyfive.ipims.patent.rivalpat.statistic.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class StatisticDao extends NAbstractServletDao
{
    public StatisticDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 등급별 통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatGradeStatisticList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/statistic", "/retrieveRivalPatGradeStatisticList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 기술분류별 통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatTechStatisticList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/statistic", "/retrieveRivalPatTechStatisticList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 기술분류별 총건수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatTechStatisticListPop(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/statistic", "/retrieveRivalPatTechStatisticListPop");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * IPC분류별 통계 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatIpcStatisticList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/statistic", "/retrieveRivalPatIpcStatisticList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 정량맵
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveRivalPatQuantityMap(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);
        String listType = xReq.getParam("LIST_TYPE");

        dao.setQuery("/ipims/patent/rivalpat/statistic", "/retrieveRivalPatQuantityMap_" + listType);
        dao.bind(xReq);

        //01-제품별건수
        if(listType.equals("01") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }
        //02-출원인별 제품별 건수
        else if(listType.equals("02") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            dao.addQuery("bottomQuery");
        }
        //03-출원인별건수
        else if(listType.equals("03") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            dao.addQuery("middleQuery");
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank");
            }
        }
        //04-출원인별 연도별
        else if(listType.equals("04") == true){
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank");
            }
            dao.addQuery("middleQuery");
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            if(xReq.getParam("SEARCH_YEAR").equals("") != true){
                dao.addQuery("searchYear");
            }
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            dao.addQuery("bottomQuery");
        }
        //05-연도별
        else if(listType.equals("05") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }
        //06-제품별 연도별
        else if(listType.equals("06") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }
        //07-제품별 등급별
        else if(listType.equals("07") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("middleQuery");
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
        }
        //08-등급별
        else if(listType.equals("08") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            dao.addQuery("bottomQuery");
        }
        //09-하위레벨별
        else if(listType.equals("09") == true){
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode01");
                dao.addQuery("middleQuery01");
                dao.addQuery("techCode02");
            } else {
                dao.addQuery("middleQuery01");
            }
            dao.addQuery("middleQuery02");
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");

        }
        //10-국가별 제품별
        else if(listType.equals("10") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            dao.addQuery("bottomQuery");
        }
        //11-제품별 국가별
        else if(listType.equals("11") == true){
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            dao.addQuery("bottomQuery");
        }
        //12-출원인별 국가별
        else if(listType.equals("12") == true){
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank01");
                dao.addQuery("middleQuery");
                dao.addQuery("searchRank02");
            } else {
                dao.addQuery("middleQuery");
            }
            dao.addQuery("bottomQuery");
        }
        //13-국가별 등급별
        else if(listType.equals("13") == true){
        }
        //14-제품별 출원인별
        else if(listType.equals("14") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            dao.addQuery("middleQuery");
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank");
            }
            dao.addQuery("bottomQuery");
        }
        //15-출원인별 등급별
        else if(listType.equals("15") == true){
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank01");
            }
            dao.addQuery("middleQuery01");
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            dao.addQuery("middleQuery02");
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank02");
            }
            dao.addQuery("middleQuery03");
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }
        else if(listType.equals("16") == true){
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }

        return dao.executeQuery();
    }

    /**
     * 정량맵 - 엑셀다운로드
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData quantityExcelDownload(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);
        String listType = xReq.getParam("LIST_TYPE");

        dao.setQuery("/ipims/patent/rivalpat/statistic", "/retrieveRivalPatQuantityMap_" + listType);
        dao.bind(xReq);

      //01-제품별건수
        if(listType.equals("01") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }
        //02-출원인별 제품별 건수
        else if(listType.equals("02") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            dao.addQuery("bottomQuery");
        }
        //03-출원인별건수
        else if(listType.equals("03") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            dao.addQuery("middleQuery");
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank");
            }
        }
        //04-출원인별 연도별
        else if(listType.equals("04") == true){
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank");
            }
            dao.addQuery("middleQuery");
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            if(xReq.getParam("SEARCH_YEAR").equals("") != true){
                dao.addQuery("searchYear");
            }
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            dao.addQuery("bottomQuery");
        }
        //05-연도별
        else if(listType.equals("05") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }
        //06-제품별 연도별
        else if(listType.equals("06") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }
        //07-제품별 등급별
        else if(listType.equals("07") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("middleQuery");
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
        }
        //08-등급별
        else if(listType.equals("08") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            dao.addQuery("bottomQuery");
        }
        //09-하위레벨별
        else if(listType.equals("09") == true){
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode01");
                dao.addQuery("middleQuery01");
                dao.addQuery("techCode02");
            } else {
                dao.addQuery("middleQuery01");
            }
            dao.addQuery("middleQuery02");
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");

        }
        //10-국가별 제품별
        else if(listType.equals("10") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            dao.addQuery("bottomQuery");
        }
        //11-제품별 국가별
        else if(listType.equals("11") == true){
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            dao.addQuery("bottomQuery");
        }
        //12-출원인별 국가별
        else if(listType.equals("12") == true){
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank01");
                dao.addQuery("middleQuery");
                dao.addQuery("searchRank02");
            } else {
                dao.addQuery("middleQuery");
            }
            dao.addQuery("bottomQuery");
        }
        //13-국가별 등급별
        else if(listType.equals("13") == true){
        }
        //14-제품별 출원인별
        else if(listType.equals("14") == true){
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            dao.addQuery("middleQuery");
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank");
            }
            dao.addQuery("bottomQuery");
        }
        //15-출원인별 등급별
        else if(listType.equals("15") == true){
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank01");
            }
            dao.addQuery("middleQuery01");
            if(xReq.getParam("COUNTRY_CODE").equals("") != true){
                dao.addQuery("countryCode");
            }
            if(xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true){
                dao.addQuery("techCode");
            }
            dao.addQuery("middleQuery02");
            if(xReq.getParam("SEARCH_RANK").equals("") != true){
                dao.addQuery("searchRank02");
            }
            dao.addQuery("middleQuery03");
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }
        else if(listType.equals("16") == true){
            if(xReq.getParam("OWN_APP_MAN").equals("") != true){
                dao.addQuery("ownAppMan");
            }
            dao.addQuery("bottomQuery");
        }


        return dao.executeQueryForGrid(xReq);
    }
}
