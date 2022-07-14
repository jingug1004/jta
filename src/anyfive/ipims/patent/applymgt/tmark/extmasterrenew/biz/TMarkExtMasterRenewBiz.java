package anyfive.ipims.patent.applymgt.tmark.extmasterrenew.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.extmasterrenew.dao.TMarkExtMasterRenewDao;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class TMarkExtMasterRenewBiz extends NAbstractServletBiz
{
    public TMarkExtMasterRenewBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표해외출원마스터 갱신
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createTMarkExtMasterRenew(AjaxRequest xReq) throws NException
    {
        TMarkExtMasterRenewDao dao = new TMarkExtMasterRenewDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // REF_ID 시퀀스 생성
        String newRefId = seqUtil.getBizId();

        // 상표해외출원마스터 갱신정보 조회
        NSingleData renewalInfo = dao.retrieveTMarkExtMasterRenewInfo(xReq);

        // 데이터 준비
        xReq.setUserData("NEW_REF_ID", newRefId);
        xReq.setUserData("NEW_REF_NO", renewalInfo.getString("REF_NO") + renewalInfo.getString("DIVISION_CODE"));
        xReq.setUserData("DIVISION_CODE", renewalInfo.getString("DIVISION_CODE"));
        xReq.setUserData("DIVISION_LEVEL", renewalInfo.getString("DIVISION_LEVEL"));

        // 상표해외출원마스터 갱신 생성
        dao.createTMarkExtMasterRenew(xReq);

        // 진행서류 생성
        docBiz.init(newRefId);
        docBiz.setEvent("TMARK_RENEWAL");
        docBiz.create();

        return newRefId;
    }
}
