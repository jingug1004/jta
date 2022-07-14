package anyfive.ipims.office.reqreceipt.extapply.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.office.common.mapping.consts.MappingDiv;
import anyfive.ipims.office.common.mapping.consts.MappingKind;
import anyfive.ipims.office.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.office.common.mapping.olcountry.biz.OLCountryMappBiz;
import anyfive.ipims.office.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.office.reqreceipt.extapply.dao.ExtApplyReceiptDao;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ExtApplyReceiptBiz extends NAbstractServletBiz
{
    public ExtApplyReceiptBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtApplyReceiptList(AjaxRequest xReq) throws NException
    {
        ExtApplyReceiptDao dao = new ExtApplyReceiptDao(this.nsr);

        return dao.retrieveExtApplyReceiptList(xReq);
    }

    /**
     * 해외출원의뢰접수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtApplyReceipt(AjaxRequest xReq) throws NException
    {
        ExtApplyReceiptDao dao = new ExtApplyReceiptDao(this.nsr);

        NSingleData result = new NSingleData();

        String olId = xReq.getParam("OL_ID");

        // 해외출원의뢰접수 조회
        NSingleData mainInfo = dao.retrieveExtApplyReceipt(xReq);
        result.set("ds_mainInfo", mainInfo);

        String grpId = mainInfo.getString("GRP_ID");

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        // OL국가 맵핑목록 조회
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        result.set("ds_olCountryList", olCountryBiz.retrieveOLCountryList(olId));

        return result;
    }

    /**
     * 해외출원의뢰접수 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtApplyReceipt(AjaxRequest xReq) throws NException
    {
        ExtApplyReceiptDao dao = new ExtApplyReceiptDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        String olId = xReq.getParam("OL_ID");

        NMultiData olList = xReq.getMultiData("ds_olCountryList");

        String mode = xReq.getParam("MODE");
        String refId = null;

        if("R".equals(mode)){
            for(int i =0; i< olList.getRowSize(); i++){
                refId = olList.getString(i, "REF_ID");
                dao.updateExtOffice(refId, olList.getSingleData(i));
            }

        }else{
            // 해외출원의뢰접수 저장
            dao.updateExtApplyReceipt(xReq);

            for (int i = 0; i < olList.getRowSize(); i++) {
                refId = olList.getString(i, "REF_ID");

                // 해외출원마스터 사무소 정보 저장
                dao.updateExtMasterOfficeInfo(refId, olList.getSingleData(i));
                dao.updateExtOffice(refId, olList.getSingleData(i));

                // 진행서류 생성
                docBiz.init(refId);
                docBiz.setEvent("OFFICE_RECEIPT");
                docBiz.create();
            }

            // 업무프로세스
            WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
            wpBiz.update(olId, WorkProcessConst.Action.OFFICE_RECEIPT, true);
        }
    }
}
