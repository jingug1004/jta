package anyfive.ipims.patent.applymgt.council.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class CouncilEvlDao extends NAbstractServletDao
{
    public CouncilEvlDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 심의평가현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCouncilEvlListR(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/retrieveCouncilEvlListR");
        dao.bind(xReq);

            // 사용자의 특허건담당 권한 여부에 따른 검색
            if (SessionUtil.getUserInfo(this.nsr).isMenuGroupUser("PAT") != true) {
                dao.addQuery("inventor");
            }

            // 심의요청번호
            if (xReq.getParam("MGT_ID").equals("") != true) {
                dao.addQuery("mgtId");
            }

            // 심의요청제목
            if (xReq.getParam("REQ_SUBJECT").equals("") != true) {
                dao.addQuery("reqSubJdect");
            }

            // 심의기간
            if (xReq.getParam("DATE_GUBUN").equals("") != true) {
                if (xReq.getParam("START_DATE").equals("") != true) {
                    dao.addQuery("startDate");
                }
                if (xReq.getParam("END_DATE").equals("") != true) {
                    dao.addQuery("endDate");
                }
            }

            // 심의위원
            if (xReq.getParam("REVIEW_MEMBER").equals("") != true) {
                dao.addQuery("reviewMember");
            }


        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 심의평가 임시저장 시 req 테이블 상태 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCouncilEvlRreq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/updateCouncilEvlRreq");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 심의평가 임시저장 시 mamber 테이블 상태 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCouncilEvlMber(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        if(xReq.getParam("STATUS").equals("1")){
            dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/updateCouncilEvlRreq");
            dao.bind(xReq);
            dao.executeUpdate();

            dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/updateCouncilEvlMber");
            dao.bind(xReq);
            dao.executeUpdate();

        }else{
            dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/updateCouncilEvlRreq");
            dao.bind(xReq);
            dao.executeUpdate();

            dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/updateCouncilEvlMber");
            dao.bind(xReq);
            dao.executeUpdate();
        }
    }

    /**
     * 심의평가 후 TB_MAPP_REVIEW_TARAGET에서 REF_ID, REVIEW_GRADE 조회
     *
     * @param xReq
     * @return
     * @throws NException
     *
     */
    public NMultiData retrieveCouncilEvlStsRreq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/retrieveCouncilEvlStsRreq");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 평가완료 클릭시 TB_APP_MST 테이블에 심의등급, 최종등급 UPDATE
     *
     * @param reqId
     * @param consultId
     * @return
     * @throws NException
     */
    public int updateCouncilEvlAmst(String reqId, String reviewGrade) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/updateCouncilEvlAmst");
        dao.bind("REF_ID", reqId);
        dao.bind("REVIEW_GRADE", reviewGrade);

        return dao.executeUpdate();
    }

    /**
     * 평가재요청 EMAIL 상세정보조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCouncilRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/retrieveCouncilRequest");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 평가재요청 EMAIL 제목조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveCouncilRequestReList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/councilEvl", "/retrieveCouncilRequestReList");
        dao.bind(xReq);

        return dao.executeQuery();
    }
}
