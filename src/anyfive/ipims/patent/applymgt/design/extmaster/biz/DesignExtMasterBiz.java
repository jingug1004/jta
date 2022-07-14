package anyfive.ipims.patent.applymgt.design.extmaster.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.common.biz.ApplyMgtCommonBiz;
import anyfive.ipims.patent.applymgt.design.extmaster.dao.DesignExtMasterDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;

public class DesignExtMasterBiz extends NAbstractServletBiz
{
    public DesignExtMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인해외출원 마스터목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignExtMasterList(AjaxRequest xReq) throws NException
    {
        DesignExtMasterDao dao = new DesignExtMasterDao(this.nsr);

        return dao.retrieveDesignExtMasterList(xReq);
    }

    /**
     * 디자인해외출원 마스터상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignExtMaster(AjaxRequest xReq) throws NException
    {
        DesignExtMasterDao dao = new DesignExtMasterDao(this.nsr);

        String grpId = xReq.getParam("GRP_ID");
        String refId = xReq.getParam("REF_ID");


        NSingleData result = new NSingleData();

        // 해외디자인 출원의뢰
        result.set("ds_mainInfo", dao.retrieveDesignExtMaster(xReq));

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appManCodeList", appmc.retrieveAppManCodeList(grpId, MappingDiv.NONE));

        return result;
    }

    /**
     * 디자인해외출원 마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDesignExtMaster(AjaxRequest xReq) throws NException
    {
        DesignExtMasterDao dao = new DesignExtMasterDao(this.nsr);
        ApplyMgtCommonBiz appBiz = new ApplyMgtCommonBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");
        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 상표해외출원마스터 조회
        NSingleData mainInfo_s = dao.retrieveDesignExtMaster(xReq);

        String grpId = mainInfo_s.getString("GRP_ID");

        // 건담당자 변경시 진행서류 추가
        appBiz.createMasterJobManChangePaper(refId, mainInfo.getString("JOB_MAN"));

        // 사무소 변경시 진행서류 추가
        appBiz.createMasterOfficeCodeChangePaper(refId, mainInfo.getString("OFFICE_CODE"));

        // 디자인해외출원 마스터 수정
        dao.updateDesignIntMaster(xReq);

       // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));
    }
}
