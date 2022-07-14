package anyfive.ipims.patent.applymgt.tmark.intmasterrenew.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.intmasterrenew.dao.TMarkIntMasterRenewDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.tmarkcls.biz.TMarkClsMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class TMarkIntMasterRenewBiz extends NAbstractServletBiz
{
    public TMarkIntMasterRenewBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내출원마스터 갱신
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createTMarkIntMasterRenew(AjaxRequest xReq) throws NException
    {
        TMarkIntMasterRenewDao dao = new TMarkIntMasterRenewDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");

        // REF_ID 시퀀스 생성
        String newRefId = seqUtil.getBizId();

        // 상표국내출원마스터 갱신정보 조회
        NSingleData renewalInfo = dao.retrieveTMarkIntMasterRenewInfo(xReq);

        // 데이터 준비
        xReq.setUserData("NEW_REF_ID", newRefId);
        xReq.setUserData("NEW_REF_NO", renewalInfo.getString("REF_NO") + renewalInfo.getString("DIVISION_CODE"));
        xReq.setUserData("DIVISION_CODE", renewalInfo.getString("DIVISION_CODE"));
        xReq.setUserData("DIVISION_LEVEL", renewalInfo.getString("DIVISION_LEVEL"));

        // 상표국내출원마스터 갱신 생성
        dao.createTMarkIntMasterRenew(xReq);

        // 상표국내출원품의서 갱신 생성
        dao.createTMarkIntConsultRenew(xReq);

        // 상표국내출원의뢰서 갱신 생성
        dao.createTMarkIntRequestRenew(xReq);

        // 발명자 맵핑목록 복제
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.duplicateInventorList(refId, newRefId);

        // 상품류 맵핑목록 복제
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        tmarkBiz.duplicateTMarkClsList(refId, MappingDiv.NONE, newRefId, MappingDiv.NONE);

        // 진행서류 생성
        docBiz.init(newRefId);
        docBiz.setEvent("TMARK_RENEWAL");
        docBiz.create();

        return newRefId;
    }
}
