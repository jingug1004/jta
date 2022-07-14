package anyfive.ipims.patent.rivalpat.analysis.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.ipbiz.history.biz.IpBizHistoryBiz;
import anyfive.ipims.patent.rivalpat.analysis.dao.AnalysisDocDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class AnalysisDocBiz extends NAbstractServletBiz
{
    public AnalysisDocBiz(NServiceResource nsr)
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
        AnalysisDocDao dao = new AnalysisDocDao(this.nsr);

        return dao.retrieveRivalPatAnalysisDocList(xReq);
    }



    /**
     * 분석자료 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createAnalysisDoc(AjaxRequest xReq) throws NException
    {
        AnalysisDocDao dao = new AnalysisDocDao(this.nsr);

        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = seqUtil.getBizId();
        String mngNo = seqUtil.getAnalyDocNo();

        xReq.setUserData("ANALY_ID", refId);
        xReq.setUserData("MNG_NO", mngNo);

        // 프로그램 생성
        // 기술분류코드 수정
        dao.deleteRivalPatTechCodeAll(refId);
        dao.createRivalPatTechCode(refId, xReq.getMultiData("ds_techCodeList"));
        dao.updateRivalPatTechCode(refId);

        // IPC분류코드 수정
        dao.deleteRivalPatIpcCodeAll(refId);
        dao.createRivalPatIpcCode(refId, xReq.getMultiData("ds_ipcCodeList"));
        dao.updateRivalPatIpcCode(refId);

        dao.createAnalysisDoc(xReq);

        // 관련파일 저장

        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId1"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId2"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId3"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId4"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId5"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId6"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId7"));

        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem1"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem2"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem3"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem4"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem5"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem6"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem7"));

        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));


        return refId;
    }


    /**
     * 분석자료 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retriveAnalysisDocR(AjaxRequest xReq) throws NException
    {
        AnalysisDocDao dao = new AnalysisDocDao(this.nsr);

        String analyId = xReq.getParam("ANALY_ID");

        NSingleData analyInfo = dao.retriveAnalysisDocR(analyId);

        NSingleData result = new NSingleData();

        result.set("ds_analyInfo", analyInfo);

        // 기술분류코드 맵핑목록 조회
        result.set("ds_techCodeList", dao.retrieveRivalPatTechCodeList(analyId));

        // IPC분류코드 맵핑목록 조회
        result.set("ds_ipcCodeList", dao.retrieveRivalPatIpcCodeList(analyId));

        return result;

    }

    /**
     * 분석자료 정보 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAnalysisDoc(AjaxRequest xReq) throws NException
    {
        AnalysisDocDao dao = new AnalysisDocDao(this.nsr);

        String analyId = xReq.getParam("ANALY_ID");

        // History 전체삭제
        IpBizHistoryBiz histBiz = new IpBizHistoryBiz(this.nsr);
        histBiz.deleteIpBizHistoryAll(analyId);

        dao.deleteAnalysisDoc(xReq);
    }
    /**
     * 분석자료 정보 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateAnalysisDoc(AjaxRequest xReq) throws NException
    {
        AnalysisDocDao dao = new AnalysisDocDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String anlyID = xReq.getParam("ANALY_ID");
        //분석자료 수정
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId1"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId2"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId3"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId4"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId5"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId6"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileId7"));

        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem1"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem2"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem3"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem4"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem5"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem6"));
        fileBiz.updateFileList(xReq.getMultiData("ds_analyFileIdThem7"));

        // 기술분류코드 수정
        dao.deleteRivalPatTechCodeAll(anlyID);
        dao.createRivalPatTechCode(anlyID, xReq.getMultiData("ds_techCodeList"));
        dao.updateRivalPatTechCode(anlyID);

        // IPC분류코드 수정
        dao.deleteRivalPatIpcCodeAll(anlyID);
        dao.createRivalPatIpcCode(anlyID, xReq.getMultiData("ds_ipcCodeList"));
        dao.updateRivalPatIpcCode(anlyID);


        dao.updateAnalysisDoc(xReq);


    }
}
