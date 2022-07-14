package anyfive.ipims.patent.rivalpat.evalmaster.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class EvalMasterDao extends NAbstractServletDao
{
    public EvalMasterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatEvalMasterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/retrieveRivalPatEvalMasterList");
        dao.bind(xReq);

        // 기술분류코드
        if (xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true) {
            dao.addQuery("techCode");
        }

        // 평가등급
        if (xReq.getParam("EVAL_GRADE").equals("") != true) {
            dao.addQuery("evalGrade");
        }
        // 검토자
        if (xReq.getParam("EVAL_MAN").equals("") != true) {
            dao.addQuery("evalMan");
        }

        String[] keyWordList = xReq.getParam("SEARCH_FIELD").split(",");

        // Keyword 검색
        if (xReq.getParam("KEY_WORD").equals("") != true && keyWordList[0].equals("") != true) {
            dao.addQuery("keyWordSearchStart");
            for (int i = 0; i < keyWordList.length; i++) {
                if (keyWordList[i].equals("US_CLASS")) {
                    dao.addQuery("usClass");
                } else {
                    dao.addQuery("searchKeyWord");
                    dao.replaceText("SEARCH_FIELD", keyWordList[i]);
                }
            }
            dao.addQuery("keyWordSearchEnd");
        }

        // 출원일
        if (xReq.getParam("APP_DATE_START").equals("") != true) {
            dao.addQuery("appDateStart");
        }
        if (xReq.getParam("APP_DATE_END").equals("") != true) {
            dao.addQuery("appDateEnd");
        }
        // 등록일
        if (xReq.getParam("REG_DATE_START").equals("") != true) {
            dao.addQuery("regDateStart");
        }
        if (xReq.getParam("REG_DATE_END").equals("") != true) {
            dao.addQuery("regDateEnd");
        }
        // 우선일
        if (xReq.getParam("PRIORITY_DATE_START").equals("") != true) {
            dao.addQuery("priorityDateStart");
        }
        if (xReq.getParam("PRIORITY_DATE_END").equals("") != true) {
            dao.addQuery("priorityDateEnd");
        }
        // 국제출원일
        if (xReq.getParam("I_APP_DATE_START").equals("") != true) {
            dao.addQuery("iAppDateStart");
        }
        if (xReq.getParam("I_APP_DATE_END").equals("") != true) {
            dao.addQuery("iAppDateEnd");
        }
        // 공개일
        if (xReq.getParam("PUB_DATE_START").equals("") != true) {
            dao.addQuery("pubDateStart");
        }
        if (xReq.getParam("PUB_DATE_END").equals("") != true) {
            dao.addQuery("pubDateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }
    public NSingleData retrieveRivalPatEvalMasterListTech(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/retrieveRivalPatEvalMasterListTech");
        dao.bind(xReq);

        // 기술분류코드
        if (xReq.getParam("TECH_CODE").equals("") != true && xReq.getParam("TECH_CODE").equals("ROOT") != true) {
            dao.addQuery("techCode");
        }

        //IPC분류코드
        if (xReq.getParam("IPC_CODE").equals("") != true && xReq.getParam("IPC_CODE").equals("ROOT") != true) {
            dao.addQuery("ipcCode");
        }else{
            dao.addQuery("ipcCodeAll");
        }

        // 평가등급
        if (xReq.getParam("EVAL_GRADE").equals("") != true) {
            dao.addQuery("evalGrade");
        }
        // 검토자
        if (xReq.getParam("EVAL_MAN").equals("") != true) {
            dao.addQuery("evalMan");
        }

        String[] keyWordList = xReq.getParam("SEARCH_FIELD").split(",");

        // Keyword 검색
        if (xReq.getParam("KEY_WORD").equals("") != true && keyWordList[0].equals("") != true) {
            dao.addQuery("keyWordSearchStart");
            for (int i = 0; i < keyWordList.length; i++) {
                if (keyWordList[i].equals("US_CLASS")) {
                    dao.addQuery("usClass");
                } else {
                    dao.addQuery("searchKeyWord");
                    dao.replaceText("SEARCH_FIELD", keyWordList[i]);
                }
            }
            dao.addQuery("keyWordSearchEnd");
        }

        // 출원일
        if (xReq.getParam("APP_DATE_START").equals("") != true) {
            dao.addQuery("appDateStart");
        }
        if (xReq.getParam("APP_DATE_END").equals("") != true) {
            dao.addQuery("appDateEnd");
        }
        // 등록일
        if (xReq.getParam("REG_DATE_START").equals("") != true) {
            dao.addQuery("regDateStart");
        }
        if (xReq.getParam("REG_DATE_END").equals("") != true) {
            dao.addQuery("regDateEnd");
        }
        // 우선일
        if (xReq.getParam("PRIORITY_DATE_START").equals("") != true) {
            dao.addQuery("priorityDateStart");
        }
        if (xReq.getParam("PRIORITY_DATE_END").equals("") != true) {
            dao.addQuery("priorityDateEnd");
        }
        // 국제출원일
        if (xReq.getParam("I_APP_DATE_START").equals("") != true) {
            dao.addQuery("iAppDateStart");
        }
        if (xReq.getParam("I_APP_DATE_END").equals("") != true) {
            dao.addQuery("iAppDateEnd");
        }
        // 공개일
        if (xReq.getParam("PUB_DATE_START").equals("") != true) {
            dao.addQuery("pubDateStart");
        }
        if (xReq.getParam("PUB_DATE_END").equals("") != true) {
            dao.addQuery("pubDateEnd");
        }

        if (xReq.getParam("GUBUN").equals("E") == true){
            dao.addQuery("EvalCnt");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 평가마스터 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatEvalMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/retrieveRivalPatEvalMaster");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 평가마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRivalPatEvalMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/updateRivalPatEvalMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 평가마스터 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatEvalMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/deleteRivalPatEvalMaster");
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
    public NMultiData retrieveRivalPatTechCodeList(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/retrieveRivalPatTechCodeList");
        dao.bind("MGT_ID", mgtId);

        return dao.executeQuery();
    }

    /**
     * IPC분류코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveRivalPatIpcCodeList(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/retrieveRivalPatIpcCodeList");
        dao.bind("MGT_ID", mgtId);

        return dao.executeQuery();
    }



    /**
     * 기술분류코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createRivalPatTechCode(String mgtId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/createRivalPatTechCode");
        dao.bind("MGT_ID", mgtId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * IPC분류코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createRivalPatIpcCode(String mgtId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/createRivalPatIpcCode");
        dao.bind("MGT_ID", mgtId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 기술분류코드 주분류 설정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRivalPatTechCode(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/updateRivalPatTechCode");
        dao.bind("MGT_ID", mgtId);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 주분류 설정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRivalPatIpcCode(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/updateRivalPatIpcCode");
        dao.bind("MGT_ID", mgtId);

        return dao.executeUpdate();
    }

    /**
     * 기술분류코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] deleteRivalPatTechCode(String mgtId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/deleteRivalPatTechCode");
        dao.bind("MGT_ID", mgtId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 기술분류코드 전체 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatTechCodeAll(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/deleteRivalPatTechCodeAll");
        dao.bind("MGT_ID", mgtId);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 전체 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatIpcCodeAll(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/deleteRivalPatIpcCodeAll");
        dao.bind("MGT_ID", mgtId);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] deleteRivalPatIpcCode(String mgtId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/deleteRivalPatIpcCode");
        dao.bind("MGT_ID", mgtId);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 평가정보 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createRivalPatEvalInfo(NSingleData evalData, String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/createRivalPatEvalInfo");
        dao.bind("MGT_ID", mgtId);
        dao.bind(evalData);

        return dao.executeUpdate();
    }

    /**
     * 평가정보 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRivalPatEvalInfo(NSingleData evalData, String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/updateRivalPatEvalInfo");
        dao.bind("MGT_ID", mgtId);
        dao.bind(evalData);

        return dao.executeUpdate();
    }

    /**
     * 평가정보 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatEvalInfo(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/deleteRivalPatEvalInfo");
        dao.bind("MGT_ID", mgtId);

        return dao.executeUpdate();
    }

    /**
     * 댓글 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveRivalPatEvalReplyList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/retrieveRivalPatEvalReplyList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 댓글 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createRivalPatEvalReply(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/createRivalPatEvalReply");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 댓글 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatEvalReply(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/deleteRivalPatEvalReply");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 댓글 전체 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatEvalReplyAll(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/evalmaster", "/deleteRivalPatEvalReplyAll");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
