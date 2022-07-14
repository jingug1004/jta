package anyfive.ipims.patent.applymgt.design.intmaster.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.common.biz.ApplyMgtCommonBiz;
import anyfive.ipims.patent.applymgt.design.intmaster.dao.DesignIntMasterDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.common.util.SequenceUtil;

public class DesignIntMasterBiz extends NAbstractServletBiz
{
    public DesignIntMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인국내출원마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntMasterList(AjaxRequest xReq) throws NException
    {
        DesignIntMasterDao dao = new DesignIntMasterDao(this.nsr);

        return dao.retrieveDesignIntMasterList(xReq);
    }

    /**
     * 디자인국내출원마스터 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntMaster(AjaxRequest xReq) throws NException
    {
        DesignIntMasterDao dao = new DesignIntMasterDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 디자인국내출원마스터
        result.set("ds_mainInfo", dao.retrieveDesignIntMaster(xReq));

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appManCodeList", appmc.retrieveAppManCodeList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 디자인국내출원마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDesignIntMaster(AjaxRequest xReq) throws NException
    {
        DesignIntMasterDao dao = new DesignIntMasterDao(this.nsr);
        ApplyMgtCommonBiz appBiz = new ApplyMgtCommonBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");
        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 건담당자 변경시 진행서류 추가
        appBiz.createMasterJobManChangePaper(refId, mainInfo.getString("JOB_MAN"));

        // 사무소 변경시 진행서류 추가
        appBiz.createMasterOfficeCodeChangePaper(refId, mainInfo.getString("OFFICE_CODE"));

        // 디자인국내출원마스터 수정
        dao.updateDesignIntMaster(xReq);

        // 출원보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("APP_REWARD_GIVETARGET_YN"));
        rewardBiz.update("APP");

        // 등록보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("REG_REWARD_GIVETARGET_YN"));
        rewardBiz.update("REG");

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 디자인이미지 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_designImgFile"));

        // 6면도 및 사시도 또는 의장출원품의서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));

        // 출원서 파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_appdocFile"));

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));
    }

    /**
     * 디자인국내출원마스터 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createDesignIntMaster(AjaxRequest xReq) throws NException
    {
        DesignIntMasterDao dao = new DesignIntMasterDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);

        // REF_ID 시퀀스 생성
        String refId = seqUtil.getBizId();

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 데이터 준비
        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", seqUtil.getRefGrpNo("30"));

        // 디자인국내출원마스터 작성
        dao.createDesignIntMaster(xReq);

        // 출원보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("APP_REWARD_GIVETARGET_YN"));
        rewardBiz.update("APP");

        // 등록보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("REG_REWARD_GIVETARGET_YN"));
        rewardBiz.update("REG");

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 디자인이미지 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_designImgFile"));

        // 6면도 및 사시도 또는 의장출원품의서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));

        // 출원서 파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_appdocFile"));

        return refId;
    }
}
