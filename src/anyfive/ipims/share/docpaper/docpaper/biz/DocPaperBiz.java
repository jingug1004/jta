package anyfive.ipims.share.docpaper.docpaper.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.docpaper.docpaper.dao.DocPaperDao;

public class DocPaperBiz extends NAbstractServletBiz
{
    public DocPaperBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 상세목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaperDetailList(AjaxRequest xReq) throws NException
    {
        DocPaperDao dao = new DocPaperDao(this.nsr);

        return dao.retrieveDocPaperDetailList(xReq);
    }

    /**
     * 진행서류 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaperInfo(AjaxRequest xReq) throws NException
    {
        DocPaperDao dao = new DocPaperDao(this.nsr);

        return dao.retrieveDocPaperInfo(xReq);
    }

    /**
     * 진행서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaper(AjaxRequest xReq) throws NException
    {
        DocPaperDao dao = new DocPaperDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveDocPaper(xReq));

        return result;
    }

//    /**
//     * 진행서류 생성
//     *
//     * @param xReq
//     * @return
//     * @throws NException
//     */
//    public String createDocPaper(AjaxRequest xReq) throws NException
//    {
//        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
//        FileBiz fileBiz = new FileBiz(this.nsr);
//
//        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");
//
//        String systemType = SessionUtil.getUserInfo(this.nsr).getSystemType().substring(0, 3);
//
//        docBiz.init(xReq.getParam("REF_ID"));
//        String papercode = xReq.getParam("PAPER_CODE");
//        System.out.println("papercode:"+papercode);
//        String papersubcode = xReq.getParam("PAPER_SUBCODE");
//
//        fileBiz.updateFileList(xReq.getMultiData("ds_fileId"));
//        docBiz.setPaper(papercode,papersubcode);
//        if(mainInfo.getString("STATUS").equals("10INT-0016") != true){
//            // 관련파일 저장
//            System.out.println();
//            fileBiz.updateFileList(xReq.getMultiData("ds_fileId"));
//            docBiz.setPaper(papercode,papersubcode);
//        }
//        else{
//
//            docBiz.setPaper(papercode,papersubcode);
//        }
//        if(systemType.equals("OFFICE")){
//            docBiz.setValue("INPUT_OWNER", SessionUtil.getUserInfo(this.nsr).getSystemType().substring(0, 3));
//        }else{
//            if(SessionUtil.getUserInfo(this.nsr).isJobMan()){
//                docBiz.setValue("INPUT_OWNER", SessionUtil.getUserInfo(this.nsr).getSystemType().substring(0, 3));
//            }else{
//                docBiz.setValue("INPUT_OWNER", "INV");
//            }
//
//        }
//        docBiz.setValue("CRE_USER", SessionUtil.getUserInfo(this.nsr).getUserId());
//
//        String key = null;
//
//        for (int i = 0; i < mainInfo.getKeySize(); i++) {
//            key = mainInfo.getKey(i);
//            if (key.equals("REF_ID")) continue;
//            if (key.equals("PAPER_CODE")) continue;
//            if (key.equals("PAPER_SUBCODE")) continue;
//            docBiz.setValue(key, mainInfo.getString(key));
//        }
//
//        // 진행서류 생성
//        String listSeq = docBiz.create(true);
//
//        return listSeq;
//    }

    /**
     * 진행서류 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createDocPaper(AjaxRequest xReq) throws NException
    {
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        //String systemType = SessionUtil.getUserInfo(this.nsr).getSystemType().substring(0, 3);
        String systemType = SessionUtil.getUserInfo(this.nsr).getSystemType();

        docBiz.init(xReq.getParam("REF_ID"));
        docBiz.setPaper(mainInfo.getString("PAPER_CODE"), mainInfo.getString("PAPER_SUBCODE"));

        if(systemType.equals("OFFICE")){
            docBiz.setValue("INPUT_OWNER", SessionUtil.getUserInfo(this.nsr).getSystemType().substring(0, 3));
        }else{
            if(SessionUtil.getUserInfo(this.nsr).isJobMan()){
                docBiz.setValue("INPUT_OWNER", SessionUtil.getUserInfo(this.nsr).getSystemType().substring(0, 3));
            }else{
                docBiz.setValue("INPUT_OWNER", "INV");
            }

        }
        //docBiz.setValue("INPUT_OWNER", SessionUtil.getUserInfo(this.nsr).getSystemType().substring(0, 3));

        docBiz.setValue("CRE_USER", SessionUtil.getUserInfo(this.nsr).getUserId());

        String key = null;

        for (int i = 0; i < mainInfo.getKeySize(); i++) {
            key = mainInfo.getKey(i);
            if (key.equals("REF_ID")) continue;
            if (key.equals("PAPER_CODE")) continue;
            if (key.equals("PAPER_SUBCODE")) continue;
            docBiz.setValue(key, mainInfo.getString(key));
        }

        // 진행서류 생성
        String listSeq = docBiz.create(true);

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_fileId"));

        return listSeq;
    }


    /**
     * 진행서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDocPaper(AjaxRequest xReq) throws NException
    {
        DocPaperDao dao = new DocPaperDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 진행서류 수정
        dao.updateDocPaper(xReq);

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_fileId"));

        // OA DUE_DATE 수정
        docBiz.init(xReq.getParam("REF_ID"));
        docBiz.updateOADueDate(xReq.getParam("LIST_SEQ"));
    }

    /**
     * 진행서류 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteDocPaper(AjaxRequest xReq) throws NException
    {
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // 진행서류 삭제
        docBiz.init(xReq.getParam("REF_ID"));
        docBiz.delete(xReq.getParam("LIST_SEQ"));
    }

    /**
     * 진행서류 확인처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void confirmDocPaper(AjaxRequest xReq) throws NException
    {
        DocPaperDao dao = new DocPaperDao(this.nsr);

        dao.confirmDocPaper(xReq);
    }
}
