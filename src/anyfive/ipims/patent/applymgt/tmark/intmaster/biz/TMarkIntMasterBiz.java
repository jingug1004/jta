package anyfive.ipims.patent.applymgt.tmark.intmaster.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.common.biz.ApplyMgtCommonBiz;
import anyfive.ipims.patent.applymgt.tmark.intmaster.dao.TMarkIntMasterDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.tmarkcls.biz.TMarkClsMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;

public class TMarkIntMasterBiz extends NAbstractServletBiz
{
    public TMarkIntMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내출원마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntMasterList(AjaxRequest xReq) throws NException
    {
        TMarkIntMasterDao dao = new TMarkIntMasterDao(this.nsr);

        return dao.retrieveTMarkIntMasterList(xReq);
    }

    /**
     * 상표국내출원마스터 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntMaster(AjaxRequest xReq) throws NException
    {
        TMarkIntMasterDao dao = new TMarkIntMasterDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 상표국내출원마스터 조회
        result.set("ds_mainInfo", dao.retrieveTMarkIntMaster(xReq));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        // 상품류 맵핑목록 조회
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        result.set("ds_tmarkClsList", tmarkBiz.retrieveTMarkClsList(refId, MappingDiv.NONE));

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appManCodeList", appmc.retrieveAppManCodeList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 상표국내출원마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkIntMaster(AjaxRequest xReq) throws NException
    {
        TMarkIntMasterDao dao = new TMarkIntMasterDao(this.nsr);
        ApplyMgtCommonBiz appBiz = new ApplyMgtCommonBiz(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");
        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 건담당자 변경시 진행서류 추가
        appBiz.createMasterJobManChangePaper(refId, mainInfo.getString("JOB_MAN"));

        // 사무소 변경시 진행서류 추가
        appBiz.createMasterOfficeCodeChangePaper(refId, mainInfo.getString("OFFICE_CODE"));

        // 상표국내출원마스터 수정
        dao.updateTMarkIntMaster(xReq);

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 상품류 맵핑목록 저장
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        tmarkBiz.updateTMarkClsList(refId, MappingDiv.NONE, xReq.getMultiData("ds_tmarkClsList"));

        // 상표이미지 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_tmarkImgFile"));

        // 기타자료 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));

        // 출원서파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_appdocFile"));

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));
    }

    /**
     * 상표국내출원마스터 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createTMarkIntMaster(AjaxRequest xReq) throws NException
    {
        TMarkIntMasterDao dao = new TMarkIntMasterDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // REF_ID 시퀀스 생성
        String refId = seqUtil.getBizId();

        // 데이터 준비
        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", seqUtil.getRefGrpNo("40"));

        // 상표국내출원마스터 작성
        dao.createTMarkIntMaster(xReq);

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 상품류 맵핑목록 저장
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        tmarkBiz.updateTMarkClsList(refId, MappingDiv.NONE, xReq.getMultiData("ds_tmarkClsList"));

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));

        // 상표이미지 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_tmarkImgFile"));

        // 기타자료 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));

        return refId;
    }
}
