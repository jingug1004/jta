package anyfive.ipims.patent.applymgt.extpatent.orderletter.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.extpatent.orderletter.dao.ExtPatentOrderLetterDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.olcountry.biz.OLCountryMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ExtPatentOrderLetterBiz extends NAbstractServletBiz
{
    public ExtPatentOrderLetterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 오더레터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentOrderLetterList(AjaxRequest xReq) throws NException
    {
        ExtPatentOrderLetterDao dao = new ExtPatentOrderLetterDao(this.nsr);

        return dao.retrieveExtPatentOrderLetterList(xReq);
    }

    /**
     * 오더레터 그룹정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentOrderLetterGroup(AjaxRequest xReq) throws NException
    {
        ExtPatentOrderLetterDao dao = new ExtPatentOrderLetterDao(this.nsr);

        String grpId = xReq.getParam("GRP_ID");

        NSingleData result = new NSingleData();

        // 오더레터 그룹정보 조회
        result.set("ds_groupInfo", dao.retrieveExtPatentOrderLetterGroup(grpId));

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        return result;
    }

    /**
     * 오더레터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentOrderLetter(AjaxRequest xReq) throws NException
    {
        ExtPatentOrderLetterDao dao = new ExtPatentOrderLetterDao(this.nsr);

        NSingleData result = new NSingleData();

        String olId = xReq.getParam("OL_ID");

        // 오더레터 조회
        NSingleData mainInfo = dao.retrieveExtPatentOrderLetter(xReq);
        result.set("ds_mainInfo", mainInfo);

        String grpId = mainInfo.getString("GRP_ID");

        // 오더레터 그룹정보 조회
        result.set("ds_groupInfo", dao.retrieveExtPatentOrderLetterGroup(grpId));

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        // OL국가 맵핑목록 조회
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        result.set("ds_olCountryList", olCountryBiz.retrieveOLCountryList(olId));

        return result;
    }

    /**
     * 오더레터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createExtPatentOrderLetter(AjaxRequest xReq) throws NException
    {
        ExtPatentOrderLetterDao dao = new ExtPatentOrderLetterDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // OL_ID 시퀀스 생성
        String olId = seqUtil.getBizId();

        // 데이터 준비
        xReq.setUserData("OL_ID", olId);

        // 오더레터 생성
        dao.createExtPatentOrderLetter(xReq);

        // OL국가 맵핑목록 저장
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        olCountryBiz.updateOLCountryList(olId, xReq.getMultiData("ds_olCountryList"));

        // 참조파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(olId, WorkProcessConst.Step.EXT_PATENT_NEW_OL);

        return olId;
    }

    /**
     * 오더레터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtPatentOrderLetter(AjaxRequest xReq) throws NException
    {
        ExtPatentOrderLetterDao dao = new ExtPatentOrderLetterDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String olId = xReq.getParam("OL_ID");

        // 오더레터 수정
        dao.updateExtPatentOrderLetter(xReq);

        // OL국가 맵핑목록 저장
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        olCountryBiz.updateOLCountryList(olId, xReq.getMultiData("ds_olCountryList"));

        // 참조파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }
}
