package anyfive.ipims.patent.costmgt.sale.confirm.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.sale.confirm.dao.SaleMgtDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class SaleMgtBiz extends NAbstractServletBiz
{
    public SaleMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 매각 확정 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveSaleMgtList(AjaxRequest xReq) throws NException
    {
        SaleMgtDao dao = new SaleMgtDao(this.nsr);

        return dao.retrieveSaleMgtList(xReq);
    }

    /**
     * 매각 확정 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createSaleMgt(AjaxRequest xReq) throws NException
    {
        SaleMgtDao dao = new SaleMgtDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        NMultiData saleMgtList = xReq.getMultiData("ds_saleMgtList");
        NMultiData createList = new NMultiData();

        for (int i = 0; i < saleMgtList.getRowSize(); i++) {
            saleMgtList.setString(i, "COST_SEQ", seqUtil.getCostSeq());
            createList.addSingleData(saleMgtList.getSingleData(i));
        }
        dao.createSaleMgt(xReq, createList);
    }

    /**
     * 매각 확정 취소(삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteSaleMgt(AjaxRequest xReq) throws NException
    {
        SaleMgtDao dao = new SaleMgtDao(this.nsr);

        dao.deleteSaleMgt(xReq, xReq.getMultiData("ds_saleMgtList"));
    }
}
