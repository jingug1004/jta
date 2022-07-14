package anyfive.ipims.patent.applymgt.program.receipt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ProgramReceiptDao extends NAbstractServletDao
{
    public ProgramReceiptDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/program/receipt", "/retrieveProgramReceiptList");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.JOB_MAN_ASSIGN);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 프로그램 품의서 생성
     *
     * @param refId
     * @param jobMan
     * @return
     * @throws NException
     */
    public int createProgramConsult(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/program/receipt", "/createProgramConsult");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);

        return dao.executeUpdate();
    }
    /**
     * 프로그램 마스터 생성
     *
     * @param refId
     * @param jobMan
     * @return
     * @throws NException
     */
    public int createProgramMaster(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/program/receipt", "/createProgramMaster");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);

        return dao.executeUpdate();
    }
}
