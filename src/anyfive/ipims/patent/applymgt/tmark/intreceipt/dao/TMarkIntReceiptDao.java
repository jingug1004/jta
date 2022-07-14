package anyfive.ipims.patent.applymgt.tmark.intreceipt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class TMarkIntReceiptDao extends NAbstractServletDao
{
    public TMarkIntReceiptDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntReceiptList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intreceipt", "/retrieveTMarkIntReceiptList");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.JOB_MAN_ASSIGN);

        return dao.executeQueryForGrid(xReq);
    }


    /**
     * 상표국내의뢰접수 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intreceipt", "/retrieveTMarkIntReceipt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 상표국내출원품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTMarkIntConsult(String resId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intreceipt", "/createTMarkIntConsult");
        dao.bind("REF_ID", resId);
        dao.bind("JOB_MAN", jobMan);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intreceipt", "/createTMarkIntConsultTmark");
        dao.bind("REF_ID", resId);
        dao.executeUpdate();
    }

    /**
     * 상표국내출원마스터 생성
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void createTMarkIntMaster(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/intreceipt", "/createTMarkIntMaster");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/tmark/intreceipt", "/createTMarkIntMasterInt");
        dao.bind("REF_ID", refId);
        dao.executeUpdate();
    }
}
