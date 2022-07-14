package anyfive.ipims.patent.applymgt.priorsearch.receipt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.priorsearch.receipt.dao.PriorSearchReceiptDao;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class PriorSearchReceiptBiz extends NAbstractServletBiz
{
    public PriorSearchReceiptBiz(NServiceResource nsr)
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
        PriorSearchReceiptDao dao = new PriorSearchReceiptDao(this.nsr);

        return dao.retrievePriorSearchReceiptList(xReq);
    }

    /**
     * 조사의뢰접수 담당자지정
     *
     * @param prschId
     * @param jobMan
     * @throws NException
     */
    public void updatePriorSearchReceiptJobMan(String prschId, String jobMan) throws NException
    {
        PriorSearchReceiptDao dao = new PriorSearchReceiptDao(this.nsr);

        // 조사 품의서 생성
        dao.createPriorSearchConsult(prschId, jobMan);

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(prschId, WorkProcessConst.Action.JOB_MAN_ASSIGN);
    }
}
