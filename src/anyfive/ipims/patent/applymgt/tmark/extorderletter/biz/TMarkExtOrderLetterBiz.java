package anyfive.ipims.patent.applymgt.tmark.extorderletter.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.tmark.extorderletter.dao.TMarkExtOrderLetterDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.olcountry.biz.OLCountryMappBiz;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class TMarkExtOrderLetterBiz extends NAbstractServletBiz
{
    public TMarkExtOrderLetterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표해외출원OL 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtOrderLetterList(AjaxRequest xReq) throws NException
    {
        TMarkExtOrderLetterDao dao = new TMarkExtOrderLetterDao(this.nsr);

        return dao.retrieveExtTMarkOrderLetterList(xReq);
    }

    /**
     * 상표 오더레터 그룹정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtOrderLetterGroup(AjaxRequest xReq) throws NException
    {
        TMarkExtOrderLetterDao dao = new TMarkExtOrderLetterDao(this.nsr);

        String grpId = xReq.getParam("GRP_ID");

        NSingleData result = new NSingleData();

        // 오더레터 그룹정보 조회
        result.set("ds_groupInfo", dao.retrieveTMarkExtOrderLetterGroup(grpId));

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        return result;
    }

    /**
     * 상표해외출원OL 상세조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtOrderLetter(AjaxRequest xReq) throws NException
    {
        TMarkExtOrderLetterDao dao = new TMarkExtOrderLetterDao(this.nsr);

        NSingleData result = new NSingleData();
        String olId = xReq.getParam("OL_ID");

        // 오더레터 조회
        NSingleData mainInfo = dao.retrieveTMarkExtOrderLetter(xReq);
        result.set("ds_mainInfo", mainInfo);

        String grpId = mainInfo.getString("GRP_ID");

        // 오더레터 그룹정보 조회
        result.set("ds_groupInfo", dao.retrieveTMarkExtOrderLetterGroup(grpId));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(grpId));

        // OL국가 맵핑목록 조회
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        result.set("ds_olCountryList", olCountryBiz.retrieveOLCountryList(olId));

        return result;
    }

    /**
     * 상표해외출원품의 신규OL 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createTMarkExtOrderLetter(AjaxRequest xReq) throws NException
    {
        TMarkExtOrderLetterDao dao = new TMarkExtOrderLetterDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // OL_ID 시퀀스 생성
        String olId = seqUtil.getBizId();

        // 데이터 준비
        xReq.setUserData("OL_ID", olId);

        // 오더레터 생성
        dao.createTMarkExtOrderLetter(xReq);

        // OL국가 맵핑목록 저장
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        olCountryBiz.updateOLCountryList(olId, xReq.getMultiData("ds_olCountryList"));

        // 참조파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(olId, WorkProcessConst.Step.EXT_TMARK_NEW_OL);

        return olId;
    }

    /**
     * 상표해외출원OL 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkExtOrderLetter(AjaxRequest xReq) throws NException
    {
        TMarkExtOrderLetterDao dao = new TMarkExtOrderLetterDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String olId = xReq.getParam("OL_ID");

        // 국내특허 출원의뢰서 수정
        dao.updateTMarkExtOrderLetter(xReq);

        // OL국가 맵핑목록 저장
        OLCountryMappBiz olCountryBiz = new OLCountryMappBiz(this.nsr);
        olCountryBiz.updateOLCountryList(olId, xReq.getMultiData("ds_olCountryList"));

        // 참조파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }
}
