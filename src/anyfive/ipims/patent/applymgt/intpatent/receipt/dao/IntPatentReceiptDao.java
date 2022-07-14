package anyfive.ipims.patent.applymgt.intpatent.receipt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class IntPatentReceiptDao extends NAbstractServletDao
{
    public IntPatentReceiptDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 건담당자지정 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentReceiptList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/receipt", "/retrieveIntPatentReceiptList");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.JOB_MAN_ASSIGN);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국내특허품의 생성
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void createIntPatentConsult(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/receipt", "/createIntPatentConsult");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/intpatent/receipt", "/createIntPatentConsultPat");
        dao.bind("REF_ID", refId);
        dao.executeUpdate();
    }

    /**
     * 국내특허마스터 생성
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void createIntPatentMaster(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/intpatent/receipt", "/createIntPatentMaster");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/intpatent/receipt", "/createIntPatentMasterInt");
        dao.bind("REF_ID", refId);
        dao.executeUpdate();
    }
}
