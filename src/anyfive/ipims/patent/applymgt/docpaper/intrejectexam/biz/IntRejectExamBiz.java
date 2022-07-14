package anyfive.ipims.patent.applymgt.docpaper.intrejectexam.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.docpaper.intrejectexam.dao.IntRejectExamDao;

public class IntRejectExamBiz extends NAbstractServletBiz
{
    public IntRejectExamBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 거절검토서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntRejectExam(AjaxRequest xReq) throws NException
    {
        IntRejectExamDao dao = new IntRejectExamDao(this.nsr);

        NSingleData result = new NSingleData();

        NSingleData mainInfo = dao.retrieveIntRejectExam(xReq);

        String refId = xReq.getParam("REF_ID");
        String oaSeq = mainInfo.getString("OA_SEQ");

        result.set("ds_mainInfo", mainInfo);
        result.set("ds_passList", dao.retrieveIntRejectExamPassList(refId, oaSeq));
        result.set("ds_extRefList", dao.retrieveIntRejectExamExtRefList(refId));

        return result;
    }

    /**
     * 거절검토서 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntRejectExam(AjaxRequest xReq) throws NException
    {
        IntRejectExamDao dao = new IntRejectExamDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        if (dao.updateIntRejectExam(xReq) == 0) {
            dao.createIntRejectExam(xReq);
        }

        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }
}
