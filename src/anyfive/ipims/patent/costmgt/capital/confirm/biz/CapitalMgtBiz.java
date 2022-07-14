package anyfive.ipims.patent.costmgt.capital.confirm.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.capital.confirm.dao.CapitalMgtDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class CapitalMgtBiz extends NAbstractServletBiz
{
    public CapitalMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자본적 지출 확정 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCapitalMgtList(AjaxRequest xReq) throws NException
    {
        CapitalMgtDao dao = new CapitalMgtDao(this.nsr);

        return dao.retrieveCapitalMgtList(xReq);
    }

    /**
     * 자본적 지출 확정 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createCapitalMgt(AjaxRequest xReq) throws NException
    {
        CapitalMgtDao dao = new CapitalMgtDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        NMultiData saleMgtList = xReq.getMultiData("ds_capitalMgtList");
        NMultiData createList = new NMultiData();

        for (int i = 0; i < saleMgtList.getRowSize(); i++) {
            saleMgtList.setString(i, "COST_SEQ", seqUtil.getCostSeq());
            createList.addSingleData(saleMgtList.getSingleData(i));
        }
        dao.createCapitalMgt(xReq, createList);
    }

    /**
     * 자본적 지출  확정 취소(삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCapitalMgt(AjaxRequest xReq) throws NException
    {
        CapitalMgtDao dao = new CapitalMgtDao(this.nsr);

        dao.deleteCapitalMgt(xReq, xReq.getMultiData("ds_capitalMgtList"));
    }
}
