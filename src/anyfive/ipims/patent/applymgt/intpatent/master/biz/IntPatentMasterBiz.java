package anyfive.ipims.patent.applymgt.intpatent.master.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.common.biz.ApplyMgtCommonBiz;
import anyfive.ipims.patent.applymgt.intpatent.master.dao.IntPatentMasterDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.prod.biz.ProdCodeMappBiz;
import anyfive.ipims.patent.common.mapping.project.biz.ProjectMappBiz;
import anyfive.ipims.patent.common.mapping.prsch.biz.PrschMappBiz;
import anyfive.ipims.patent.common.mapping.tech.biz.TechCodeMappBiz;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.common.util.SequenceUtil;

public class IntPatentMasterBiz extends NAbstractServletBiz
{
    public IntPatentMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내출원 마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentMasterList(AjaxRequest xReq) throws NException
    {
        IntPatentMasterDao dao = new IntPatentMasterDao(this.nsr);

        return dao.retrieveIntPatentMasterList(xReq);
    }

    /**
     * 국내출원 마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentMaster(AjaxRequest xReq) throws NException
    {
        IntPatentMasterDao dao = new IntPatentMasterDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 국내출원 마스터 조회
        result.set("ds_mainInfo", dao.retrieveIntPatentMaster(xReq));

        // 해외출원품의번호 목록 조회
        result.set("ds_extGroupList", dao.retrieveExtGroupList(xReq));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        // 프로젝트 맵핑목록 조회
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        result.set("ds_projectList", pjtBiz.retrieveProjectList(refId, MappingDiv.NONE));

        // 기술분류코드 맵핑목록 조회
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        result.set("ds_techCodeList", techBiz.retrieveTechCodeList(refId, MappingDiv.NONE));

        // 관련제품코드 맵핑목록 조회
        ProdCodeMappBiz prodBiz = new ProdCodeMappBiz(this.nsr);
        result.set("ds_prodCodeList", prodBiz.retrieveProdCodeList(refId, MappingDiv.NONE));

        // 선행조사 맵핑목록 조회
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        result.set("ds_prschList", prschBiz.retrievePrschList(refId, MappingDiv.NONE));

        // 출원서파일 조회
        FileBiz fileBiz = new FileBiz(this.nsr);
        result.set("ds_appDocFile", fileBiz.retrieveFileList(xReq));

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appManCodeList", appmc.retrieveAppManCodeList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 국내출원 마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createIntPatentMaster(AjaxRequest xReq) throws NException
    {
        IntPatentMasterDao dao = new IntPatentMasterDao(this.nsr);
        ApplyMgtCommonBiz appBiz = new ApplyMgtCommonBiz(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // REF_ID 시퀀스 생성
        String refId = seqUtil.getBizId();

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 데이터 준비
        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", seqUtil.getRefGrpNo(mainInfo.getString("RIGHT_DIV")));

        // 국내출원 마스터 생성
        dao.createIntPatentMaster(xReq);

        // 출원보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", "1");
        rewardBiz.update("APP");

        // 등록보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", "1");
        rewardBiz.update("REG");

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 기술분류코드 맵핑목록 저장
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        techBiz.updateTechCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 관련제품코드 맵핑목록 저장
        ProdCodeMappBiz prodBiz = new ProdCodeMappBiz(this.nsr);
        prodBiz.updateProdCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prodCodeList"));

        // 출원서파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_appdocFile"));

        //초록정보 저장
        appBiz.updateMasterAbstract(refId, mainInfo.getString("AB_ABSTRACT"), mainInfo.getString("AB_CLAIM"));

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));


        return refId;
    }

    /**
     * 국내출원 마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntPatentMaster(AjaxRequest xReq) throws NException
    {
        IntPatentMasterDao dao = new IntPatentMasterDao(this.nsr);
        ApplyMgtCommonBiz appBiz = new ApplyMgtCommonBiz(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");
        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 권리구분 변경시 진행서류 추가
        appBiz.createMasterRightDivChangePaper(refId, mainInfo.getString("RIGHT_DIV"));

        // 건담당자 변경시 진행서류 추가
        appBiz.createMasterJobManChangePaper(refId, mainInfo.getString("JOB_MAN"));

        // 사무소 변경시 진행서류 추가
        appBiz.createMasterOfficeCodeChangePaper(refId, mainInfo.getString("OFFICE_CODE"));

        // 사무소담당자 변경시 진행서류 추가
        appBiz.createMasterOfficeJobManChangePaper(refId, mainInfo.getString("OFFICE_JOB_MAN"));

        // 국내출원 마스터 수정
        dao.updateIntPatentMaster(xReq);

        // 출원보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("APP_REWARD_GIVETARGET_YN"));
        rewardBiz.update("APP");

        // 등록보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("REG_REWARD_GIVETARGET_YN"));
        rewardBiz.update("REG");

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 프로젝트 맵핑목록 저장
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        pjtBiz.updateProjectList(refId, MappingDiv.NONE, xReq.getMultiData("ds_projectList"));

        // 기술분류코드 맵핑목록 저장
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        techBiz.updateTechCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 관련제품코드 맵핑목록 저장
        ProdCodeMappBiz prodBiz = new ProdCodeMappBiz(this.nsr);
        prodBiz.updateProdCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prodCodeList"));

        // 선행조사 맵핑목록 저장 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

        // 출원서파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_appdocFile"));


        //초록정보 저장
        appBiz.updateMasterAbstract(refId, mainInfo.getString("AB_ABSTRACT"), mainInfo.getString("AB_CLAIM"));

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));

    }
}
