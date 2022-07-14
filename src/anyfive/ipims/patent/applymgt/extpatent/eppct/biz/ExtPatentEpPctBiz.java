package anyfive.ipims.patent.applymgt.extpatent.eppct.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.extpatent.eppct.dao.ExtPatentEpPctDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.olcountry.biz.OLCountryMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ExtPatentEpPctBiz extends NAbstractServletBiz
{
    public ExtPatentEpPctBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * EP/PCT OL 모출원 서지사항 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentEpPctPrior(AjaxRequest xReq) throws NException
    {
        ExtPatentEpPctDao dao = new ExtPatentEpPctDao(this.nsr);

        NSingleData result = new NSingleData();

        // 모출원 서지사항 조회
        NSingleData priorInfo = dao.retrieveExtPatentEpPctPrior(xReq.getParam("DIVISION_PRIOR_REF_ID"));
        result.set("ds_priorInfo", priorInfo);

        String grpId = priorInfo.getString("GRP_ID");

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        return result;
    }

    /**
     * EP/PCT OL 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentEpPct(AjaxRequest xReq) throws NException
    {
        ExtPatentEpPctDao dao = new ExtPatentEpPctDao(this.nsr);

        NSingleData result = new NSingleData();

        String olId = xReq.getParam("OL_ID");

        // EP/PCT OL 조회
        NSingleData mainInfo = dao.retrieveExtPatentEpPct(xReq);
        result.set("ds_mainInfo", mainInfo);

        String priorRefId = mainInfo.getString("DIVISION_PRIOR_REF_ID");

        // 모출원 서지사항 조회
        NSingleData priorInfo = dao.retrieveExtPatentEpPctPrior(priorRefId);
        result.set("ds_priorInfo", priorInfo);

        String grpId = priorInfo.getString("GRP_ID");

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // EP/PCT OL정보 조회
        result.set("ds_mainInfo", dao.retrieveExtPatentEpPct(xReq));

        // OL국가 맵핑목록 조회
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        result.set("ds_olCountryList", olCountryBiz.retrieveOLCountryList(olId));

        return result;
    }

    /**
     * EP/PCT OL 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createExtPatentEpPct(AjaxRequest xReq) throws NException
    {
        ExtPatentEpPctDao dao = new ExtPatentEpPctDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // OL_ID 시퀀스 생성
        String olId = seqUtil.getBizId();

        // 데이터 준비
        xReq.setUserData("OL_ID", olId);

        // EP/PCT OL 생성
        dao.createExtPatentEpPct(xReq);

        // OL국가 맵핑목록 저장
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        olCountryBiz.updateOLCountryList(olId, xReq.getMultiData("ds_olCountryList"));

        // 참조파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(olId, WorkProcessConst.Step.EXT_PATENT_EPPCT_OL);

        return olId;
    }

    /**
     * EP/PCT OL 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtPatentEpPct(AjaxRequest xReq) throws NException
    {
        ExtPatentEpPctDao dao = new ExtPatentEpPctDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // EP/PCT OL 수정
        dao.updateExtPatentEpPct(xReq);

        // 참조파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }
}
