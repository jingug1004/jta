package anyfive.ipims.patent.schedule.sendmail.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class SendMailDao extends NAbstractServletDao
{
    public SendMailDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메일상태 변경
     *
     * @return
     * @throws NException
     */
    public int updateMailMstStatusForSend() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/sendmail", "/updateMailMstStatusForSend");

        return dao.executeUpdate();
    }

    /**
     * 발송중인 메일 목록 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveWorkingMailMstList() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/sendmail", "/retrieveWorkingMailMstList");

        return dao.executeQuery();
    }

    /**
     * 메일 발송정보 조회
     *
     * @return
     * @throws NException
     */
    public NSingleData retrieveMailMst(String mailId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/sendmail", "/retrieveMailMst");
        dao.bind("MAIL_ID", mailId);

        return dao.executeQueryForSingle();
    }

    /**
     * 메일 발송자 목록 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveMailRecvList(String mailId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/sendmail", "/retrieveMailRecvList");
        dao.bind("MAIL_ID", mailId);

        return dao.executeQuery();
    }

    /**
     * 메일 발송결과 저장
     *
     * @return
     * @throws NException
     */
    public int updateMailSendResult(String mailId, String logSeq, String status, String sndResult) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/sendmail", "/updateMailSendResult");
        dao.bind("MAIL_ID", mailId);
        dao.bind("LOG_SEQ", logSeq);
        dao.bind("STATUS", status);
        dao.bind("SND_RESULT", sndResult);

        return dao.executeUpdate();
    }
}
