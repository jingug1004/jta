package anyfive.ipims.patent.applymgt.program.request.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.program.request.dao.ProgramRequestDao;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ProgramRequestBiz extends NAbstractServletBiz
{
    public ProgramRequestBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로그램 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramRequestList(AjaxRequest xReq) throws NException
    {
        ProgramRequestDao dao = new ProgramRequestDao(this.nsr);

        return dao.retrieveProgramRequestList(xReq);
    }

    /**
     * 프로그램 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramRequest(AjaxRequest xReq) throws NException
    {
        ProgramRequestDao dao = new ProgramRequestDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 프로그램 조회
        result.set("ds_mainInfo", dao.retrieveProgramRequest(xReq));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        return result;
    }

    /**
     * 프로그램 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createProgramRequest(AjaxRequest xReq) throws NException
    {
        ProgramRequestDao dao = new ProgramRequestDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = seqUtil.getBizId();

        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", seqUtil.getProgramNo());

        // 프로그램 생성
        dao.createProgramRequest(xReq);

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_progFileId"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(refId, WorkProcessConst.Step.PROGRAM_REQUEST);

        return refId;
    }

    /**
     * 프로그램 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateProgramRequest(AjaxRequest xReq) throws NException
    {
        ProgramRequestDao dao = new ProgramRequestDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");

        // 프로그램 수정
        dao.updateProgramRequest(xReq);

        // 발명자 맵핑목록 저장
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_progFileId"));
    }

    /**
     * 프로그램 재작성(보완요청 확인)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void rewriteProgramRequest(AjaxRequest xReq) throws NException
    {
        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("REF_ID"), WorkProcessConst.Action.REWRITE);
    }
}
