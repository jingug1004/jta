package anyfive.ipims.share.docpaper.inputregno.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.docpaper.common.util.DocPaperConsts;
import anyfive.ipims.share.docpaper.inputregno.dao.InputRegNoDao;

public class InputRegNoBiz extends NAbstractServletBiz
{
    public InputRegNoBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 등록정보 입력사항 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInputRegNo(AjaxRequest xReq) throws NException
    {
        InputRegNoDao dao = new InputRegNoDao(this.nsr);

        return dao.retrieveInputRegNo(xReq);
    }

    /**
     * 등록정보 입력사항 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateInputRegNo(AjaxRequest xReq) throws NException
    {
        InputRegNoDao dao = new InputRegNoDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 등록정보 저장
        dao.updateInputRegNo(xReq);

        String paperSubcode = xReq.getParam("PAPER_SUBCODE");

        if (paperSubcode.equals("")) paperSubcode = DocPaperConsts.SUBCODE_NONE;

        // 진행서류 생성
        docBiz.init(xReq.getParam("REF_ID"));
        docBiz.setPaper(xReq.getParam("PAPER_CODE"), paperSubcode);
        docBiz.setValue("PAPER_REF_NO", mainInfo.getString("APP_NO"));
        docBiz.setValue("COMMENTS", mainInfo.getString("INDEP_CLAIM") + "/" + mainInfo.getString("SUBORD_CLAIM") + "/" + mainInfo.getString("DRAWING_CNT") + "/" + mainInfo.getString("PAPER_CNT"));
        docBiz.setValue("REMARK", mainInfo.getString("REMARK"));
        docBiz.setValue("PAPER_DATE", mainInfo.getString("PAPER_DATE"));
        docBiz.setValue("FILE_ID", mainInfo.getString("FILE_ID"));
        docBiz.setValue("DUE_DATE", mainInfo.getString("DUE_DATE"));
        docBiz.setValue("URGENT_DATE", mainInfo.getString("URGENT_DATE"));
        docBiz.setInputOwnerBySystemType(xReq.getSystemData().getString("$SYSTEM_TYPE"));
        docBiz.create(true);

        // 등록원부/등록결정서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_fileId"));
    }
}
