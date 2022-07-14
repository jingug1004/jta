package anyfive.ipims.patent.applymgt.extpatent.group.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.extpatent.group.dao.ExtPatentGroupDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.prod.biz.ProdCodeMappBiz;
import anyfive.ipims.patent.common.mapping.project.biz.ProjectMappBiz;
import anyfive.ipims.patent.common.mapping.prsch.biz.PrschMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.patent.common.mapping.tech.biz.TechCodeMappBiz;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.common.util.SequenceUtil;

public class ExtPatentGroupBiz extends NAbstractServletBiz
{
    public ExtPatentGroupBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentGroupList(AjaxRequest xReq) throws NException
    {
        ExtPatentGroupDao dao = new ExtPatentGroupDao(this.nsr);

        return dao.retrieveExtPatentGroupList(xReq);
    }

    /**
     * 국내마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntMaster(AjaxRequest xReq) throws NException
    {
        ExtPatentGroupDao dao = new ExtPatentGroupDao(this.nsr);

        return dao.retrieveIntMaster(xReq);
    }

    /**
     * 해외출원품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentGroup(AjaxRequest xReq) throws NException
    {
        ExtPatentGroupDao dao = new ExtPatentGroupDao(this.nsr);

        String grpId = xReq.getParam("GRP_ID");

        NSingleData result = new NSingleData();

        // 국내특허 출원의뢰서 조회
        result.set("ds_mainInfo", dao.retrieveExtPatentGroup(xReq));

        // 그룹 REF-NO 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_groupRefNoList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        // 프로젝트 맵핑목록 조회
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        result.set("ds_projectList", pjtBiz.retrieveProjectList(grpId, MappingDiv.NONE));

        // 기술분류코드 맵핑목록 조회
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        result.set("ds_techCodeList", techBiz.retrieveTechCodeList(grpId, MappingDiv.NONE));

        // 관련제품코드 맵핑목록 조회
        ProdCodeMappBiz prodBiz = new ProdCodeMappBiz(this.nsr);
        result.set("ds_prodCodeList", prodBiz.retrieveProdCodeList(grpId, MappingDiv.NONE));

        // 선행조사 맵핑목록 조회
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        result.set("ds_prschList", prschBiz.retrievePrschList(grpId, MappingDiv.NONE));

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appExpManCodeList", appmc.retrieveAppManCodeList(grpId, MappingDiv.NONE));

        return result;
    }

    /**
     * 해외출원품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createExtPatentGroup(AjaxRequest xReq) throws NException
    {
        ExtPatentGroupDao dao = new ExtPatentGroupDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // GRP_ID 시퀀스 생성
        String grpId = seqUtil.getBizId();

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 데이터 준비
        xReq.setUserData("GRP_ID", grpId);
        xReq.setUserData("GRP_NO", seqUtil.getRefGrpNo(mainInfo.getString("RIGHT_DIV")));


        // 해외출원품의 생성
        dao.createExtPatentGroup(xReq);

        // 출원보상금 내역 저장
        rewardBiz.init(grpId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", "1");
        rewardBiz.update("APP");
        rewardBiz.update("REG");

        // 그룹 REF-NO 맵핑목록 저장
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        refBiz.updateRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE, xReq.getMultiData("ds_groupRefNoList"));

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(grpId, xReq.getMultiData("ds_inventorList"));

        // 프로젝트 맵핑목록 저장
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        pjtBiz.updateProjectList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_projectList"));

        // 기술분류코드 맵핑목록 저장
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        techBiz.updateTechCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 관련제품코드 맵핑목록 저장
        ProdCodeMappBiz prodBiz = new ProdCodeMappBiz(this.nsr);
        prodBiz.updateProdCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_prodCodeList"));

        // 선행조사 맵핑목록 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

        //출원인 맵핑목록 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_appExpManCodeList"));

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        return grpId;
    }

    /**
     * 해외출원품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtPatentGroup(AjaxRequest xReq) throws NException
    {
        ExtPatentGroupDao dao = new ExtPatentGroupDao(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String grpId = xReq.getParam("GRP_ID");

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 해외출원품의 수정
        dao.updateExtPatentGroup(xReq);

        // 출원보상금 내역 저장
        rewardBiz.init(grpId);
        rewardBiz.setValue("REWARD_GRADE", mainInfo.getString("APP_REWARD_GRADE"));
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("APP_REWARD_GIVETARGET_YN"));
        rewardBiz.setValue("REWARD_GIVE_AMOUNT", mainInfo.getString("APP_REWARD_GIVE_AMOUNT"));
        rewardBiz.setValue("REWARD_GIVE_DATE", mainInfo.getString("APP_REWARD_GIVE_DATE"));
        rewardBiz.update("APP");

        // 등록보상금 내역 저장
        rewardBiz.init(grpId);
        rewardBiz.setValue("REWARD_GRADE", mainInfo.getString("REG_REWARD_GRADE"));
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("REG_REWARD_GIVETARGET_YN"));
        rewardBiz.setValue("REWARD_GIVE_AMOUNT", mainInfo.getString("REG_REWARD_GIVE_AMOUNT"));
        rewardBiz.setValue("REWARD_GIVE_DATE", mainInfo.getString("REG_REWARD_GIVE_DATE"));
        rewardBiz.update("REG");

        // 그룹 REF-NO 맵핑목록 저장
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        refBiz.updateRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE, xReq.getMultiData("ds_groupRefNoList"));

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(grpId, xReq.getMultiData("ds_inventorList"));

        // 프로젝트 맵핑목록 저장
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        pjtBiz.updateProjectList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_projectList"));

        // 기술분류코드 맵핑목록 저장
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        techBiz.updateTechCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 관련제품코드 맵핑목록 저장
        ProdCodeMappBiz prodBiz = new ProdCodeMappBiz(this.nsr);
        prodBiz.updateProdCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_prodCodeList"));

        // 선행조사 맵핑목록 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

         // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_appExpManCodeList"));
    }
}
