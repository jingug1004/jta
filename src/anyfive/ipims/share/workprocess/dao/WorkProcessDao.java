package anyfive.ipims.share.workprocess.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class WorkProcessDao extends NAbstractServletDao
{
    public WorkProcessDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업무 마스터 조회
     *
     * @param refId
     * @return
     * @throws NException
     */
    public NSingleData retrieveWorkProcessMaster(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/retrieveWorkProcessMaster");
        dao.bind("REF_ID", refId);

        return dao.executeQueryForSingle();
    }

    /**
     * 업무별 진행상태 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveWorkProcessStatusList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/retrieveWorkProcessStatusList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 처리가능한 액션인지 조회
     *
     * @param bizStepId
     * @param currStatus
     * @param bizAct
     * @return
     * @throws NException
     */
    public boolean retrieveIsAvailAction(String bizStepId, String currStatus, String bizAct) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/retrieveIsAvailAction");
        dao.bind("BIZ_STEP_ID", bizStepId);
        dao.bind("CURR_STATUS", currStatus);
        dao.bind("BIZ_ACT", bizAct);

        return dao.executeQueryForString().equals("1");
    }

    /**
     * 다음상태 목록 조회
     *
     * @param bizStepId
     * @param currStatus
     * @param bizAct
     * @return
     * @throws NException
     */
    public NMultiData retrieveNextStatusList(String bizStepId, String currStatus, String bizAct) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/retrieveNextStatusList");
        dao.bind("BIZ_STEP_ID", bizStepId);
        dao.bind("CURR_STATUS", currStatus);
        dao.bind("BIZ_ACT", bizAct);

        if (bizAct != null) {
            dao.addQuery("bizAct");
        }

        return dao.executeQuery();
    }

    /**
     * 다음상태 조건 Index 조회
     *
     * @param nextList
     * @param refId
     * @return
     * @throws NException
     */
    public int retrieveNextStatusCondIndex(NMultiData nextList, String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/retrieveNextStatusCondIndex", true);

        String condQuery = null;

        for (int i = 0; i < nextList.getRowSize(); i++) {
            condQuery = nextList.getString(i, "ACT_COND_QRY");
            if (condQuery.equals("")) condQuery = "0";
            dao.replaceText("condQuery", (i == 0 ? "" : "\nUNION ALL\n") + "SELECT (" + condQuery + ") COND_VAL, " + i + " COND_IDX FROM DUAL", true);
        }

        dao.bind("REF_ID", refId);

        String result = dao.executeQueryForString();

        if (result.equals("")) return -1;

        return Integer.parseInt(result, 10);
    }

    /**
     * 기한일 정보 조회
     *
     * @param nextList
     * @return
     * @throws NException
     */
    public NSingleData retrieveLimitDateInfo(NMultiData nextList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/retrieveLimitDateInfo");

        String urgentDateQry = null;
        String dueDateQry = null;

        for (int i = 0; i < nextList.getRowSize(); i++) {
            urgentDateQry = nextList.getString(i, "URGENT_DATE_QRY");
            dueDateQry = nextList.getString(i, "DUE_DATE_QRY");
            if (urgentDateQry.equals("") != true) {
                dao.replaceText("urgentDateQry", "\nUNION ALL\nSELECT (" + urgentDateQry + ") FROM DUAL", true);
            }
            if (dueDateQry.equals("") != true) {
                dao.replaceText("dueDateQry", "\nUNION ALL\nSELECT (" + dueDateQry + ") FROM DUAL", true);
            }
        }

        return dao.executeQueryForSingle();
    }

    /**
     * 업무 마스터 생성
     *
     * @param refId
     * @param bizStepId
     * @param data
     * @return
     * @throws NException
     */
    public int createWorkProcessMaster(String refId, String bizStepId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/createWorkProcessMaster");
        dao.bind("REF_ID", refId);
        dao.bind("BIZ_STEP_ID", bizStepId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 업무 마스터 수정
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int updateWorkProcessMaster(String refId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/updateWorkProcessMaster");
        dao.bind("REF_ID", refId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 업무 단계 생성
     *
     * @param refId
     * @param bizStepId
     * @param status
     * @return
     * @throws NException
     */
    public int createWorkProcessStep(String refId, String bizStepId, String status) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/createWorkProcessStep");
        dao.bind("REF_ID", refId);
        dao.bind("BIZ_STEP_ID", bizStepId);
        dao.bind("STATUS", status);

        return dao.executeUpdate();
    }

    /**
     * 업무 단계 수정
     *
     * @param refId
     * @param bizStepId
     * @param status
     * @return
     * @throws NException
     */
    public int updateWorkProcessStep(String refId, String bizStepId, String status) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/updateWorkProcessStep");
        dao.bind("REF_ID", refId);
        dao.bind("BIZ_STEP_ID", bizStepId);
        dao.bind("STATUS", status);

        return dao.executeUpdate();
    }

    /**
     * 업무 히스토리 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int createWorkProcessHistory(String refId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/createWorkProcessHistory");
        dao.bind("REF_ID", refId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * 업무 히스토리 목록 전체 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteWorkProcessHistoryListAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/deleteWorkProcessHistoryListAll");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 업무 단계 목록 전체 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteWorkProcessStepListAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/deleteWorkProcessStepListAll");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * 업무 마스터 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteWorkProcessMaster(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/workprocess/workprocess", "/deleteWorkProcessMaster");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }
}
