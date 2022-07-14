package anyfive.ipims.patent.rivalpat.analysis.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AnalysisDocDao extends NAbstractServletDao
{
    public AnalysisDocDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 분석자료현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatAnalysisDocList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/retrieveRivalPatAnalysisDocList");
        dao.bind(xReq);


     // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_TYPE").equals("MGT_NO")) {
                dao.addQuery("mgtNo");
            }
            if(xReq.getParam("SEARCH_TYPE").equals("OUR_APPNO")) {
                dao.addQuery("appNo");
            }
            if(xReq.getParam("SEARCH_TYPE").equals("OUR_REGNO")) {
                dao.addQuery("regNo");
            }
            if(xReq.getParam("SEARCH_TYPE").equals("OUR_PUBNO")) {
                dao.addQuery("pubNo");
            }
        }

        //자사정보조회
        if(xReq.getParam("ONLY").equals("1")){
            if(xReq.getParam("SR_NO_ONLY").equals("1") != true){
                // 분석자료명
             // 권리구분
                if (xReq.getParam("OUR_RIGHT").equals("") != true) {
                    dao.addQuery("ourRight");
                }

                if (xReq.getParam("AN_TITLE").equals("") != true) {
                    dao.addQuery("anTitle");
                }
                // 경쟁사명
                if (xReq.getParam("THEM_NAME").equals("") != true) {
                    dao.addQuery("themNm");
                }
                // 출원일자,등록일자,공개일자,작성일
                if (xReq.getParam("DATE_KIND").equals("APPDATE") && xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("appDt");
                }
                if (xReq.getParam("DATE_KIND").equals("REGDATE") && xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("regDt");
                }
                if (xReq.getParam("DATE_KIND").equals("PUBDATE") && xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("pubDt");
                }
                if (xReq.getParam("DATE_KIND").equals("DATE") && xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("creDt");
                }
        //타사정보조회
        }else{
                // 권리구분
                if (xReq.getParam("OUR_RIGHT").equals("") != true) {
                    dao.addQuery("ourRight2");
                }
                // 분석자료명
                if (xReq.getParam("AN_TITLE").equals("") != true) {
                    dao.addQuery("anTitle2");
                }
                // 경쟁사명
                if (xReq.getParam("THEM_NAME").equals("") != true) {
                    dao.addQuery("themNm2");
                }
                // 출원일자,등록일자,공개일자,작성일
                if (xReq.getParam("DATE_KIND").equals("APPDATE") && xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("appDt2");
                }
                if (xReq.getParam("DATE_KIND").equals("REGDATE") && xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("regDt2");
                }
                if (xReq.getParam("DATE_KIND").equals("PUBDATE") && xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("pubDt2");
                }
                if (xReq.getParam("DATE_KIND").equals("DATE") && xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("creDt2");
                }
            }
        }
        return dao.executeQueryForGrid(xReq);
    }


    /**
     * 분석자료현황 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createAnalysisDoc(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/createAnalysisDoc");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 분석자료현황 정보 조회
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public NSingleData retriveAnalysisDocR(String analyId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/retriveAnalysisDocR");
        dao.bind("ANALY_ID", analyId);

        return dao.executeQueryForSingle();
    }

    /**
     * 분석자료현황 정보 삭제
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public int deleteAnalysisDoc(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/deleteAnalysisDoc");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 분석자료현황 정보  수정
     *
     * @param apprNo
     * @return
     * @throws NException
     */
    public int updateAnalysisDoc(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/updateAnalysisDoc");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 기술분류코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveRivalPatTechCodeList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/retrieveRivalPatTechCodeList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }

    /**
     * IPC분류코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveRivalPatIpcCodeList(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/retrieveRivalPatIpcCodeList");
        dao.bind("REF_ID", refId);

        return dao.executeQuery();
    }



    /**
     * 기술분류코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createRivalPatTechCode(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/createRivalPatTechCode");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * IPC분류코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createRivalPatIpcCode(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/createRivalPatIpcCode");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 기술분류코드 주분류 설정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRivalPatTechCode(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/updateRivalPatTechCode");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 주분류 설정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRivalPatIpcCode(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/updateRivalPatIpcCode");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 기술분류코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] deleteRivalPatTechCode(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/deleteRivalPatTechCode");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 기술분류코드 전체 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatTechCodeAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/deleteRivalPatTechCodeAll");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 전체 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatIpcCodeAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/analysis", "/deleteRivalPatIpcCodeAll");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }




}
