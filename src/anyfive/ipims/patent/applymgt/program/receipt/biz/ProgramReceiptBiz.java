package anyfive.ipims.patent.applymgt.program.receipt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.program.receipt.dao.ProgramReceiptDao;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ProgramReceiptBiz extends NAbstractServletBiz
{
    public ProgramReceiptBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로그램 접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramReceiptList(AjaxRequest xReq) throws NException
    {
        ProgramReceiptDao dao = new ProgramReceiptDao(this.nsr);

        return dao.retrieveProgramReceiptList(xReq);
    }

    /**
     * 프로그램 접수 담당자지정
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void updateProgramReceiptJobMan(String refId, String jobMan) throws NException
    {
        ProgramReceiptDao dao = new ProgramReceiptDao(this.nsr);

        // 프로그램 품의서 생성
        dao.createProgramConsult(refId, jobMan);

        // 프로그램 마스터 생성
        dao.createProgramMaster(refId, jobMan);

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(refId, WorkProcessConst.Action.JOB_MAN_ASSIGN);
    }
}
