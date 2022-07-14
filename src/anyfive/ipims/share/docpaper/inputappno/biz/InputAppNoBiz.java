package anyfive.ipims.share.docpaper.inputappno.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.docpaper.common.util.DocPaperConsts;
import anyfive.ipims.share.docpaper.inputappno.dao.InputAppNoDao;

public class InputAppNoBiz extends NAbstractServletBiz
{
    public InputAppNoBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원정보 입력사항 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInputAppNo(AjaxRequest xReq) throws NException
    {
        InputAppNoDao dao = new InputAppNoDao(this.nsr);

        return dao.retrieveInputAppNo(xReq);
    }

    /**
     * 출원정보 입력사항 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateInputAppNo(AjaxRequest xReq) throws NException
    {
        InputAppNoDao dao = new InputAppNoDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);//
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        String refId = seqUtil.getBizId();//

        // IPC분류코드 수정//
        dao.deleteRivalPatIpcCodeAll(refId);//
        dao.createRivalPatIpcCode(refId, xReq.getMultiData("ds_ipcCodeList"));//
        dao.updateRivalPatIpcCode(refId);//

        String ipcCode = "";
        NMultiData resList = xReq.getMultiData("ds_ipcCodeList");

        for (int i = 0; i < resList.getRowSize(); i++) {
            ipcCode += resList.getString(i, "IPC_CODE");
            ipcCode += "/";
        }

        if(ipcCode.length() != 0){
            int ipcCodeCnt= ipcCode.length() -1;
            ipcCode = ipcCode.substring(0, ipcCodeCnt);
        }

        // 출원정보 저장

        dao.updateInputAppNo(xReq,ipcCode);

        String paperSubcode = xReq.getParam("PAPER_SUBCODE");

        if (paperSubcode.equals("")) paperSubcode = DocPaperConsts.SUBCODE_NONE;

        // 진행서류 생성
        docBiz.init(xReq.getParam("REF_ID"));
        docBiz.setPaper(xReq.getParam("PAPER_CODE"), paperSubcode);
        docBiz.setValue("PAPER_REF_NO", mainInfo.getString("APP_NO"));
        docBiz.setValue("PAPER_DATE", mainInfo.getString("PAPER_DATE"));
        docBiz.setValue("COMMENTS", mainInfo.getString("INDEP_CLAIM") + "/" + mainInfo.getString("SUBORD_CLAIM") + "/" + mainInfo.getString("DRAWING_CNT") + "/" + mainInfo.getString("PAPER_CNT"));
        docBiz.setValue("REMARK", mainInfo.getString("REMARK"));
        docBiz.setValue("FILE_ID", mainInfo.getString("APPDOC_FILE"));
        docBiz.setInputOwnerBySystemType(xReq.getSystemData().getString("$SYSTEM_TYPE"));
        docBiz.create(true);

        // 출원명세서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_appdocFile"));
    }
}
