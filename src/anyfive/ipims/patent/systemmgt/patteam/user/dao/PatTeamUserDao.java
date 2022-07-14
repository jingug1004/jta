package anyfive.ipims.patent.systemmgt.patteam.user.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PatTeamUserDao extends NAbstractServletDao
{
    public PatTeamUserDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 특허팀 사용자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePatTeamUserList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/user", "/retrievePatTeamUserList");
        dao.bind(xReq);

        if (xReq.getParam("MAIL_ADDR").equals("") != true) {
            dao.addQuery("mailAddr");
        }
        if (xReq.getParam("EMP_NAME").equals("") != true) {
            dao.addQuery("empName");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 특허팀 사용자 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePatTeamUser(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/user", "/retrievePatTeamUser");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 특허팀 사용자 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePatTeamUser(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/user", "/updatePatTeamUser");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
