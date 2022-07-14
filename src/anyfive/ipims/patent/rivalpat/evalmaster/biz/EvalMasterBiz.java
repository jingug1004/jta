package anyfive.ipims.patent.rivalpat.evalmaster.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.rivalpat.evalmaster.dao.EvalMasterDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class EvalMasterBiz extends NAbstractServletBiz
{
    public EvalMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 평가마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatEvalMasterList(AjaxRequest xReq) throws NException
    {
        EvalMasterDao dao = new EvalMasterDao(this.nsr);

        return dao.retrieveRivalPatEvalMasterList(xReq);
    }
    /**
     * 기술별 현황(경쟁사)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatEvalMasterListTech(AjaxRequest xReq) throws NException
    {
        EvalMasterDao dao = new EvalMasterDao(this.nsr);

        return dao.retrieveRivalPatEvalMasterListTech(xReq);
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
        EvalMasterDao dao = new EvalMasterDao(this.nsr);

        NSingleData result = new NSingleData();

        String mgtId = xReq.getParam("MGT_ID");

        // 평가마스터 상세 조회
        result.set("ds_mainInfo", dao.retrieveRivalPatEvalMaster(xReq));

        // 기술분류코드 맵핑목록 조회
        result.set("ds_techCodeList", dao.retrieveRivalPatTechCodeList(mgtId));

        // IPC분류코드 맵핑목록 조회
        result.set("ds_ipcCodeList", dao.retrieveRivalPatIpcCodeList(mgtId));

        // 첨부파일 조회
        FileBiz fileBiz = new FileBiz(this.nsr);
        result.set("ds_etcFile", fileBiz.retrieveFileList(xReq));

        return result;
    }

    /**
     * 평가마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateRivalPatEvalMaster(AjaxRequest xReq) throws NException
    {
        EvalMasterDao dao = new EvalMasterDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String mgtId = xReq.getParam("MGT_ID");

        // 평가마스터 수정
        dao.updateRivalPatEvalMaster(xReq);

        // 기술분류코드 수정
        dao.deleteRivalPatTechCode(mgtId, xReq.getMultiData("ds_techCodeList"));
        dao.createRivalPatTechCode(mgtId, xReq.getMultiData("ds_techCodeList"));
        dao.updateRivalPatTechCode(mgtId);

        // IPC분류코드 수정
        dao.deleteRivalPatIpcCode(mgtId, xReq.getMultiData("ds_ipcCodeList"));
        dao.createRivalPatIpcCode(mgtId, xReq.getMultiData("ds_ipcCodeList"));
        dao.updateRivalPatIpcCode(mgtId);

        // 출원서파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));

        // 평가정보 수정
        if (dao.updateRivalPatEvalInfo(xReq.getMultiData("ds_evalInfo").getSingleData(0), mgtId) == 0) {
            dao.createRivalPatEvalInfo(xReq.getMultiData("ds_evalInfo").getSingleData(0), mgtId);
        }
    }

    /**
     * 평가마스터 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteRivalPatEvalMaster(AjaxRequest xReq) throws NException
    {
        EvalMasterDao dao = new EvalMasterDao(this.nsr);

        String mgtId = xReq.getParam("MGT_ID");

        // 댓글 전체 삭제
        dao.deleteRivalPatEvalReplyAll(xReq);

        // 기술분류코드 전체 삭제
        dao.deleteRivalPatTechCodeAll(mgtId);

        // IPC분류코드 전체 삭제
        dao.deleteRivalPatIpcCodeAll(mgtId);

        // 평가정보 삭제
        dao.deleteRivalPatEvalInfo(mgtId);

        // 평가마스터 삭제
        dao.deleteRivalPatEvalMaster(xReq);
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
        EvalMasterDao dao = new EvalMasterDao(this.nsr);

        return dao.retrieveRivalPatEvalReplyList(xReq);
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
        EvalMasterDao dao = new EvalMasterDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        xReq.setUserData("REPLY_SEQ", seqUtil.getRivalPatReplySeq(xReq.getParam("MGT_ID")));

        return dao.createRivalPatEvalReply(xReq);
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
        EvalMasterDao dao = new EvalMasterDao(this.nsr);

        return dao.deleteRivalPatEvalReply(xReq);
    }
}
