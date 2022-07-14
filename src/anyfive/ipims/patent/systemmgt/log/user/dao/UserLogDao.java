package anyfive.ipims.patent.systemmgt.log.user.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class UserLogDao extends NAbstractServletDao
{
    public UserLogDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사용자 로그 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveUserLogList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/log/user", "/retrieveUserLogList");
        dao.bind(xReq);

        // 시스템
        if (xReq.getParam("SYSTEM_TYPE").equals("") != true) {
            dao.addQuery("systemType");
        }

        // 로그종류
        if (xReq.getParam("LOG_TYPE").equals("") != true) {
            dao.addQuery("logType");
        }

        // 로그일자 - 시작
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }

        // 로그일자 - 종료
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        // 사용자명
        if (xReq.getParam("EMP_HNAME").equals("") != true) {
            dao.addQuery("empHname");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 사용자 로그 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveUserLog(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/log/user", "/retrieveUserLog");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }
}
