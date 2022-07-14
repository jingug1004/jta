package anyfive.ipims.patent.applymgt.tmark.extmaster.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.common.biz.ApplyMgtCommonBiz;
import anyfive.ipims.patent.applymgt.tmark.extmaster.dao.TMarkExtMasterDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.patent.common.mapping.tmarkcls.biz.TMarkClsMappBiz;

public class TMarkExtMasterBiz extends NAbstractServletBiz
{
    public TMarkExtMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표해외출원 마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtMasterList(AjaxRequest xReq) throws NException
    {
        TMarkExtMasterDao dao = new TMarkExtMasterDao(this.nsr);

        return dao.retrieveTMarkExtMasterList(xReq);
    }

    /**
     * 상표해외출원 마스터 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtMaster(AjaxRequest xReq) throws NException
    {
        TMarkExtMasterDao dao = new TMarkExtMasterDao(this.nsr);

        NSingleData result = new NSingleData();

        // 상표해외출원마스터 조회
        NSingleData mainInfo = dao.retrieveTMarkExtMaster(xReq);
        result.set("ds_mainInfo", mainInfo);

        String grpId = mainInfo.getString("GRP_ID");

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 상품류 맵핑목록 조회
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        result.set("ds_tmarkClsList", tmarkBiz.retrieveTMarkClsList(grpId, MappingDiv.NONE));

         // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appManCodeList", appmc.retrieveAppManCodeList(grpId, MappingDiv.NONE));

        return result;
    }

    /**
     * 상표해외출원 마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkExtMaster(AjaxRequest xReq) throws NException
    {
        TMarkExtMasterDao dao = new TMarkExtMasterDao(this.nsr);
        ApplyMgtCommonBiz appBiz = new ApplyMgtCommonBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");

        // 상표해외출원마스터 조회
        NSingleData mainInfo_s = dao.retrieveTMarkExtMaster(xReq);

        String grpId = mainInfo_s.getString("GRP_ID");

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 건담당자 변경시 진행서류 추가
        appBiz.createMasterJobManChangePaper(refId, mainInfo.getString("JOB_MAN"));

        // 사무소 변경시 진행서류 추가
        appBiz.createMasterOfficeCodeChangePaper(refId, mainInfo.getString("OFFICE_CODE"));

        // 상표해외출원 마스터 수정
        dao.updateTMarkIntMaster(xReq);

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));

    }
}
