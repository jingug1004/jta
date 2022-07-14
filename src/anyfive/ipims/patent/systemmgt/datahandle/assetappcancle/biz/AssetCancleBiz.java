package anyfive.ipims.patent.systemmgt.datahandle.assetappcancle.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.assetappcancle.dao.AssetCancleDao;

public class AssetCancleBiz extends NAbstractServletBiz
{
    public AssetCancleBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용결재 취소 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetCancleList(AjaxRequest xReq) throws NException
    {
        AssetCancleDao dao = new AssetCancleDao(this.nsr);
        return dao.retrieveAssetCancleList(xReq);
    }

    /**
     * 비용결재 취소 목록 취소
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void assetcancleListU(AjaxRequest xReq) throws NException
    {
        NMultiData data = xReq.getMultiData("ds_assetCancleList");
        AssetCancleDao dao = new AssetCancleDao(this.nsr);

        for( int i=0; i< data.getRowSize(); i++ ){
            dao.assetcancleListU(data.getString(i, "APPR_NO"), xReq);
        }
    }
}
