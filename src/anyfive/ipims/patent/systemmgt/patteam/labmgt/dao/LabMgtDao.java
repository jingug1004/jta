package anyfive.ipims.patent.systemmgt.patteam.labmgt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class LabMgtDao extends NAbstractServletDao
{
    public LabMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연구소정보관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLabMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/labmgt", "/retrieveLabMgtList");
        dao.bind(xReq);

        if (xReq.getParam("LAB_CODE").equals("") != true) {
            dao.addQuery("searchLabCode");
        }
        if (xReq.getParam("LAB_NAME").equals("") != true) {
            dao.addQuery("searchLabName");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연구소정보관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createLabMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/labmgt", "/createLabMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 연구소정보관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLabMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/labmgt", "/retrieveLabMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 연구소정보관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateLabMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/labmgt", "/updateLabMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 연구소정보관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteLabMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/labmgt", "/deleteLabMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
