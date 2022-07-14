package anyfive.ipims.patent.systemmgt.datahandle.assetappcancle.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AssetCancleDao extends NAbstractServletDao
{
    public AssetCancleDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 비용결제 취소 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAssetCancleList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/assetcancle", "/retrieveAssetCancleList");
        dao.bind(xReq);

        // 제목
        if (xReq.getParam("CONSULT_SUBJECT").equals("") != true) {
            dao.addQuery("consultSubject");
        }
        // 요청자
        if (xReq.getParam("CRE_USER").equals("") != true) {
            dao.addQuery("creUser");
        }
        // 요청일
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        // 요청일
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 비용청구서 수정(품의서ID 삭제)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int assetcancleListU(String apprNo, AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/assetcancle", "/assetcancleListU");
        dao.bind("APPR_NO" ,apprNo);
        dao.bind(xReq);


        return dao.executeUpdate();
    }
}
