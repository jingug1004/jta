package anyfive.ipims.patent.applymgt.docpaper.extrejectexam.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.docpaper.extrejectexam.dao.ExtRejectExamDao;

public class ExtRejectExamBiz extends NAbstractServletBiz
{
    public ExtRejectExamBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외거절검토서 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtRejectExam(AjaxRequest xReq) throws NException
    {
        ExtRejectExamDao dao = new ExtRejectExamDao(this.nsr);

        NSingleData result = new NSingleData();

        NSingleData mainInfo = dao.retrieveExtRejectExam(xReq);

        String refId = xReq.getParam("REF_ID");
        String oaSeq = mainInfo.getString("OA_SEQ");

        result.set("ds_mainInfo", mainInfo);
        result.set("ds_passList", dao.retrieveExtRejectExamPassList(refId, oaSeq));
        result.set("ds_intRefList", dao.retrieveExtRejectExamIntRefList(refId));

        return result;
    }

    /**
     * 해외거절검토서 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtRejectExam(AjaxRequest xReq) throws NException
    {
        ExtRejectExamDao dao = new ExtRejectExamDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        if (dao.updateExtRejectExam(xReq) == 0) {
            dao.createExtRejectExam(xReq);
        }

        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }
}
