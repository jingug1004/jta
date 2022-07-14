package anyfive.ipims.patent.costmgt.slip.proc.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.costmgt.slip.proc.dao.SlipProcDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class SlipProcBiz extends NAbstractServletBiz
{

    public SlipProcBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 전표처리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSlipProcList(AjaxRequest xReq) throws NException
    {
        SlipProcDao dao = new SlipProcDao(this.nsr);

        return dao.retrieveSlipProcList(xReq);
    }

    /**
     * 전표처리 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createSlipProc(AjaxRequest xReq) throws NException
    {
        SlipProcDao dao = new SlipProcDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String slipId = seqUtil.getBizId();

        xReq.setUserData("SLIP_ID", slipId);

        dao.createSlipProc(xReq);

        if (xReq.getMultiData("ds_costSeqList") != null) {
            dao.updateSlipIdByCostSeq(xReq, xReq.getMultiData("ds_costSeqList"));
        }

        if (xReq.getMultiData("ds_consultIdList") != null) {
            dao.updateSlipIdByConsultId(xReq, xReq.getMultiData("ds_consultIdList"));
        }

        return slipId;
    }

    /**
     * 전표처리 상세 조회- 선급금,연차료일때
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSlipProc(AjaxRequest xReq) throws NException
    {
        SlipProcDao dao = new SlipProcDao(this.nsr);

        return dao.retrieveSlipProc(xReq);
    }

    /**
     * 전표처리 상세 조회- 자산,자본적 지출,출원포기일때
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSlipProcAssetNo(AjaxRequest xReq) throws NException
    {
        SlipProcDao dao = new SlipProcDao(this.nsr);

        return dao.retrieveSlipProcAssetNo(xReq);
    }

    /**
     * 전표처리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSlipProc(AjaxRequest xReq) throws NException
    {
        SlipProcDao dao = new SlipProcDao(this.nsr);
        NMultiData costInfo = dao.retrieveCostSeq(xReq);

        dao.updateSlipProc(xReq);

        if (costInfo != null) {

            for(int i=0; i < costInfo.getRowSize(); i++) {
                String costId = costInfo.getString(i, "COST_SEQ");
                String superTax = costInfo.getString(i, "SUPER_TAX");
                dao.updateSlipIf(xReq, costId, superTax);
            }
        }

    }

    /**
     * 전표처리- 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteSlipProc(AjaxRequest xReq) throws NException
    {
        SlipProcDao dao = new SlipProcDao(this.nsr);

        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String tempId = seqUtil.getBizId();

        String slipKind = xReq.getParam("SLIP_KIND");

        xReq.setUserData("TEMP_ID", tempId);

        // ERP 상태값 수정 -> IF_COST_SLIP : FLAG - D
        dao.updateErpFlagToD(xReq);

        if("S".equals(slipKind)) {
            // ERP 자산번호 TEMP 테이블 생성
            dao.createAssetTemp(xReq);
            // ERP 자산번호 IF 테이블 삭제
            dao.deleteAssetNo(xReq);
            // 출원마스터 자산번호 NULL
            dao.updateMasterAssetNoToNull(xReq);
        }

        // 비용마스터 전표ID 제거
        dao.updateCostMasterSlipIdToNull(xReq);

        // 전표 삭제
        dao.deleteSlipProc(xReq);

    }

    /**
     * 전표 완료처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSlipProcConfirm(AjaxRequest xReq) throws NException
    {

        SlipProcDao dao = new SlipProcDao(this.nsr);
        NMultiData costInfo = dao.retrieveCostSeq(xReq);

        if (costInfo != null) {

            for(int i=0; i < costInfo.getRowSize(); i++) {
                SequenceUtil seqUtil = new SequenceUtil(this.nsr);
                String costId =  null;
                String ifId = seqUtil.getBizId();
                xReq.setUserData("IF_SLIP_ID", ifId);

                costId = costInfo.getString(i, "COST_SEQ");
                dao.createSlipIF(xReq, costId);
            }
        }


    }

    /**
     * 전표 취소
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void CanCelSap(AjaxRequest xReq) throws NException
    {
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String tempId = seqUtil.getBizId();

        xReq.setUserData("TEMP_ID", tempId);

        String slipKind = xReq.getParam("SLIP_KIND");

        SlipProcDao dao = new SlipProcDao(this.nsr);

            // 전표 삭제
            dao.updateCostSapDelete(xReq);


            if("S".equals(slipKind)) {
                // ERP 자산번호 TEMP 테이블 생성
                dao.createAssetTemp(xReq);
                // ERP 자산번호 IF 테이블 삭제
                dao.deleteAssetNo(xReq);
                // 출원마스터 자산번호 NULL
                dao.updateMasterAssetNoToNull(xReq);
            }

            // 전표처리상태'1', 전표ID 삭제
            dao.updateCostStateId(xReq);
            // 비용수정 SLIP_STATUS = (처리대상)
            dao.updateCostMasterSlipStatusTaget(xReq);
            // ERP 전표 삭제 상태값 수정
            dao.updateErpFlagToD(xReq);
    }

    /**
     * 자산번호 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void CreateAssetNo(AjaxRequest xReq) throws NException
    {
        SlipProcDao dao = new SlipProcDao(this.nsr);

        String deptCode = SessionUtil.getUserInfo(this.nsr).getDeptCode();

        // 전송데이터
        NSingleData assetInfo = dao.retriveAssetInfo(xReq, deptCode);

        String refId = assetInfo.getString("REF_ID");

        // 자산번호 업데이트
        dao.createAssetNo(xReq, refId);

    }
}
