package anyfive.ipims.patent.ipbiz.dispute.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DisputeDao extends NAbstractServletDao
{
    public DisputeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 분쟁(소송) 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDisputeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/dispute", "/retrieveDisputeList");
        dao.bind(xReq);

        // 번호
        if (xReq.getParam("SEARCH_TEXT").equals("") != true && xReq.getParam("SEARCH_TYPE").equals("") != true) {
            dao.addQuery("searchNo");
        }
        //분쟁종류
        if (xReq.getParam("DISPUTE_KIND").equals("") != true) {
            dao.addQuery("disputeKind");
        }
        //분쟁제목
        if (xReq.getParam("DISPUTE_SUBJECT").equals("") != true) {
            dao.addQuery("disputeSubject");
        }
        //기타정보
        if (xReq.getParam("OTHER_KIND").equals("") != true && xReq.getParam("OTHER_TEXT").equals("") != true) {
            if(xReq.getParam("OTHER_KIND").equals("OFFICE_CODE")){
                dao.addQuery("otherOfficeText");
            }else if(xReq.getParam("OTHER_KIND").equals("COUNTRY_CODE")){
                dao.addQuery("otherCountryText");
            }else{
                dao.addQuery("otherText");
            }
        }

        // 검색일자(검정일,작성일)
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
     * 분쟁(소송) 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createDispute(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/dispute", "/createDispute");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 분쟁(소송) 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retreiveDispute(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/dispute", "/retrieveDispute");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 분쟁(소송) 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateDispute(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/dispute", "/updateDispute");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 분쟁(소송) 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteDispute(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/dispute", "/deleteDispute");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 분쟁(소송) 사무소송부일 업데이트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateDisputeOfficeSend(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/dispute", "/updateDisputeOfficeSend");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 분쟁/소송 진행서류현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDisputePaperList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/dispute", "/retrieveDisputePaperList");
        dao.bind(xReq);

        // 검색번호
        if (xReq.getParam("NUM_KIND").equals("") != true && xReq.getParam("NUM_TEXT").equals("") != true) {
            dao.addQuery("numText");
        }

        // 상대회사
        if (xReq.getParam("OTHER_NAME").equals("") != true) {
            dao.addQuery("otherName");
        }

        // 국내사무소
        if (xReq.getParam("OFFICE_CODE").equals("") != true) {
            dao.addQuery("officeCode");
        }

        // 진행서류
        if (xReq.getParam("PAPER_CODE").equals("") != true) {
            dao.addQuery("paperCode");
        }

        // 검색일자
        if (xReq.getParam("DATE_KIND").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        // 구분
        if (xReq.getParam("DISPUTE_DIV").equals("") != true) {
            dao.addQuery("disputeDiv");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
