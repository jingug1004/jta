package anyfive.ipims.patent.applymgt.council.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CouncilDao extends NAbstractServletDao
{
    public CouncilDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 심의현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCouncilRequestListR(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/council", "/retrieveCouncilRequestListR");
        dao.bind(xReq);


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
     * 심의요청서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createCouncilRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);
        dao.setQuery("/ipims/patent/applymgt/council/council", "/createCouncilRequest");
        dao.bind(xReq);
        dao.executeUpdate();

    }

    /**
     * 심의요청서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCouncilRequestRD(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/council", "/retrieveCouncilRequestRD");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 심의요청서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCouncilRequestRD(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/council", "/updateCouncilRequestRD");
        dao.bind(xReq);
        dao.executeUpdate();

    }

    /**
     * 심의요청서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteCouncilRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/council", "/deleteCouncilRequest");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 심의요청EMAIL 상세정보조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCouncilRequest(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/council", "/retrieveCouncilRequest");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 심의요청EMAIL 제목조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveCouncilRequestList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/council/council", "/retrieveCouncilRequestList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 심의요청 MAIL 발송후 상태 변경
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCouncilRequestST(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);
        dao.setQuery("/ipims/patent/applymgt/council/council", "/updateCouncilRequestST");
        dao.bind(xReq);
        return dao.executeUpdate();
    }


}
