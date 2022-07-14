package anyfive.ipims.patent.applymgt.intpatent.request.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.applymgt.intpatent.request.dao.IntPatentRequestDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.prod.biz.ProdCodeMappBiz;
import anyfive.ipims.patent.common.mapping.project.biz.ProjectMappBiz;
import anyfive.ipims.patent.common.mapping.prsch.biz.PrschMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.patent.common.mapping.tech.biz.TechCodeMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class IntPatentRequestBiz extends NAbstractServletBiz
{
    public IntPatentRequestBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내특허 출원의뢰 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentRequestList(AjaxRequest xReq) throws NException
    {
        IntPatentRequestDao dao = new IntPatentRequestDao(this.nsr);

        return dao.retrieveIntPatentRequestList(xReq);
    }

    /**
     * 국내특허 출원의뢰 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentRequest(AjaxRequest xReq) throws NException
    {
        IntPatentRequestDao dao = new IntPatentRequestDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 국내특허 출원의뢰서 조회
        result.set("ds_mainInfo", dao.retrieveIntPatentRequest(xReq));

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

        // 인용REF 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_referRefNoList", refBiz.retrieveRefNoList(refId, MappingKind.REFER, MappingDiv.NONE));

        // 선행조사 맵핑목록 조회
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        result.set("ds_prschList", prschBiz.retrievePrschList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 국내특허 출원의뢰 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createIntPatentRequest(AjaxRequest xReq) throws NException
    {
        IntPatentRequestDao dao = new IntPatentRequestDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // REF_ID 시퀀스 생성
        String refId = seqUtil.getBizId();

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // 데이터 준비
        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", seqUtil.getRefGrpNo(mainInfo.getString("RIGHT_DIV")));
        xReq.setUserData("DIVISN_CODE", SessionUtil.getUserInfo(this.nsr).getDivisnCode());
        xReq.setUserData("DEPT_CODE", SessionUtil.getUserInfo(this.nsr).getDeptCode());

        // 국내특허 출원의뢰서 생성
        dao.createIntPatentRequest(xReq);

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

        // 인용REF 맵핑목록 저장
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        refBiz.updateRefNoList(refId, MappingKind.REFER, MappingDiv.NONE, xReq.getMultiData("ds_referRefNoList"));

        // 선행조사 맵핑목록 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

        // 직무발명신고서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_docFile"));

        // 선행기술자료 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_prschFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(refId, WorkProcessConst.Step.INT_PATENT_REQUEST);

        return refId;
    }

    /**
     * 국내특허 출원의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateIntPatentRequest(AjaxRequest xReq) throws NException
    {
        IntPatentRequestDao dao = new IntPatentRequestDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");

        // 국내특허 출원의뢰서 수정
        dao.updateIntPatentRequest(xReq);

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

        // 인용REF 맵핑목록 저장
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        refBiz.updateRefNoList(refId, MappingKind.REFER, MappingDiv.NONE, xReq.getMultiData("ds_referRefNoList"));

        // 선행조사 맵핑목록 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

        // 직무발명신고서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_docFile"));

        // 선행기술자료 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_prschFile"));
    }

    /**
     * 국내특허 출원의뢰 재작성(보완요청 확인)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void rewriteIntPatentRequest(AjaxRequest xReq) throws NException
    {
        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("REF_ID"), WorkProcessConst.Action.REWRITE);
    }


    /**
     * 양도증 확인 여부
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createPatentConveyChk(AjaxRequest xReq) throws NException
    {
        IntPatentRequestDao dao = new IntPatentRequestDao(this.nsr);

        // 양도증 확인 여부 등록
        dao.createPatentConveyChk(xReq);
    }
}
