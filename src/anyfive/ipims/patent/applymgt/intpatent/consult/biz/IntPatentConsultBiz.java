package anyfive.ipims.patent.applymgt.intpatent.consult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.intpatent.consult.dao.IntPatentConsultDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.prod.biz.ProdCodeMappBiz;
import anyfive.ipims.patent.common.mapping.project.biz.ProjectMappBiz;
import anyfive.ipims.patent.common.mapping.prsch.biz.PrschMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.patent.common.mapping.tech.biz.TechCodeMappBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class IntPatentConsultBiz extends NAbstractServletBiz
{
    public IntPatentConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내출원품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConsultList(AjaxRequest xReq) throws NException
    {
        IntPatentConsultDao dao = new IntPatentConsultDao(this.nsr);

        return dao.retrieveIntPatentConsultList(xReq);
    }

    /**
     * 국내출원품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConsult(AjaxRequest xReq) throws NException
    {
        IntPatentConsultDao dao = new IntPatentConsultDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 국내출원품의 조회
        result.set("ds_mainInfo", dao.retrieveIntPatentConsult(xReq));

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

        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);

        // 인용REF 맵핑목록 조회
        result.set("ds_referRefNoList", refBiz.retrieveRefNoList(refId, MappingKind.REFER, MappingDiv.NONE));

        // 우선권번호 맵핑목록 조회
        result.set("ds_priorRefNoList", refBiz.retrieveRefNoList(refId, MappingKind.PRIOR, MappingDiv.NONE));

        // 병합출원 맵핑목록 조회
        result.set("ds_unionRefNoList", refBiz.retrieveRefNoList(refId, MappingKind.UNION, MappingDiv.NONE));

        // 선행조사 맵핑목록 조회
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        result.set("ds_prschList", prschBiz.retrievePrschList(refId, MappingDiv.NONE));

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appManCodeList", appmc.retrieveAppManCodeList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 국내출원품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntPatentConsult(AjaxRequest xReq) throws NException
    {
        IntPatentConsultDao dao = new IntPatentConsultDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // REF_ID 시퀀스 생성
        String refId = xReq.getParam("REF_ID");

        // 국내출원품의 저장
        dao.updateIntPatentConsult(xReq);

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

        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);

        // 우선권번호 맵핑목록 저장
        refBiz.updateRefNoList(refId, MappingKind.PRIOR, MappingDiv.NONE, xReq.getMultiData("ds_priorRefNoList"));

        // 병합출원 맵핑목록 저장
        refBiz.updateRefNoList(refId, MappingKind.UNION, MappingDiv.NONE, xReq.getMultiData("ds_unionRefNoList"));

        // 선행조사 맵핑목록 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

        // 직무발명신고서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_docFile"));

        // 선행기술자료 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_prschFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(refId, WorkProcessConst.Action.WRITE, true);

        // 출원인 맵칭 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));

    }
}
