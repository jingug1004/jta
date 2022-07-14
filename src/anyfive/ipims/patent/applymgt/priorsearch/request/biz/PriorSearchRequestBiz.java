package anyfive.ipims.patent.applymgt.priorsearch.request.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.applymgt.priorsearch.request.dao.PriorSearchRequestDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.country.biz.CountryMappBiz;
import anyfive.ipims.patent.common.mapping.project.biz.ProjectMappBiz;
import anyfive.ipims.patent.common.mapping.tech.biz.TechCodeMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class PriorSearchRequestBiz extends NAbstractServletBiz
{
    public PriorSearchRequestBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 조사의뢰 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchRequestList(AjaxRequest xReq) throws NException
    {
        PriorSearchRequestDao dao = new PriorSearchRequestDao(this.nsr);

        return dao.retrievePriorSearchRequestList(xReq);
    }

    /**
     * 조사의뢰 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchRequest(AjaxRequest xReq) throws NException
    {
        PriorSearchRequestDao dao = new PriorSearchRequestDao(this.nsr);

        String prschId = xReq.getParam("PRSCH_ID");

        NSingleData result = new NSingleData();

        // 조사의뢰 조회
        result.set("ds_mainInfo", dao.retrievePriorSearchRequest(xReq));

        // 프로젝트 맵핑목록 조회
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        result.set("ds_projectList", pjtBiz.retrieveProjectList(prschId, MappingDiv.NONE));

        // 조사국가 맵핑목록 조회
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        result.set("ds_countryList", countryBiz.retrieveCountryList(prschId, MappingDiv.NONE));

        // 기술분류코드 맵핑목록 조회
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        result.set("ds_techCodeList", techBiz.retrieveTechCodeList(prschId, MappingDiv.NONE));

        return result;
    }

    /**
     * 조사의뢰 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createPriorSearchRequest(AjaxRequest xReq) throws NException
    {
        PriorSearchRequestDao dao = new PriorSearchRequestDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String prschId = seqUtil.getBizId();

        xReq.setUserData("PRSCH_ID", prschId);
        xReq.setUserData("PRSCH_NO", seqUtil.getPrschNo());
        xReq.setUserData("DEPT_CODE", SessionUtil.getUserInfo(this.nsr).getDeptCode());

        // 조사의뢰 생성
        dao.createPriorSearchRequest(xReq);

        // 프로젝트 맵핑목록 저장
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        pjtBiz.updateProjectList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_projectList"));

        // 조사국가 맵핑목록 저장
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        countryBiz.updateCountryList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_countryList"));

        // 기술분류코드 맵핑목록 저장
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        techBiz.updateTechCodeList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 의뢰서관련 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(prschId, WorkProcessConst.Step.PRIOR_SEARCH_REQUEST);

        return prschId;
    }

    /**
     * 조사의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePriorSearchRequest(AjaxRequest xReq) throws NException
    {
        PriorSearchRequestDao dao = new PriorSearchRequestDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String prschId = xReq.getParam("PRSCH_ID");

        // 조사의뢰 수정
        dao.updatePriorSearchRequest(xReq);

        // 프로젝트 맵핑목록 저장
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        pjtBiz.updateProjectList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_projectList"));

        // 조사국가 맵핑목록 저장
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        countryBiz.updateCountryList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_countryList"));

        // 기술분류코드 맵핑목록 저장
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        techBiz.updateTechCodeList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 의뢰서관련 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }

    /**
     * 조사의뢰 재작성(보완요청 확인)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void rewritePriorSearchRequest(AjaxRequest xReq) throws NException
    {
        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("PRSCH_ID"), WorkProcessConst.Action.REWRITE);
    }
}
