package anyfive.ipims.patent.systemmgt.log.mail.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.dao.MailDao;
import anyfive.ipims.patent.systemmgt.log.mail.dao.MailLogDao;

public class MailLogBiz extends NAbstractServletBiz
{
    public MailLogBiz(NServiceResource nsr)
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
        MailLogDao dao = new MailLogDao(this.nsr);

        return dao.retrieveMailLogList(xReq);
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
        MailLogDao dao = new MailLogDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveMailLog(xReq));
        result.set("ds_recvList", dao.retrieveMailLogRecvList(xReq));

        return result;
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
        MailLogDao dao = new MailLogDao(this.nsr);

        return dao.retrieveMailSendLogList(xReq);
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
        MailLogDao dao = new MailLogDao(this.nsr);

        return dao.retrieveMailLogBody(xReq);
    }

    /**
     * 메일 재발송 처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createMailSendLog(AjaxRequest xReq) throws NException
    {
        MailDao dao = new MailDao(this.nsr);

        if (dao.createMailLog(xReq.getParam("MAIL_ID")) == 0) {
            throw new NBizException("[재발송 실패]\n\n아직 대기중인 건이 존재할 수 있습니다.");
        }
    }
}
