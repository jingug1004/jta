package anyfive.framework.mail.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NLobDao;
import any.util.dao.NQueryDao;

public class MailDao extends NAbstractServletDao
{
    public MailDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메일 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createMail(String mailId, NSingleData mailInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/mail", "/createMail");
        dao.bind("MAIL_ID", mailId);
        dao.bind(mailInfo);

        return dao.executeUpdate();
    }

    /**
     * 메일내용 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateMailBody(String mailId, String body) throws NException
    {
        NLobDao dao = new NLobDao(this.nsr);

        dao.setQuery("/framework/mail", "/updateMailBody");
        dao.bind("MAIL_ID", mailId);
        dao.setClobData("BODY", body);

        return dao.executeUpdate();
    }

    /**
     * 받는사람 목록 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createMailRecvList(String mailId, NMultiData recvList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/mail", "/createMailRecvList");
        dao.bind("MAIL_ID", mailId);

        return dao.executeBatch(recvList);
    }

    /**
     * 메일로그 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createMailLog(String mailId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/mail", "/createMailLog");
        dao.bind("MAIL_ID", mailId);

        return dao.executeUpdate();
    }
}
