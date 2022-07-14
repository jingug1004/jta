package anyfive.ipims.office.reqreceipt.intapply.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.common.mapping.consts.MappingDiv;
import anyfive.ipims.office.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.office.common.mapping.project.biz.ProjectMappBiz;
import anyfive.ipims.office.reqreceipt.intapply.dao.IntApplyReceiptDao;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class IntApplyReceiptBiz extends NAbstractServletBiz
{
    public IntApplyReceiptBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내출원의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntApplyReceiptList(AjaxRequest xReq) throws NException
    {
        IntApplyReceiptDao dao = new IntApplyReceiptDao(this.nsr);

        return dao.retrieveIntApplyReceiptList(xReq);
    }

    /**
     * 국내출원의뢰접수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntApplyReceipt(AjaxRequest xReq) throws NException
    {
        IntApplyReceiptDao dao = new IntApplyReceiptDao(this.nsr);

        NSingleData result = new NSingleData();

        // 국내출원의뢰접수 조회
        result.set("ds_mainInfo", dao.retrieveIntApplyReceipt(xReq));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(xReq.getParam("REF_ID")));

     // 프로젝트 맵핑목록 조회
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        result.set("ds_projectList", pjtBiz.retrieveProjectList(xReq.getParam("REF_ID"), MappingDiv.NONE));

        return result;
    }

    /**
     * 국내출원의뢰접수 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntApplyReceipt(AjaxRequest xReq) throws NException
    {
        IntApplyReceiptDao dao = new IntApplyReceiptDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData mainInfo = dao.retrieveIntApplyReceipt(xReq);

        // 국내출원의뢰접수 저장
        dao.updateIntApplyReceipt(xReq);

        if (mainInfo.getString("OFFICE_RCPT_DATE").equals("") != true) return;

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(refId, WorkProcessConst.Action.OFFICE_RECEIPT, true);

        // 진행서류 생성
        docBiz.init(refId);
        docBiz.setEvent("OFFICE_RECEIPT");
        docBiz.create();
    }
}
