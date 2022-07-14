package anyfive.ipims.patent.applymgt.design.intrequest.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.applymgt.design.intrequest.dao.DesignIntRequestDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.country.biz.CountryMappBiz;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class DesignIntRequestBiz extends NAbstractServletBiz
{
    public DesignIntRequestBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인국내출원의뢰 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntRequestList(AjaxRequest xReq) throws NException
    {
        DesignIntRequestDao dao = new DesignIntRequestDao(this.nsr);

        return dao.retrieveDesignIntRequestList(xReq);
    }

    /**
     * 디자인국내출원의뢰 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntRequest(AjaxRequest xReq) throws NException
    {
        DesignIntRequestDao dao = new DesignIntRequestDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 국내디자인 출원의뢰
        result.set("ds_mainInfo", dao.retrieveDesignIntRequest(xReq));

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        // 출원예상국가 맵핑목록 조회
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        result.set("ds_countryList", countryBiz.retrieveCountryList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 디자인국내출원의뢰 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createDesignIntRequest(AjaxRequest xReq) throws NException
    {
        DesignIntRequestDao dao = new DesignIntRequestDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = seqUtil.getBizId();

        // 데이터준비
        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", seqUtil.getRefGrpNo("30"));
        xReq.setUserData("DIVISN_CODE", SessionUtil.getUserInfo(this.nsr).getDivisnCode());
        xReq.setUserData("DEPT_CODE", SessionUtil.getUserInfo(this.nsr).getDeptCode());

        // 디자인국내출원의뢰 생성
        dao.createDesignIntRequest(xReq);

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 출원예상국가 맵핑목록 저장
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        countryBiz.updateCountryList(refId, MappingDiv.NONE, xReq.getMultiData("ds_countryList"));

        // 디자인이미지 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_designImgFile"));

        // 6면도 및 사시도 또는 의장출원품의서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));

        // 디자인 신고서
        fileBiz.updateFileList(xReq.getMultiData("ds_docFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(refId, WorkProcessConst.Step.INT_DESIGN_REQUEST);

        return refId;
    }

    /**
     * 디자인국내출원의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDesignIntRequest(AjaxRequest xReq) throws NException
    {
        DesignIntRequestDao dao = new DesignIntRequestDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");

        // 디자인국내출원의뢰 수정
        dao.updateDesignIntRequest(xReq);

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 출원예상국가 맵핑목록 저장
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        countryBiz.updateCountryList(refId, MappingDiv.NONE, xReq.getMultiData("ds_countryList"));

        // 디자인이미지 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_designImgFile"));

        // 6면도 및 사시도 또는 의장출원품의서 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));

        // 디자인 신고서
        fileBiz.updateFileList(xReq.getMultiData("ds_docFile"));
    }

    /**
     * 디자인국내출원의뢰 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteDesignIntRequest(AjaxRequest xReq) throws NException
    {
        DesignIntRequestDao dao = new DesignIntRequestDao(this.nsr);

        // 디자인국내출원의뢰 삭제
        dao.deleteDesignIntRequest(xReq);
    }

    /**
     * 디자인국내출원의뢰 재작성(보완요청 확인)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void rewriteDesignIntRequest(AjaxRequest xReq) throws NException
    {
        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("REF_ID"), WorkProcessConst.Action.REWRITE);
    }
}
