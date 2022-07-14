package anyfive.ipims.patent.costmgt.slip.proc.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class SlipProcDao extends NAbstractServletDao
{
    public SlipProcDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retrieveSlipProcList");
        dao.bind(xReq);

        // 전표제목
        if (xReq.getParam("SLIP_SUBJECT").equals("") != true) {
            dao.addQuery("slipSubject");
        }

        // 전표종류
        if (xReq.getParam("SLIP_KIND").equals("") != true) {
            dao.addQuery("slipKind");
        }

        // 처리상태
        if (xReq.getParam("ACCOUNT_PROC_YN").equals("") != true) {
            dao.addQuery("accountProcYn");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 비용 전표 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createSlipProc(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/createSlipProc");
        dao.bind(xReq);

        return dao.executeUpdate();
    }


    /**
     * 비용 인터페이스 전표 작성 - ERP
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createSlipIF(AjaxRequest xReq, String costId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/createSlipIF");
        dao.bind("COST_SEQ", costId);
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용목록 전표ID(SLIP_ID) 수정 - COST_SEQ별
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSlipIdByCostSeq(AjaxRequest xReq, NMultiData updateList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateSlipIdByCostSeq");
        dao.bind(xReq);

        dao.executeBatch(updateList);
    }

    /**
     * 비용목록 전표ID(SLIP_ID) 수정 - CONSULT_ID별
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSlipIdByConsultId(AjaxRequest xReq, NMultiData updateList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateSlipIdByConsultId");
        dao.bind(xReq);

        dao.executeBatch(updateList);
    }

    /**
     * 전표전송 대상조회 - 선급금
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retriveSlipInfoCost(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retriveSlipInfoCost");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 전표전송 대상조회 - 자산/자본적지출
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retriveSlipInfoAsset(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retriveSlipInfoAsset");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 전표전송 대상조회 - 출원포기
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retriveSlipInfoReject(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retriveSlipInfoReject");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 전표전송 대상조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveCostSeq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retrieveCostSeq");
        dao.bind(xReq);

        return dao.executeQuery();
    }


    /**
     * 전표전송 대상조회 - 연차료
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retriveSlipInfo(AjaxRequest xReq,String deptCode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retriveSlipInfo");
        dao.bind("DEPT_CODE", deptCode);
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 전표전송 대상조회 - 수수료
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retriveSlipInfoTax(AjaxRequest xReq,String deptCode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retriveSlipInfoTax");
        dao.bind("DEPT_CODE", deptCode);
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 전표처리 상세조회 - 선급금,연차료일때
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSlipProc(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retrieveSlipProc");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 전표처리 상세조회 - 자산,자본적 지출,출원포기일때
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSlipProcAssetNo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retrieveSlipProcAssetNo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 전표처리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateSlipProc(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateSlipProc");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 전표처리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateSlipIf(AjaxRequest xReq, String costId, String superTax) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateSlipIF");
        dao.bind("COST_SEQ", costId);
        dao.bind("SUPER_TAX", superTax);
        dao.bind(xReq);

        return dao.executeUpdate();
    }


    /**
     * 전표처리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteSlipProc(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/deleteSlipProc");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용마스터 전표ID 제거
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostMasterSlipIdToNull(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateCostMasterSlipIdToNull");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 출원마스터 자산번호 제거
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateMasterAssetNoToNull(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateMasterAssetNoToNull");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * ERP 전표 제거 상태값 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateErpFlagToD(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateErpFlagToD");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * ERP 자산번호 TEMP 테이블 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createAssetTemp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/createAssetTemp");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * ERP 자산번호 IF 테이블 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteAssetNo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/deleteAssetNo");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * ERP 자산번호 제거 상태값 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAssetFlagToD(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateAssetFlagToD");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 전표- 회계처리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateSlipProcConfirm(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateSlipProcConfirm");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용수정 SLIP_STATUS = (처리완료)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostMasterSlipStatus(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateCostMasterSlipStatus");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     *  ERP 테이블 상태값 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostErp(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateCostErp");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     *  전표번호와 회계연도정보 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostSapDelete(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateCostSapDelete");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     *  전표번호와 회계연도정보 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostAssetNo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateCostAssetNo");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     *   전표처리상태'1', 전표ID 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostStateId(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateCostStateId");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용수정 SLIP_STATUS = (처리대상)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateCostMasterSlipStatusTaget(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateCostMasterSlipStatusTaget");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * ERP - 전표처리 상태 수정 (FLAG = D)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateIFCostSlip(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/updateIFCostSlip");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 자산번호 생성에  필요한 정보
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retriveAssetInfo(AjaxRequest xReq,String deptCode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/retriveAssetInfo");
        dao.bind("DEPT_CODE", deptCode);
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 자산번호 테이블 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createAssetNo(AjaxRequest xReq,String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/slip/proc", "/createAssetNo");
        dao.bind("REF_ID", refId);
        dao.bind(xReq);

        return dao.executeUpdate();
    }

}
