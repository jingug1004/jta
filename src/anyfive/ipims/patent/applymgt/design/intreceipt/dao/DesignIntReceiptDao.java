package anyfive.ipims.patent.applymgt.design.intreceipt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class DesignIntReceiptDao extends NAbstractServletDao
{
    public DesignIntReceiptDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인국내의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntReceiptList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intreceipt", "/retrieveDesignIntReceiptList");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.JOB_MAN_ASSIGN);

        return dao.executeQueryForGrid(xReq);
    }


    /**
     * 디자인국내의뢰접수 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntReceipt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intreceipt", "/retrieveDesignIntReceipt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 디자인국내출원품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createDesignIntConsult(String resId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intreceipt", "/createDesignIntConsult");
        dao.bind("REF_ID", resId);
        dao.bind("JOB_MAN", jobMan);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intreceipt", "/createDesignIntConsultDesign");
        dao.bind("REF_ID", resId);
        dao.executeUpdate();
    }

    /**
     * 디자인국내출원마스터 생성
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void createDesignIntMaster(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/intreceipt", "/createDesignIntMaster");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/applymgt/design/intreceipt", "/createDesignIntMasterInt");
        dao.bind("REF_ID", refId);
        dao.executeUpdate();
    }
}
