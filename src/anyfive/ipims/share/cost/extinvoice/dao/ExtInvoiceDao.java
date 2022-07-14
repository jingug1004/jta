package anyfive.ipims.share.cost.extinvoice.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtInvoiceDao extends NAbstractServletDao
{
    public ExtInvoiceDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외비용 INVOICE 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCostLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/extinvoice", "/createExtInvoice");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외비용 INVOICE 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtInvoice(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/extinvoice", "/retrieveExtInvoice");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 해외비용 INVOICE 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtInvoice(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/extinvoice", "/updateExtInvoice");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외비용 INVOICE 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteExtInvoice(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/extinvoice", "/deleteExtInvoice");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외비용 상세목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtCostDetailList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/extinvoice", "/retrieveExtCostDetailList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * INVOICE별 해외비용입력목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteExtCostByLetterSeq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/extinvoice", "/deleteExtCostByLetterSeq");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외비용 일괄확인
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] updateExtCostConfirmYn(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/cost/extinvoice", "/updateExtCostConfirmYn");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_extCostList"));
    }
}
