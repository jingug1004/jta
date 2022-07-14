package anyfive.ipims.patent.applymgt.program.master.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.program.master.dao.ProgramMasterDao;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ProgramMasterBiz extends NAbstractServletBiz
{
    public ProgramMasterBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로그램마스터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramMasterList(AjaxRequest xReq) throws NException
    {
        ProgramMasterDao dao = new ProgramMasterDao(this.nsr);

        return dao.retrieveProgramMasterList(xReq);
    }

    /**
     * 프로그램마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramMaster(AjaxRequest xReq) throws NException
    {
        ProgramMasterDao dao = new ProgramMasterDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveProgramMaster(xReq));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        return result;
    }

    /**
     * 프로그램마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createProgramMaster(AjaxRequest xReq) throws NException
    {
        ProgramMasterDao dao = new ProgramMasterDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = seqUtil.getBizId();

        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", seqUtil.getProgramNo());

        // 프로그램 생성
        dao.createProgramMaster(xReq);

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_progFileId"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(refId, WorkProcessConst.Step.PROGRAM_MASTER);

        return refId;
    }

    /**
     * 프로그램마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateProgramMaster(AjaxRequest xReq) throws NException
    {
        ProgramMasterDao dao = new ProgramMasterDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");

        // 프로그램마스터 수정
        dao.updateProgramMaster(xReq);

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_progFileId"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(refId, WorkProcessConst.Action.MODIFY);
    }
}
