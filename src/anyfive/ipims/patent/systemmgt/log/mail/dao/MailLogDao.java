package anyfive.ipims.patent.systemmgt.log.mail.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class MailLogDao extends NAbstractServletDao
{
    public MailLogDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메일 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMailLogList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/log/mail", "/retrieveMailLogList");
        dao.bind(xReq);

        // 검색어
        if (xReq.getParam("SEARCH_KIND").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        // 작성일자 - 시작
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }

        // 작성일자 - 종료
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        // 최종상태
        if (xReq.getParam("LAST_STATUS").equals("") != true) {
            dao.addQuery("lastStatus");
        }

        // 수신자 없는 건 포함
        if (xReq.getParam("NO_RECV").equals("1") != true) {
            dao.addQuery("noRecv");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 메일 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMailLog(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/log/mail", "/retrieveMailLog");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 메일 수신자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveMailLogRecvList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/log/mail", "/retrieveMailLogRecvList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 메일 발송로그 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMailSendLogList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/log/mail", "/retrieveMailSendLogList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 메일 내용 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMailLogBody(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/log/mail", "/retrieveMailLogBody");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }
}
