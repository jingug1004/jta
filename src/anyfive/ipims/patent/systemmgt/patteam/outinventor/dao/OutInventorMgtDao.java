package anyfive.ipims.patent.systemmgt.patteam.outinventor.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class OutInventorMgtDao extends NAbstractServletDao
{
    public OutInventorMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 외부발명자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOutInventorList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/outinventor", "/retrieveOutInventorList");
        dao.bind(xReq);

        if (xReq.getParam("EMP_NAME").equals("") != true) {
            dao.addQuery("empName");
        }

        if (xReq.getParam("EMP_NO").equals("") != true) {
            dao.addQuery("empNo");
        }

        if (xReq.getParam("COUNTRY_CODE").equals("") != true) {
            dao.addQuery("countryCode");
        }

        if (xReq.getParam("APP_MAN_CODE").equals("") != true) {
            dao.addQuery("appManCode");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 외부발명자 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOutInventor(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/outinventor", "/retrieveOutInventor");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 사용자 마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createUserMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/outinventor", "/createUserMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 외부발명자 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createOutInventor(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/outinventor", "/createOutInventor");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 사용자 마스터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateUserMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/outinventor", "/updateUserMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 외부발명자 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateOutInventor(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/outinventor", "/updateOutInventor");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
