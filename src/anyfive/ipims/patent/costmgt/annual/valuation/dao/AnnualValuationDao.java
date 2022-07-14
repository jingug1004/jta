package anyfive.ipims.patent.costmgt.annual.valuation.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AnnualValuationDao extends NAbstractServletDao
{
    public AnnualValuationDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 등록유지평가 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualValuationList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/retrieveAnnualValuationList");
        dao.bind(xReq);

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 연차료구분
        if (xReq.getParam("ANNUAL_DIV").equals("") != true) {
            dao.addQuery("annualDiv");
        }

        // 발명의명칭
        if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
            dao.addQuery("koAppTitle");
        }

        // 평가상태
        if (xReq.getParam("STATUS").equals("") != true) {
            dao.addQuery("status");
        }

        // 검색번호
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
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

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 발명부서 평가자 목록 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualValuationInvUserSearchList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        // 전체 발명자 여부에 따른 쿼리 설정
        if (xReq.getParam("SEARCH_ALL").equals("1") != true) {
            dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/retrieveAnnualValuationInvUserSearchList");
        } else {
            dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/retrieveAnnualValuationInvUserSearchAllList");
        }

        dao.bind(xReq);

        // 검색어
        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 등록유지평가 마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveValuationMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/retrieveValuationMaster");
        dao.bind(xReq);

        if (xReq.getParam("EVAL_ID").equals("") == true) {
            dao.addQuery("refId");
        } else {
            dao.addQuery("evalId");
        }

        // 납부년차 시퀀스가 있는 경우
        if (xReq.getParam("PAPER_LIST_SEQ").equals("") != true) {
            dao.addQuery("paperListSeq");
        }

        return dao.executeQueryForSingle();
    }

    /**
     * 등록유지평가 결과서 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NSingleData retrieveValuationResult(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/retrieveValuationResult");
        dao.bind("REF_ID", refId);

        return dao.executeQueryForSingle();
    }

    /**
     * 발명부서 평가자 지정
     *
     * @param evalId
     * @param data
     * @return
     * @throws NException
     */
    public int createAnnualValuationInvUser(String evalId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/createAnnualValuationInvUser");
        dao.bind("EVAL_ID", evalId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 평가자 정보
     *
     * @param evalId
     * @param data
     * @return
     * @throws NException
     */
    public NSingleData InvUserInfo(NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/InvUserInfo");
        dao.bind(data);

        return dao.executeQueryForSingle();
    }

    /**
     * 평가자 정보
     *
     * @param evalId
     * @param data
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualValuationInfo(String evalId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/retrieveAnnualValuationInfo");
        dao.bind("EVAL_ID" , evalId );

        return dao.executeQueryForSingle();
    }

    /**
     * 리마인더에 평가ID 저장
     *
     * @param evalId
     * @param data
     * @return
     * @throws NException
     */
    public int updateAnnualReminderEvalID(String evalId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/updateAnnualReminderEvalID");
        dao.bind("EVAL_ID", evalId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 리마인더에 평가결과(유지여부) 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAnnualReminderKeepYn(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/updateAnnualReminderKeepYn");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 지적재산팀 일괄평가 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAnnualValuationList(NSingleData data, String keepYn, String evalId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/updateAnnualValuationKeepYn");
        dao.bind("KEEP_YN", keepYn);
        dao.bind("EVAL_ID", evalId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 지적재산팀 일괄평가 시 - 평가마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createEvaluationMasterPat(NSingleData data, String evalId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/valuation", "/createEvaluationMasterPat");
        dao.bind("EVAL_ID", evalId);
        dao.bind("EVAL_CODE", "E03");
        dao.bind(data);

        return dao.executeUpdate();
    }
}
