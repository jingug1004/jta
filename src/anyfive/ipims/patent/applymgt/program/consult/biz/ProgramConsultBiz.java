package anyfive.ipims.patent.applymgt.program.consult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.program.consult.dao.ProgramConsultDao;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ProgramConsultBiz extends NAbstractServletBiz
{
    public ProgramConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로그램품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramConsultList(AjaxRequest xReq) throws NException
    {
        ProgramConsultDao dao = new ProgramConsultDao(this.nsr);

        return dao.retrieveProgramConsultList(xReq);
    }

    /**
     * 프로그램품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramConsult(AjaxRequest xReq) throws NException
    {
        ProgramConsultDao dao = new ProgramConsultDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveProgramConsult(xReq));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        return result;
    }

    /**
     * 프로그램품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateProgramConsult(AjaxRequest xReq) throws NException
    {
        ProgramConsultDao dao = new ProgramConsultDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 프로그램품의 수정
        dao.updateProgramConsult(xReq);

        // 관련파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_consutProgFileId"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("REF_ID"), WorkProcessConst.Action.WRITE, true);
    }
}
