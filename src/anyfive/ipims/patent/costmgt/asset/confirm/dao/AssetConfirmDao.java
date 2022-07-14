package anyfive.ipims.patent.costmgt.asset.confirm.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AssetConfirmDao extends NAbstractServletDao
{
    public AssetConfirmDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 자산/거절 처리대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetConfirmList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        if (xReq.getParam("ASSET_STATUS").equals("0")) {
            dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/retrieveAssetConfirmList");
        }
        if (xReq.getParam("ASSET_STATUS").equals("1")) {
            dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/retrieveAssetConsultList");
        }
        if (xReq.getParam("ASSET_STATUS").equals("2")) {
            dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/retrieveAssetYnList");
        }
        if (xReq.getParam("ASSET_STATUS").equals("3")) {
            dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/retrieveAssetCancelList");
        }

        dao.bind(xReq);

        // 처리구분
        dao.addQuery("assetDiv" + xReq.getParam("ASSET_DIV"));

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        // 국가구분
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 사무소
        if (xReq.getParam("OFFICE_CODE").equals("") != true) {
            dao.addQuery("officeCode");
        }

        // 매입여부
        if (xReq.getParam("BUY_YN").equals("") != true) {
            dao.addQuery("buyYn");
        }

        // 검색일자
        if (xReq.getParam("DATE_GUBUN").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 자산/거절 확정 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createAssetConfirm(AjaxRequest xReq, NMultiData createList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/createAssetConfirm");
        dao.bind(xReq);

        return dao.executeBatch(createList);
    }

    /**
     * 자산/거절 확정 구분값 업데이트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCostAssetYN(AjaxRequest xReq, String costSeq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/updateCostAssetYN");
        dao.bind(xReq);
        dao.bind("COST_SEQ", costSeq);

        dao.executeUpdate();
    }

    /**
     * 자산/거절 확정 취소 업데이트
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void cancelCostAssetYN(AjaxRequest xReq, NMultiData costList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/cancelCostAssetYN");
        dao.bind(xReq);

        String costSeq = new String();

        for(int i=0; i < costList.getRowSize(); i++) {
            costSeq = costList.getString(i, "COST_SEQ");
            dao.bind("COST_SEQ", costSeq);

            dao.executeUpdate();
        }

    }

    /**
     * 자산/거절 확정 취소(삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAssetConfirm(AjaxRequest xReq, NMultiData deleteList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/deleteAssetConfirm");
        dao.bind(xReq);

        dao.executeBatch(deleteList);
    }

    /**
     * 자산/거절 진행
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void assetYnConfirm(AjaxRequest xReq, NMultiData assetYnList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/assetYnConfirm");
        dao.bind(xReq);

        dao.executeBatch(assetYnList);
    }

    /**
     * 자산/거절 취소
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void cancelAssetConfirm(AjaxRequest xReq, NMultiData assetYnList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/asset/confirm", "/cancelAssetConfirm");
        dao.bind(xReq);

        dao.executeBatch(assetYnList);
    }
}
