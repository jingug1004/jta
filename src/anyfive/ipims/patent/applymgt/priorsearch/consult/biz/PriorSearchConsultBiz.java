package anyfive.ipims.patent.applymgt.priorsearch.consult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.applymgt.priorsearch.consult.dao.PriorSearchConsultDao;
import anyfive.ipims.patent.applymgt.priorsearch.request.dao.PriorSearchRequestDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.country.biz.CountryMappBiz;
import anyfive.ipims.patent.common.mapping.project.biz.ProjectMappBiz;
import anyfive.ipims.patent.common.mapping.tech.biz.TechCodeMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class PriorSearchConsultBiz extends NAbstractServletBiz
{
    public PriorSearchConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 조사의뢰품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchConsultList(AjaxRequest xReq) throws NException
    {
        PriorSearchConsultDao dao = new PriorSearchConsultDao(this.nsr);

        return dao.retrievePriorSearchConsultList(xReq);
    }

    /**
     * 조사의뢰품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchConsult(AjaxRequest xReq) throws NException
    {
        PriorSearchConsultDao dao = new PriorSearchConsultDao(this.nsr);

        String refId = xReq.getParam("PRSCH_ID");

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrievePriorSearchConsult(xReq));

        // 프로젝트 맵핑목록
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        result.set("ds_projectList", pjtBiz.retrieveProjectList(refId, MappingDiv.NONE));

        // 조사국가 맵핑목록
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        result.set("ds_countryList", countryBiz.retrieveCountryList(refId, MappingDiv.NONE));

        // 기술분류코드 맵핑목록
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        result.set("ds_techCodeList", techBiz.retrieveTechCodeList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 조사의뢰품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createPriorSearchConsult(AjaxRequest xReq) throws NException
    {
        PriorSearchConsultDao dao = new PriorSearchConsultDao(this.nsr);
        PriorSearchRequestDao reqDao = new PriorSearchRequestDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String prschId = seqUtil.getBizId();
        String refId = xReq.getParam("REF_ID");

        xReq.setUserData("PRSCH_ID", prschId);
        xReq.setUserData("PRSCH_NO", seqUtil.getPrschNo());
        xReq.setUserData("DEPT_CODE", SessionUtil.getUserInfo(this.nsr).getDeptCode());

        // 조사의뢰서 생성
        reqDao.createPriorSearchRequest(xReq);

        // 조사의뢰서 업데이트
        dao.updatePriorSearchRequest(prschId);

        // 조사품의서 생성
        dao.createPriorSearchConsult(xReq);

        // 선행조사 - 출원 맵핑목록 생성
        if (refId.equals("") != true) {
            dao.createPriorSearchApplyMapp(refId, MappingDiv.NONE, prschId);
        }

        // 프로젝트 맵핑목록 저장
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        pjtBiz.updateProjectList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_projectList"));

        // 조사국가 맵핑목록 저장
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        countryBiz.updateCountryList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_countryList"));

        // 기술분류코드 맵핑목록 저장
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        techBiz.updateTechCodeList(prschId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(prschId, WorkProcessConst.Step.PRIOR_SEARCH_CONSULT);

        return prschId;
    }

    /**
     * 조사의뢰품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePriorSearchConsult(AjaxRequest xReq) throws NException
    {
        PriorSearchConsultDao dao = new PriorSearchConsultDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 조사의뢰품의 수정
        dao.updatePriorSearchConsult(xReq);

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFileConsult"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("PRSCH_ID"), WorkProcessConst.Action.WRITE, true);
    }
}
