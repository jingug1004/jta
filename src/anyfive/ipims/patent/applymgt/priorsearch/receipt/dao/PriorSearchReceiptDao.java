package anyfive.ipims.patent.applymgt.priorsearch.receipt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class PriorSearchReceiptDao extends NAbstractServletDao
{
    public PriorSearchReceiptDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 조사의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchReceiptList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/receipt", "/retrievePriorSearchReceiptList");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.JOB_MAN_ASSIGN);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 조사 품의서 생성
     *
     * @param prschId
     * @param jobMan
     * @return
     * @throws NException
     */
    public int createPriorSearchConsult(String prschId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/receipt", "/createPriorSearchConsult");
        dao.bind("PRSCH_ID", prschId);
        dao.bind("JOB_MAN", jobMan);

        return dao.executeUpdate();
    }
}
