package anyfive.ipims.patent.applymgt.extpatent.master.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.common.biz.ApplyMgtCommonBiz;
import anyfive.ipims.patent.applymgt.extpatent.master.dao.ExtPatentMasterDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;

public class ExtPatentMasterBiz extends NAbstractServletBiz
{
    public ExtPatentMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentMasterList(AjaxRequest xReq) throws NException
    {
        ExtPatentMasterDao dao = new ExtPatentMasterDao(this.nsr);

        return dao.retrieveExtPatentMasterList(xReq);
    }

    /**
     * 해외출원마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentMaster(AjaxRequest xReq) throws NException
    {
        ExtPatentMasterDao dao = new ExtPatentMasterDao(this.nsr);

        NSingleData result = new NSingleData();

        // 해외출원마스터 조회
        NSingleData mainInfo = dao.retrieveExtPatentMaster(xReq);
        result.set("ds_mainInfo", mainInfo);

        String grpId = mainInfo.getString("GRP_ID");

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appExpManCodeList", appmc.retrieveAppManCodeList(grpId, MappingDiv.NONE));

        return result;
    }

    /**
     * 해외출원마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtPatentMaster(AjaxRequest xReq) throws NException
    {
        ExtPatentMasterDao dao = new ExtPatentMasterDao(this.nsr);
        ApplyMgtCommonBiz appBiz = new ApplyMgtCommonBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");
        String grpId = xReq.getParam("GRP_ID");

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 건담당자 변경시 진행서류 추가
        appBiz.createMasterJobManChangePaper(refId, mainInfo.getString("JOB_MAN"));

        // 사무소 변경시 진행서류 추가
        appBiz.createMasterOfficeCodeChangePaper(refId, mainInfo.getString("OFFICE_CODE"));

        // 사무소담당자 변경시 진행서류 추가
        appBiz.createMasterOfficeJobManChangePaper(refId, mainInfo.getString("OFFICE_JOB_MAN"));

        // 해외출원 마스터 수정
        dao.updateExtPatentMaster(xReq);

        // 초록정보 저장
        appBiz.updateMasterAbstract(refId, mainInfo.getString("AB_ABSTRACT"), mainInfo.getString("AB_CLAIM"));

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_appExpManCodeList"));
    }
}
