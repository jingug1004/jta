package anyfive.ipims.patent.schedule.sendmail.biz;

import javax.mail.Message.RecipientType;

import any.core.config.NConfig;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.log.NLog;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.mail.NMailSender;
import anyfive.ipims.patent.schedule.sendmail.dao.SendMailDao;

public class SendMailBiz extends NAbstractServletBiz
{
    private final boolean isTestMode = NConfig.getBoolean("/config/e-mail/test-mode");

    public SendMailBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메일 발송
     *
     * @return
     * @throws NException
     */
    public boolean executeSendMail() throws NException
    {
        SendMailDao dao = new SendMailDao(this.nsr);

        if (dao.updateMailMstStatusForSend() == 0) return false;

        NMultiData mailList = dao.retrieveWorkingMailMstList();

        for (int i = 0; i < mailList.getRowSize(); i++) {
            try {
                this.sendMail(mailList.getString(i, "MAIL_ID"), mailList.getString(i, "LOG_SEQ"));
            } catch (Exception e) {
            }
        }

        return true;
    }

    private void sendMail(String mailId, String logSeq) throws NException
    {
        SendMailDao dao = new SendMailDao(this.nsr);

        NSingleData mailInfo = dao.retrieveMailMst(mailId);

        if (mailInfo.isEmpty() == true) return;

        String recvType = null;
        String recvAddr = null;
        String recvName = null;

        StringBuffer scheduleLog = new StringBuffer();

        try {

            NMailSender mail = new NMailSender();
            mail.setSubject((this.isTestMode == true ? "[테스트] " : "") + mailInfo.getString("SUBJECT"));
            mail.setFrom(this.getMailAddr(mailInfo.getString("FROM_ADDR")), mailInfo.getString("FROM_NAME"));

            scheduleLog.append("[" + mailId + ". " + mail.getSubject() + "] ");
            scheduleLog.append("FROM : " + mail.getFrom() + " => ");

            if (this.isTestMode == true) {
                mail.addTo(this.getMailAddr(NConfig.getString("/config/e-mail/test-addr")), NConfig.getString("/config/e-mail/test-name"));
            } else {
                NMultiData recvList = dao.retrieveMailRecvList(mailId);
                for (int i = 0; i < recvList.getRowSize(); i++) {
                    recvType = recvList.getString(i, "RECV_TYPE");
                    recvAddr = this.getMailAddr(recvList.getString(i, "RECV_ADDR"));
                    recvName = recvList.getString(i, "RECV_NAME");
                    if (recvType.equals("TO")) {
                        mail.addTo(recvAddr, recvName);
                    } else if (recvType.equals("CC")) {
                        mail.addCc(recvAddr, recvName);
                    } else if (recvType.equals("BCC")) {
                        mail.addBcc(recvAddr, recvName);
                    }
                }
            }

            scheduleLog.append("TO : " + mail.getRecipients(RecipientType.TO));
            scheduleLog.append(", CC : " + mail.getRecipients(RecipientType.TO));
            scheduleLog.append(", BCC : " + mail.getRecipients(RecipientType.BCC));

            mail.setBodyHtml(mailInfo.getString("BODY"));
            mail.send();

            dao.updateMailSendResult(mailId, logSeq, "8", "OK" + (this.isTestMode == true ? " : TEST (" + this.getMailAddr(NConfig.getString("/config/e-mail/test-addr")) + ")" : ""));

            NLog.schedule.writeln("Mail send success. " + scheduleLog.toString());

        } catch (Exception e) {
            dao.updateMailSendResult(mailId, logSeq, "9", e.getMessage());
            NLog.schedule.writeln("Mail send failure. " + scheduleLog.toString() + " => " + e.getMessage());
        } finally {
            this.nsr.commitTrans();
        }
    }

    private String getMailAddr(String addr)
    {
        if (addr.indexOf("@") != -1) return addr;

        return addr + NConfig.getString("/config/e-mail/default-host-name");
    }
}
