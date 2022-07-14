package anyfive.ipims.patent.common.approvaladdon.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.approval.util.ApprovalEvents;
import anyfive.ipims.patent.common.approvaladdon.dao.ApprovalD03Dao;
import anyfive.ipims.patent.common.approvaladdon.util.ApprovalAbstractBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;

public class ApprovalD03Biz extends NAbstractServletBiz implements ApprovalAbstractBiz
{
    public ApprovalD03Biz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외디자인출원 신규OL 결재처리
     *
     * @param apprNo
     * @param apprEvent
     * @param apprMgt
     * @throws NException
     */
    public void execute(String apprNo, NSingleData apprKey, short apprEvent, NSingleData apprMgt) throws NException
    {
        // 결재없음 또는 최종승인시
        if (apprEvent == ApprovalEvents.NONE || apprEvent == ApprovalEvents.AGREEALL) {
            this.executeAgreeAll(apprKey);
        }
    }

    /**
     * 결재없음 또는 최종승인 처리
     *
     * @param apprKey
     * @throws NException
     */
    private void executeAgreeAll(NSingleData apprKey) throws NException
    {
        ApprovalD03Dao dao = new ApprovalD03Dao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        // 오더레터 출원국가 목록 조회
        NMultiData olCountryList = dao.retrieveExtNewOLCountryList(apprKey);

        String refId = null;
        String countryCode = null;

        for (int i = 0; i < olCountryList.getRowSize(); i++) {
            refId = seqUtil.getBizId();
            countryCode = olCountryList.getString(i, "COUNTRY_CODE");

            // 디자인마스터 생성
            dao.createDesignMaster(apprKey, refId, countryCode);

            // 오더레터 출원국가 업데이트(REF_ID)
            dao.updateExtNewOLCountry(apprKey, refId, countryCode);

            // 진행서류 생성
            docBiz.init(refId);
            docBiz.setEvent("OFFICE_REQUEST");
            docBiz.create(true);
        }

        // 오더레터 업데이트(사무소송부일)
        dao.updateExtNewOrderLetter(apprKey);
    }
}
