package anyfive.ipims.patent.ipbiz.license.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class LicenseDao extends NAbstractServletDao
{
    public LicenseDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 라이센스 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLicenseList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/license", "/retrieveLicenseList");
        dao.bind(xReq);

        //관리번호
        if (xReq.getParam("MGT_NO").equals("") != true) {
            dao.addQuery("searchMgtNo");
        }
        //이용권의 명칭
        if (xReq.getParam("UTILIZE_TITLE").equals("") != true) {
            dao.addQuery("searchUtilizeTitle");
        }
        //대상업체
        if (xReq.getParam("TARGET_ENT").equals("") != true) {
            dao.addQuery("searchTargetEnt");
        }
        //라이센스 구분
        if (xReq.getParam("LICENSE_DIV").equals("") != true) {
            dao.addQuery("searchLicenseDiv");
        }
        //통신방식 구분
        if (xReq.getParam("ETC_CLS_CODE").equals("") != true) {
            dao.addQuery("etcClsCode");
        }
        // 검색일자
        if (xReq.getParam("SEARCH_DATE").equals("") != true) {
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
     * 라이센스 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createLicense(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/license", "/createLicense");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 라이센스 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLicense(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/license", "/retrieveLicense");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 라이센스 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateLicense(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/license", "/updateLicense");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 라이센스 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteLicense(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/license", "/deleteLicense");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

}
