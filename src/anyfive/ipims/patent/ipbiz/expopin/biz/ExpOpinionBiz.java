package anyfive.ipims.patent.ipbiz.expopin.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.ipbiz.expopin.dao.ExpOpinionDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class ExpOpinionBiz extends NAbstractServletBiz
{
    public ExpOpinionBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 감정서 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExpOpinionList(AjaxRequest xReq) throws NException
    {
        ExpOpinionDao dao = new ExpOpinionDao(this.nsr);

        return dao.retrieveExpOpinionList(xReq);
    }

    /**
     * 감정서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createExpOpinion(AjaxRequest xReq) throws NException
    {
        ExpOpinionDao dao = new ExpOpinionDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String expopinId = seqUtil.getBizId();

        // EXPOPIN_ID 시퀀스 생성
        xReq.setUserData("EXPOPIN_ID", expopinId);

        // MGT_NO 시퀀스 생성
        xReq.setUserData("MGT_NO", seqUtil.getExpopinMgtNo());

        if (dao.createExpOpinion(xReq) == 0) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        return expopinId;
    }

    /**
     * 감정서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExpOpinion(AjaxRequest xReq) throws NException
    {
        ExpOpinionDao dao = new ExpOpinionDao(this.nsr);

        return dao.retrieveExpOpinion(xReq);
    }

    /**
     * 감정서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExpOpinion(AjaxRequest xReq) throws NException
    {
        ExpOpinionDao dao = new ExpOpinionDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 감정서 수정
        dao.updateExpOpinion(xReq);

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }

    /**
     * 감정서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteExpOpinion(AjaxRequest xReq) throws NException
    {
        ExpOpinionDao dao = new ExpOpinionDao(this.nsr);

        NSingleData mainInfo = dao.retrieveExpOpinion(xReq);

        // 감정서 삭제
        dao.deleteExpOpinion(xReq);

        // 첨부파일 삭제
        FileBiz fileBiz = new FileBiz(this.nsr);
        fileBiz.deleteFileList(mainInfo.getString("ATTACH_FILE"));
    }
}
