package anyfive.ipims.patent.applymgt.tmark.extgroup.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.tmark.extgroup.dao.TMarkExtGroupDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.patent.common.mapping.tmarkcls.biz.TMarkClsMappBiz;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.common.util.SequenceUtil;

public class TMarkExtGroupBiz extends NAbstractServletBiz
{
    public TMarkExtGroupBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표해외출원품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtGroupList(AjaxRequest xReq) throws NException
    {
        TMarkExtGroupDao dao = new TMarkExtGroupDao(this.nsr);

        return dao.retrieveExtTMarkGroupList(xReq);
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
        TMarkExtGroupDao dao = new TMarkExtGroupDao(this.nsr);

        return dao.retrieveIntMaster(xReq);
    }

    /**
     * 상표해외출원품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtGroup(AjaxRequest xReq) throws NException
    {
        TMarkExtGroupDao dao = new TMarkExtGroupDao(this.nsr);

        String grpId = xReq.getParam("GRP_ID");

        NSingleData result = new NSingleData();

        // 국내특허 출원의뢰서 조회
        result.set("ds_mainInfo", dao.retrieveTMarkExtGroup(xReq));

        // 그룹 REF-NO 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_groupRefNoList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        // 상품류 맵핑목록 조회
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        result.set("ds_tmarkClsList", tmarkBiz.retrieveTMarkClsList(grpId, MappingDiv.NONE));

        // 출원인 맵핑 목록 조회
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appExpManCodeList", appmc.retrieveAppManCodeList(grpId, MappingDiv.NONE));

        return result;
    }

    /**
     * 상표해외출원품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createTMarkExtGroup(AjaxRequest xReq) throws NException
    {
        TMarkExtGroupDao dao = new TMarkExtGroupDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // GRP_ID 시퀀스 생성
        String grpId = seqUtil.getBizId();

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 데이터 준비
        xReq.setUserData("GRP_ID", grpId);
        xReq.setUserData("GRP_NO", seqUtil.getRefGrpNo("40"));

        // 상표해외출원품의 생성
        dao.createTMarkExtGroup(xReq);

        // 출원보상금 내역 저장
        rewardBiz.init(grpId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("APP_REWARD_GIVETARGET_YN"));
        rewardBiz.update("APP");

        // 등록보상금 내역 저장
        rewardBiz.init(grpId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("REG_REWARD_GIVETARGET_YN"));
        rewardBiz.update("REG");

        // 그룹 REF-NO 맵핑목록 저장
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        refBiz.updateRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE, xReq.getMultiData("ds_groupRefNoList"));

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(grpId, xReq.getMultiData("ds_inventorList"));

        // 상품류 맵핑목록 저장
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        tmarkBiz.updateTMarkClsList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_tmarkClsList"));

        //출원인 맵핑목록 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_appExpManCodeList"));

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        return grpId;
    }

    /**
     * 상표해외출원품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkExtGroup(AjaxRequest xReq) throws NException
    {
        TMarkExtGroupDao dao = new TMarkExtGroupDao(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String grpId = xReq.getParam("GRP_ID");

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 상표해외출원품의 수정
        dao.updateTMarkExtGroup(xReq);

        // 출원보상금 내역 저장
        rewardBiz.init(grpId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", mainInfo.getString("APP_REWARD_GIVETARGET_YN"));
        rewardBiz.setValue("REWARD_GIVE_AMOUNT", mainInfo.getString("APP_REWARD_GIVE_AMOUNT"));
        rewardBiz.setValue("REWARD_GIVE_DATE", mainInfo.getString("APP_REWARD_GIVE_DATE"));
        rewardBiz.update("APP");

        // 등록보상금 내역 저장
        rewardBiz.init(grpId);
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

        // 상품류 맵핑목록 저장
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        tmarkBiz.updateTMarkClsList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_tmarkClsList"));

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(grpId, MappingDiv.NONE, xReq.getMultiData("ds_appExpManCodeList"));

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }
}
