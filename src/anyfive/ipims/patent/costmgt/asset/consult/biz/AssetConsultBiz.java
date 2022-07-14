package anyfive.ipims.patent.costmgt.asset.consult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.asset.consult.dao.AssetConsultDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class AssetConsultBiz extends NAbstractServletBiz
{
    public AssetConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자산/거절 품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetConsultList(AjaxRequest xReq) throws NException
    {
        AssetConsultDao dao = new AssetConsultDao(this.nsr);

        return dao.retrieveAssetConsultList(xReq);
    }

    /**
     * 자산/거절 품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createAssetConsult(AjaxRequest xReq) throws NException
    {
        AssetConsultDao dao = new AssetConsultDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String consultId = seqUtil.getBizId();

        xReq.setUserData("CONSULT_ID", consultId);

        // 자산/거절 품의 생성
        dao.createAssetConsult(xReq);

        // 비용마스터 품의ID 저장
        dao.updateCostMstConsultId(xReq, xReq.getMultiData("ds_assetConfirmList"));

        return consultId;
    }

    /**
     * 자산/거절 품의 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetConsult(AjaxRequest xReq) throws NException
    {
        AssetConsultDao dao = new AssetConsultDao(this.nsr);

        return dao.retrieveAssetConsult(xReq);
    }

    /**
     * 자산/거절 품의 상세 비용목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetConsultCostList(AjaxRequest xReq) throws NException
    {
        AssetConsultDao dao = new AssetConsultDao(this.nsr);

        return dao.retrieveAssetConsultCostList(xReq);
    }

    /**
     * 자산/거절 품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateAssetConsult(AjaxRequest xReq) throws NException
    {
        AssetConsultDao dao = new AssetConsultDao(this.nsr);

        dao.updateAssetConsult(xReq);
    }

    /**
     * 자산/거절 품의 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAssetConsult(AjaxRequest xReq) throws NException
    {
        AssetConsultDao dao = new AssetConsultDao(this.nsr);

        // 비용마스터 수정(품의서ID 삭제)
        dao.updateCostMstConsultIdToNull(xReq);

        // 자산/거절 품의 삭제
        dao.deleteAssetConsult(xReq);
    }
}
