package anyfive.ipims.patent.ipbiz.history.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.ipbiz.history.dao.IpBizHistoryDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class IpBizHistoryBiz extends NAbstractServletBiz
{
    public IpBizHistoryBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * History 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpBizHistoryList(AjaxRequest xReq) throws NException
    {
        IpBizHistoryDao dao = new IpBizHistoryDao(this.nsr);

        return dao.retrieveIpBizHistoryList(xReq);
    }

    /**
     * History 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIpBizHistory(AjaxRequest xReq) throws NException
    {
        IpBizHistoryDao dao = new IpBizHistoryDao(this.nsr);

        return dao.retrieveIpBizHistory(xReq);
    }

    /**
     * History 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createIpBizHistory(AjaxRequest xReq) throws NException
    {
        IpBizHistoryDao dao = new IpBizHistoryDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String histSeq = seqUtil.getIpBizHistorySeq(xReq.getParam("REF_ID"));

        xReq.setUserData("HIST_SEQ", histSeq);

        // History 생성
        if (dao.createIpBizHistory(xReq) == 0) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_histFile"));
    }

    /**
     * History 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIpBizHistory(AjaxRequest xReq) throws NException
    {
        IpBizHistoryDao dao = new IpBizHistoryDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // History 수정
        dao.updateIpBizHistory(xReq);

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_histFile"));
    }

    /**
     * History 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteIpBizHistory(AjaxRequest xReq) throws NException
    {
        IpBizHistoryDao dao = new IpBizHistoryDao(this.nsr);

        NSingleData mainInfo = dao.retrieveIpBizHistory(xReq);

        dao.deleteIpBizHistory(xReq);

        // 첨부파일 삭제
        FileBiz fileBiz = new FileBiz(this.nsr);
        fileBiz.deleteFileList(mainInfo.getString("HIST_FILE"));
    }

    /**
     * History 전체삭제
     *
     * @param refId
     * @throws NException
     */
    public void deleteIpBizHistoryAll(String refId) throws NException
    {
        IpBizHistoryDao dao = new IpBizHistoryDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        NMultiData histList = dao.retrieveIpBizHistoryListAll(refId);

        // History 첨부파일 삭제
        for (int i = 0; i < histList.getRowSize(); i++) {
            fileBiz.deleteFileList(histList.getString(i, "HIST_FILE"));
        }

        // History 전체삭제
        dao.deleteIpBizHistoryAll(refId);
    }
}
