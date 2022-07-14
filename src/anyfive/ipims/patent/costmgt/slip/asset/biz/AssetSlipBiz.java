package anyfive.ipims.patent.costmgt.slip.asset.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.slip.asset.dao.AssetSlipDao;
import anyfive.ipims.patent.costmgt.slip.proc.biz.SlipProcBiz;

public class AssetSlipBiz extends NAbstractServletBiz
{
    public AssetSlipBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자산/거절 전표작성대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetSlipList(AjaxRequest xReq) throws NException
    {
        AssetSlipDao dao = new AssetSlipDao(this.nsr);

        return dao.retrieveAssetSlipList(xReq);
    }

    /**
     * 자산/거절 전표 비용목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetSlipCostList(AjaxRequest xReq) throws NException
    {
        AssetSlipDao dao = new AssetSlipDao(this.nsr);

        return dao.retrieveAssetSlipCostList(xReq);
    }

    /**
     * 자산/거절 전표 완료처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateSlipProcConfirm(AjaxRequest xReq) throws NException
    {
        SlipProcBiz procBiz = new SlipProcBiz(this.nsr);

        procBiz.updateSlipProcConfirm(xReq);
    }
}
