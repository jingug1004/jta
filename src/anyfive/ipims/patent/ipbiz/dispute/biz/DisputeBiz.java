package anyfive.ipims.patent.ipbiz.dispute.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.ipbanaly.biz.IpbAnalyMappBiz;
import anyfive.ipims.patent.common.mapping.otherinfo.biz.OtherInfoMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.patent.ipbiz.dispute.dao.DisputeDao;
import anyfive.ipims.patent.ipbiz.history.biz.IpBizHistoryBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class DisputeBiz extends NAbstractServletBiz
{
    public DisputeBiz(NServiceResource nsr)
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
        DisputeDao dao = new DisputeDao(this.nsr);

        return dao.retrieveDisputeList(xReq);
    }

    /**
     * 분쟁(소송) 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createDispute(AjaxRequest xReq) throws NException
    {
        DisputeDao dao = new DisputeDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String disputeId = seqUtil.getBizId();
        String mgtNo = seqUtil.getDisputeMgtNo();

        xReq.setUserData("DISPUTE_ID", disputeId);
        xReq.setUserData("MGT_NO", mgtNo);

        // 분쟁(소송)정보 저장
        dao.createDispute(xReq);

        // 분석자료 맵핑목록 저장
        IpbAnalyMappBiz analyBiz = new IpbAnalyMappBiz(this.nsr);
        analyBiz.updateIpbAnalyList(disputeId, xReq.getMultiData("ds_analyList"));

        // 그룹 REF-NO 맵핑목록 저장
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        refBiz.updateRefNoList(disputeId, MappingKind.OURINFO, MappingDiv.NONE, xReq.getMultiData("ds_groupRefNoList"));

        // 상대측정보 저장
        OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
        otherBiz.updateOtherInfoList(disputeId, xReq.getMultiData("ds_otherInfo"));

        return disputeId;
    }

    /**
     * 분쟁(소송) 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDispute(AjaxRequest xReq) throws NException
    {
        DisputeDao dao = new DisputeDao(this.nsr);
        NSingleData result = new NSingleData();

        String disputeId = xReq.getParam("DISPUTE_ID");

        // 분쟁(소송) 정보 조회
        NSingleData mainInfo =  dao.retreiveDispute(xReq);
        result.set("ds_mainInfo", mainInfo);

        // 분석자료 맵핑목록 조회
        IpbAnalyMappBiz analyBiz = new IpbAnalyMappBiz(this.nsr);
        result.set("ds_analyList", analyBiz.retrieveIpbAnalyList(disputeId));

        // 그룹 REF-NO 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_groupRefNoList", refBiz.retrieveRefNoList(disputeId, MappingKind.OURINFO, MappingDiv.NONE));

        // 상대정보 조회
        OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
        result.set("ds_otherInfo", otherBiz.retrieveOtherInfoList(disputeId));

        return result;
    }

    /**
     * 분쟁(소송) 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDispute(AjaxRequest xReq) throws NException
    {
        DisputeDao dao = new DisputeDao(this.nsr);

        String disputeId = xReq.getParam("DISPUTE_ID");

        dao.updateDispute(xReq);

        // 분석자료 맵핑목록 저장
        IpbAnalyMappBiz analyBiz = new IpbAnalyMappBiz(this.nsr);
        analyBiz.updateIpbAnalyList(disputeId, xReq.getMultiData("ds_analyList"));

        // 그룹 REF-NO 맵핑목록 저장
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        refBiz.updateRefNoList(disputeId, MappingKind.OURINFO, MappingDiv.NONE, xReq.getMultiData("ds_groupRefNoList"));

        // 상대측정보 저장
        OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
        otherBiz.updateOtherInfoList(disputeId, xReq.getMultiData("ds_otherInfo"));

    }

    /**
     * 분쟁(소송) 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteDispute(AjaxRequest xReq) throws NException
    {
        DisputeDao dao = new DisputeDao(this.nsr);

        String disputeId = xReq.getParam("DISPUTE_ID");

        // 분석자료 맵핑목록삭제
        IpbAnalyMappBiz analyBiz = new IpbAnalyMappBiz(this.nsr);
        analyBiz.deleteIpbAnalyListAll(disputeId);


        //OFFENSE - 그룹 REF-NO
        if (xReq.getParam("DISPUTE_DIV").equals("O")){
            // 그룹 REF-NO 맵핑목록 삭제
            RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
            refBiz.deleteRefNoListAll(disputeId, MappingKind.OURINFO, MappingDiv.NONE);
        }
        //DEFENSE - 상대측정보
        else {
            // 상대측정보 삭제
            OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
            otherBiz.deleteOtherInfoListAll(disputeId);
        }

        // History 전체삭제
        IpBizHistoryBiz histBiz = new IpBizHistoryBiz(this.nsr);
        histBiz.deleteIpBizHistoryAll(disputeId);

        // 분쟁(소송) 삭제
        dao.deleteDispute(xReq);
    }

    /**
     * 분쟁(소송) 사무소송부
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDisputeOfficeSend(AjaxRequest xReq) throws NException
    {
        DisputeDao dao = new DisputeDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // 사무소송부일 업데이트
        dao.updateDisputeOfficeSend(xReq);

        // 진행서류 생성
        docBiz.init(xReq.getParam("DISPUTE_ID"));
        docBiz.setEvent("OFFICE_REQUEST");
        docBiz.create();
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
        DisputeDao dao = new DisputeDao(this.nsr);

        return dao.retrieveDisputePaperList(xReq);
    }
}
