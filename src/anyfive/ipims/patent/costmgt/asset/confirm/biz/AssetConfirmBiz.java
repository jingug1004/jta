package anyfive.ipims.patent.costmgt.asset.confirm.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.asset.confirm.dao.AssetConfirmDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class AssetConfirmBiz extends NAbstractServletBiz
{
    public AssetConfirmBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자산/거절 처리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetConfirmList(AjaxRequest xReq) throws NException
    {
        AssetConfirmDao dao = new AssetConfirmDao(this.nsr);

        return dao.retrieveAssetConfirmList(xReq);
    }

    /**
     * 자산/거절 확정 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createAssetConfirm(AjaxRequest xReq) throws NException
    {
        AssetConfirmDao dao = new AssetConfirmDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        NMultiData confirmList = xReq.getMultiData("ds_assetConfirmList");
        NMultiData createList = new NMultiData();

        for (int i = 0; i < confirmList.getRowSize(); i++) {
            confirmList.setString(i, "COST_SEQ", seqUtil.getCostSeq());
            createList.addSingleData(confirmList.getSingleData(i));
        }

        dao.createAssetConfirm(xReq, createList);
    }

    /**
     * 자산/거절 확정 취소(삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAssetConfirm(AjaxRequest xReq) throws NException
    {
        AssetConfirmDao dao = new AssetConfirmDao(this.nsr);

        dao.deleteAssetConfirm(xReq, xReq.getMultiData("ds_assetConfirmList"));

    }

    /**
     * 자산/거절 진행
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void assetYnConfirm(AjaxRequest xReq) throws NException
    {
        AssetConfirmDao dao = new AssetConfirmDao(this.nsr);

        dao.assetYnConfirm(xReq, xReq.getMultiData("ds_assetConfirmList"));

    }

    /**
     * 자산/거절 취소
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void cancelAssetConfirm(AjaxRequest xReq) throws NException
    {
        AssetConfirmDao dao = new AssetConfirmDao(this.nsr);

        dao.cancelAssetConfirm(xReq, xReq.getMultiData("ds_assetConfirmList"));

    }
}
