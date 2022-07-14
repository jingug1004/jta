package anyfive.ipims.share.workprocess.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.dao.WorkProcessDao;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class WorkProcessBiz extends NAbstractServletBiz
{
    private String refId     = null;
    private String bizStepId = null;

    public WorkProcessBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 화면처리를 위한 업무 정보 조회
     *
     * @param xReq
     * @return
     */
    public NSingleData retrieveWorkProcessForView(AjaxRequest xReq) throws NException
    {
        WorkProcessDao dao = new WorkProcessDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_bizComMst", dao.retrieveWorkProcessMaster(xReq.getParam("REF_ID")));
        result.set("ds_bizMgtProc", dao.retrieveWorkProcessStatusList(xReq));

        return result;
    }

    /**
     * 업무프로세스 생성
     *
     * @param refId
     * @param bizStepId
     * @throws NException
     */
    public void create(String refId, String bizStepId) throws NException
    {
        if (bizStepId == null || bizStepId.equals("")) {
            this.throwException("업무단계 ID 가 정의되지 않았습니다.");
        }

        this.refId = refId;
        this.bizStepId = bizStepId;

        this.doUpdate(WorkProcessConst.Action.START, false);
    }

    /**
     * 업무프로세스 수정
     *
     * @param refId
     * @param bizAct
     * @throws NException
     */
    public void update(String refId, String bizAct) throws NException
    {
        this.refId = refId;
        this.bizStepId = null;

        this.doUpdate(bizAct, false);
    }

    /**
     * 업무프로세스 수정
     *
     * @param refId
     * @param bizAct
     * @param isOnlyAvailAction
     *            처리가능한 액션인 경우에만 실행함(기본값: false)
     * @throws NException
     */
    public void update(String refId, String bizAct, boolean isOnlyAvailAction) throws NException
    {
        this.refId = refId;
        this.bizStepId = null;

        this.doUpdate(bizAct, isOnlyAvailAction);
    }

    /**
     * 업무프로세스 수정
     *
     * @param bizAct
     * @param isOnlyAvailAction
     *            처리가능한 액션인 경우에만 실행함(기본값: false)
     * @throws NException
     */
    private void doUpdate(String bizAct, boolean isOnlyAvailAction) throws NException
    {
        if (this.refId == null || this.refId.equals("")) {
            this.throwException("업무관련 ID 가 정의되지 않았습니다.");
        }

        String currStatus = null;

        WorkProcessDao dao = new WorkProcessDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        if (this.bizStepId == null) {
            NSingleData masterInfo = dao.retrieveWorkProcessMaster(this.refId);
            if (masterInfo.isEmpty()) this.throwException("업무상태가 존재하지 않습니다.");
            this.bizStepId = masterInfo.getString("BIZ_STEP_ID");
            currStatus = masterInfo.getString("STATUS");
        } else {
            currStatus = WorkProcessConst.Status.NONE;
        }

        // 처리가능한 액션인지 조회
        if (isOnlyAvailAction == true) {
            if (dao.retrieveIsAvailAction(this.bizStepId, currStatus, bizAct) != true) return;
        }

        // 다음상태 목록 조회
        NMultiData nextList = dao.retrieveNextStatusList(this.bizStepId, currStatus, bizAct);

        // 다음상태 정보 조회
        NSingleData nextInfo = this.getNextStatusInfo(dao, nextList, currStatus, bizAct);

        if (nextInfo.isEmpty()) {
            this.throwException("업무프로세스 \"" + this.bizStepId + "\" 의 다음 진행상태가 존재하지 않습니다.");
        }

        String nextStepId = nextInfo.getString("NEXT_STEP_ID");
        String nextStatus = nextInfo.getString("NEXT_STATUS");

        // 다음 이후상태 목록 조회
        NMultiData nextAfterList = dao.retrieveNextStatusList(nextStepId, nextStatus, null);

        // TO-DO 표시 여부 조회
        String todoDispYn = this.getTodoDispYn(nextAfterList);

        // 기한일 조회
        NSingleData dateInfo = dao.retrieveLimitDateInfo(nextAfterList);

        String histSeq = seqUtil.getBizHistSeq(this.refId);

        NSingleData temp = new NSingleData();

        // 업무 공통 마스터 생성/수정
        temp.clear();
        temp.setString("BIZ_STEP_ID", nextStepId);
        temp.setString("STATUS", nextStatus);
        temp.setString("TODO_DISP_YN", todoDispYn);
        temp.setString("URGENT_DATE", dateInfo.getString("URGENT_DATE"));
        temp.setString("DUE_DATE", dateInfo.getString("DUE_DATE"));
        temp.setString("HIST_SEQ", histSeq);
        temp.setString("UPD_USER", this.nsr.userInfo.getUserId());
        if (currStatus.equals(WorkProcessConst.Status.NONE)) {
            dao.createWorkProcessMaster(this.refId, this.bizStepId, temp);
        } else {
            dao.updateWorkProcessMaster(this.refId, temp);
        }

        // 업무 공통 단계 생성/수정
        if (dao.updateWorkProcessStep(this.refId, this.bizStepId, nextStatus) == 0) {
            dao.createWorkProcessStep(this.refId, this.bizStepId, nextStatus);
        }

        // 다음 업무 공통 단계 생성/수정
        if (this.bizStepId.equals(nextStepId) != true) {
            if (dao.updateWorkProcessStep(this.refId, nextStepId, nextStatus) == 0) {
                dao.createWorkProcessStep(this.refId, nextStepId, nextStatus);
            }
        }

        // 업무 공통 히스토리 생성
        temp.clear();
        temp.setString("HIST_SEQ", histSeq);
        temp.setString("PREV_STATUS", currStatus);
        temp.setString("PREV_STEP_ID", this.bizStepId);
        temp.setString("BIZ_ACT", bizAct);
        temp.setString("ACT_OWNER", nextInfo.getString("ACT_OWNER"));
        temp.setString("ACT_COND_NO", nextInfo.getString("ACT_COND_NO"));
        temp.setString("CURR_STATUS", nextStatus);
        temp.setString("CURR_STEP_ID", nextStepId);
        temp.setString("TODO_DISP_YN", todoDispYn);
        temp.setString("URGENT_DATE", dateInfo.getString("URGENT_DATE"));
        temp.setString("DUE_DATE", dateInfo.getString("DUE_DATE"));
        temp.setString("PAPER_CODE", null);
        temp.setString("PAPER_SUBCODE", null);
        temp.setString("CRE_USER", this.nsr.userInfo.getUserId());
        dao.createWorkProcessHistory(this.refId, temp);
    }

    /**
     * 업무프로세스 삭제
     *
     * @param refId
     * @throws NException
     */
    public void delete(String refId) throws NException
    {
        WorkProcessDao dao = new WorkProcessDao(this.nsr);

        // 업무 공통 히스토리 목록 전체 삭제
        dao.deleteWorkProcessHistoryListAll(refId);

        // 업무 공통 단계 목록 전체 삭제
        dao.deleteWorkProcessStepListAll(refId);

        // 업무 공통 마스터 삭제
        dao.deleteWorkProcessMaster(refId);
    }

    private NSingleData getNextStatusInfo(WorkProcessDao dao, NMultiData nextList, String currStatus, String bizAct) throws NException
    {
        if (nextList.getRowSize() == 0) this.throwException("다음 진행상태가 정의되지 않았습니다.");

        if (nextList.getRowSize() == 1) return nextList.getSingleData(0);

        int condIndex = dao.retrieveNextStatusCondIndex(nextList, this.refId);

        if (condIndex == -1) this.throwException("일치하는 조건식을 찾을 수 없습니다.");

        return nextList.getSingleData(condIndex);
    }

    private String getTodoDispYn(NMultiData nextList)
    {
        for (int i = 0; i < nextList.getRowSize(); i++) {
            if (nextList.getString(i, "TODO_DISP_YN").equals("1")) return "1";
        }

        return "0";
    }

    /**
     * 예외처리
     *
     * @param message
     * @throws NBizException
     */
    private void throwException(String message) throws NBizException
    {
        throw new NBizException("[ERROR] 업무프로세스 처리시 다음과 같은 에러가 발생했습니다.\n\n" + message);
    }
}
