package anyfive.ipims.patent.ipbiz.analy.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.otherinfo.biz.OtherInfoMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.patent.ipbiz.analy.dao.AnalyDao;
import anyfive.ipims.patent.ipbiz.history.biz.IpBizHistoryBiz;
import anyfive.ipims.share.common.util.SequenceUtil;

public class AnalyBiz extends NAbstractServletBiz
{
    public AnalyBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 분석자료 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnalyList(AjaxRequest xReq) throws NException
    {
        AnalyDao dao = new AnalyDao(this.nsr);

        return dao.retrieveAnalyList(xReq);
    }

    /**
     * 분석자료 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createAnaly(AjaxRequest xReq) throws NException
    {
        AnalyDao dao = new AnalyDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String analyId = seqUtil.getBizId();
        String mgtNo = seqUtil.getAnalyMgtNo();

        xReq.setUserData("ANALY_ID", analyId);
        xReq.setUserData("MGT_NO", mgtNo);

        // 분석자료 정보
        dao.createAnaly(xReq);

        // OFFENSE - 그룹 REF-NO
        if (xReq.getParam("ANALY_DIV").equals("O")) {
            // 그룹 REF-NO 맵핑목록 저장
            RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
            refBiz.updateRefNoList(analyId, MappingKind.OURINFO, MappingDiv.NONE, xReq.getMultiData("ds_groupRefNoList"));
        }
        // DEFENSE - 상대측정보
        else {
            // 상대측정보 저장
            OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
            otherBiz.updateOtherInfoList(analyId, xReq.getMultiData("ds_otherInfo"));
        }

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        return analyId;
    }

    /**
     * 분석자료 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnaly(AjaxRequest xReq) throws NException
    {
        AnalyDao dao = new AnalyDao(this.nsr);
        NSingleData result = new NSingleData();

        // 분석자료 정보
        NSingleData mainInfo = dao.retrieveAnaly(xReq);
        result.set("ds_mainInfo", mainInfo);

        // OFFENSE - 그룹 REF-NO
        if (mainInfo.getString("ANALY_DIV").equals("O")) {
            // 그룹 REF-NO 맵핑목록 조회
            RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
            result.set("ds_groupRefNoList", refBiz.retrieveRefNoList(xReq.getParam("ANALY_ID"), MappingKind.OURINFO, MappingDiv.NONE));
        }
        // DEFENSE - 대정보
        else {
            // 상대정보 조회
            OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
            result.set("ds_otherInfo", otherBiz.retrieveOtherInfoList(xReq.getParam("ANALY_ID")));
        }

        return result;
    }

    /**
     * 분석자료 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateAnaly(AjaxRequest xReq) throws NException
    {
        AnalyDao dao = new AnalyDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        dao.updateAnaly(xReq);

        // OFFENSE - 그룹 REF-NO
        if (xReq.getParam("ANALY_DIV").equals("O")) {
            // 그룹 REF-NO 맵핑목록 저장
            RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
            refBiz.updateRefNoList(xReq.getParam("ANALY_ID"), MappingKind.OURINFO, MappingDiv.NONE, xReq.getMultiData("ds_groupRefNoList"));
        }
        // DEFENSE - 상대측정보
        else {
            // 상대측정보 저장
            OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
            otherBiz.updateOtherInfoList(xReq.getParam("ANALY_ID"), xReq.getMultiData("ds_otherInfo"));
        }

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }

    /**
     * 분석자료 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAnaly(AjaxRequest xReq) throws NException
    {
        AnalyDao dao = new AnalyDao(this.nsr);

        String analyId = xReq.getParam("ANALY_ID");

        NSingleData mainInfo = dao.retrieveAnaly(xReq);

        // 분석자료 삭제
        dao.deleteAnaly(xReq);

        // OFFENSE - 그룹 REF-NO
        if (xReq.getParam("ANALY_DIV").equals("O")) {
            // 그룹 REF-NO 맵핑목록 삭제
            RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
            refBiz.deleteRefNoListAll(analyId, MappingKind.OURINFO, MappingDiv.NONE);
        }
        // DEFENSE - 상대측정보
        else {
            // 상대측정보 삭제
            OtherInfoMappBiz otherBiz = new OtherInfoMappBiz(this.nsr);
            otherBiz.deleteOtherInfoListAll(analyId);
        }

        // History 전체삭제
        IpBizHistoryBiz histBiz = new IpBizHistoryBiz(this.nsr);
        histBiz.deleteIpBizHistoryAll(analyId);

        // 첨부파일 삭제
        FileBiz fileBiz = new FileBiz(this.nsr);
        fileBiz.deleteFileList(mainInfo.getString("ATTACH_FILE"));
    }
}
